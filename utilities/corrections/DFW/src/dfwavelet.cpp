#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <time.h>
#ifdef USE_OPENMP
#include <omp.h>
#endif

#include "dfwavelet.h"

#ifdef USE_CUDA
#include "dfwavelet_kernels.h"
#endif

#define str_eq(s1,s2)  (!strcmp ((s1),(s2)))

/******** Header *********/
static void dffwt3_cpu(struct dfwavelet_plan_s* plan, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn, data_t* in_vx,data_t* in_vy,data_t* in_vz);
static void dfiwt3_cpu(struct dfwavelet_plan_s* plan, data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_wcdf1,data_t* in_wcdf2,data_t* in_wcn);
static void dfsoftthresh_cpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn);

static void dfwavthresh3_cpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
static void dfwavthresh3_spin_cpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);

static void dfwavthresh3_SURE_cpu(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
static void dfwavthresh3_SURE_spin_cpu(struct dfwavelet_plan_s* plan,scalar_t sigma,int spins, int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);

static void dfwavthresh3_SURE_MAD_cpu(struct dfwavelet_plan_s* plan,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
static void dfwavthresh3_SURE_MAD_spin_cpu(struct dfwavelet_plan_s* plan,int spins, int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);


void dflincomb_cpu(struct dfwavelet_plan_s* plan,data_t* wc1,data_t* wc2,data_t* wc3);
void dfunlincomb_cpu(struct dfwavelet_plan_s* plan,data_t* wc1,data_t* wc2,data_t* wc3);

static void fwt3_cpu(struct dfwavelet_plan_s* plan, data_t* out, data_t* in,int dir);
static void iwt3_cpu(struct dfwavelet_plan_s* plan, data_t* out, data_t* in,int dir);
static void softthresh_cpu(struct dfwavelet_plan_s* plan, int length, scalar_t thresh, data_t* in);
static void circshift_cpu(struct dfwavelet_plan_s* plan, data_t *data);
static void circunshift_cpu(struct dfwavelet_plan_s* plan, data_t *data);

static void conv_down_3d(data_t *out, data_t *in, int size1, int skip1, int size2, int skip2, int size3, int skip3, scalar_t *filter, int filterLen);
static void conv_up_3d(data_t *out, data_t *in, int size1, int skip1, int size2, int skip2, int size3, int skip3, scalar_t *filter, int filterLen);
static void add(data_t* out,data_t *in,int maxInd);
static void mult(data_t* in,scalar_t scalar,int maxInd);

static void create_numLevels(struct dfwavelet_plan_s* plan);
static void create_wavelet_sizes(struct dfwavelet_plan_s* plan);
static void create_wavelet_filters(struct dfwavelet_plan_s* plan);
static void count_zeros_cpu(struct dfwavelet_plan_s* plan, data_t* vx, data_t* vy, data_t* vz);
static void get_noise_amp (struct dfwavelet_plan_s* plan);

struct dfwavelet_plan_s* prepare_dfwavelet_plan(int numdims, int* imSize, int* minSize, scalar_t* res,int use_gpu)
{
#ifdef USE_OPENMP
	omp_set_num_threads( omp_get_max_threads() );
#endif
	struct dfwavelet_plan_s* plan = (struct dfwavelet_plan_s*) malloc(sizeof(struct dfwavelet_plan_s));
	plan->use_gpu = use_gpu;
	plan->numdims = numdims;
	plan->imSize = (int*) malloc(sizeof(int)*numdims);
	plan->minSize = (int*) malloc(sizeof(int)*numdims);
	plan->res = (scalar_t*) malloc(sizeof(scalar_t)*numdims);
	plan->percentZero = -1;
	plan->noiseAmp = NULL;
	// Get imSize, numPixel, numdims
	plan->numPixel = 1;
	plan->numPixel = 1;
	int i;
	for (i = 0; i < numdims; i++)
	{
		plan->imSize[i] = imSize[i];
		plan->numPixel *= imSize[i];
		plan->minSize[i] = minSize[i];
		plan->res[i] = res[i];
	}

	create_wavelet_filters(plan);
	create_numLevels(plan);
	create_wavelet_sizes(plan);
	plan->randShift = (int*) malloc(sizeof(int)*plan->numdims);
	memset(plan->randShift,0,sizeof(int)*plan->numdims);
	return plan;
}

void dfwavelet_forward(struct dfwavelet_plan_s* plan, data_t* out_wcdf1, data_t* out_wcdf2, data_t* out_wcn, data_t* in_vx, data_t* in_vy, data_t* in_vz)
{
	if(plan->use_gpu==0)
		dffwt3_cpu(plan,out_wcdf1,out_wcdf2,out_wcn,in_vx,in_vy,in_vz);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dffwt3_gpu(plan,out_wcdf1,out_wcdf2,out_wcn,in_vx,in_vy,in_vz);
	if(plan->use_gpu==2)
		dffwt3_gpuHost(plan,out_wcdf1,out_wcdf2,out_wcn,in_vx,in_vy,in_vz);
#endif
}

void dfwavelet_inverse(struct dfwavelet_plan_s* plan, data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_wcdf1,data_t* in_wcdf2,data_t* in_wcn)
{
	if(plan->use_gpu==0)
		dfiwt3_cpu(plan,out_vx,out_vy,out_vz,in_wcdf1,in_wcdf2,in_wcn);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dfiwt3_gpu(plan,out_vx,out_vy,out_vz,in_wcdf1,in_wcdf2,in_wcn);
	if(plan->use_gpu==2)
		dfiwt3_gpuHost(plan,out_vx,out_vy,out_vz,in_wcdf1,in_wcdf2,in_wcn);
#endif
}

void dfwavelet_thresh(struct dfwavelet_plan_s* plan, scalar_t dfthresh, scalar_t nthresh,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	get_noise_amp(plan);
	if(plan->use_gpu==0)
		dfwavthresh3_cpu(plan,dfthresh,nthresh,out_vx,out_vy,out_vz, in_vx,in_vy,in_vz);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dfwavthresh3_gpu(plan,dfthresh,nthresh, out_vx,out_vy,out_vz, in_vx,in_vy,in_vz);
	if(plan->use_gpu==2)
		dfwavthresh3_gpuHost(plan,dfthresh,nthresh,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#endif
}

void dfsoft_thresh(struct dfwavelet_plan_s* plan, scalar_t dfthresh, scalar_t nthresh,data_t* wcdf1,data_t* wcdf2, data_t* wcn)
{
	get_noise_amp(plan);
	if(plan->use_gpu==0)
		dfsoftthresh_cpu(plan,dfthresh,nthresh,wcdf1,wcdf2,wcn);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dfsoftthresh_gpu(plan,dfthresh,nthresh,wcdf1,wcdf2,wcn);
	if(plan->use_gpu==2)
		dfsoftthresh_gpuHost(plan,dfthresh,nthresh,wcdf1,wcdf2,wcn);
#endif
}

void dfwavelet_thresh_spin(struct dfwavelet_plan_s* plan, scalar_t dfthresh, scalar_t nthresh,int spins, int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	get_noise_amp(plan);
	if(plan->use_gpu==0)
		dfwavthresh3_spin_cpu(plan,dfthresh,nthresh,spins,isRand,out_vx,out_vy,out_vz, in_vx,in_vy,in_vz);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dfwavthresh3_spin_gpu(plan,dfthresh,nthresh,spins,isRand,out_vx,out_vy,out_vz, in_vx,in_vy,in_vz);
	if(plan->use_gpu==2)
		dfwavthresh3_spin_gpuHost(plan,dfthresh,nthresh,spins,isRand,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#endif
}

void dfwavelet_thresh_SURE(struct dfwavelet_plan_s* plan, scalar_t sigma,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	get_noise_amp(plan);
	if(plan->use_gpu==0)
		dfwavthresh3_SURE_cpu(plan,sigma,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dfwavthresh3_SURE_gpu(plan,sigma,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
	if(plan->use_gpu==2)
		dfwavthresh3_SURE_gpuHost(plan,sigma,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#endif
}

void dfwavelet_thresh_SURE_spin(struct dfwavelet_plan_s* plan, scalar_t sigma,int spins,int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	get_noise_amp(plan);
	if(plan->use_gpu==0)
		dfwavthresh3_SURE_spin_cpu(plan,sigma,spins,isRand,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dfwavthresh3_SURE_spin_gpu(plan,sigma,spins,isRand,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
	if(plan->use_gpu==2)
		dfwavthresh3_SURE_spin_gpuHost(plan,sigma,spins,isRand,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#endif
}

void dfwavelet_thresh_SURE_MAD(struct dfwavelet_plan_s* plan,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	get_noise_amp(plan);
	if(plan->use_gpu==0)
		dfwavthresh3_SURE_MAD_cpu(plan,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dfwavthresh3_SURE_MAD_gpu(plan,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
	if(plan->use_gpu==2)
		dfwavthresh3_SURE_MAD_gpuHost(plan,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#endif
}

void dfwavelet_thresh_SURE_MAD_spin(struct dfwavelet_plan_s* plan,int spins,int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	get_noise_amp(plan);
	if(plan->use_gpu==0)
		dfwavthresh3_SURE_MAD_spin_cpu(plan,spins,isRand,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#ifdef USE_CUDA
	if(plan->use_gpu==1)
		dfwavthresh3_SURE_MAD_spin_gpu(plan,spins,isRand,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
	if(plan->use_gpu==2)
		dfwavthresh3_SURE_MAD_spin_gpuHost(plan,spins,isRand,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
#endif
}

int rand_lim(int limit) {

	int divisor = RAND_MAX/(limit+1);
	int retval;

	do { 
		retval = rand() / divisor;
	} while (retval > limit);

	return retval;
}

void dfwavelet_new_randshift (struct dfwavelet_plan_s* plan) {
	int i;
	i = rand();
	for(i = 0; i < plan->numdims; i++) {
		// Determine maximum shift value for this dimension
		int log2dim = 1;
		while( (1<<log2dim) < plan->imSize[i]) {
			log2dim++;
		}
		int maxShift = 1 << (log2dim-plan->numLevels);
		if (maxShift > 8) {
			maxShift = 8;
		}
		// Generate random shift value between 0 and maxShift
		plan->randShift[i] = rand_lim(maxShift);
	}
}

void dfwavelet_clear_randshift (struct dfwavelet_plan_s* plan) {
	memset(plan->randShift, 0, plan->numdims*sizeof(int));
}

void dfwavelet_free(struct dfwavelet_plan_s* plan)
{
	free(plan->imSize);
	free(plan->minSize);
	free(plan->lod0);
	free(plan->lod1);
	free(plan->res);
	free(plan->waveSizes);
	free(plan->randShift);
	if (plan->noiseAmp != NULL)
		free(plan->noiseAmp);
	free(plan);
}

////////////// Private Functions //////////////

void dffwt3_cpu(struct dfwavelet_plan_s* plan, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn, data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
	fwt3_cpu(plan,out_wcdf1,in_vx,0);
	fwt3_cpu(plan,out_wcdf2,in_vy,1);
	fwt3_cpu(plan,out_wcn,in_vz,2);
	mult(out_wcdf1,1/plan->res[0],plan->numCoeff);
	mult(out_wcdf2,1/plan->res[1],plan->numCoeff);
	mult(out_wcn,1/plan->res[2],plan->numCoeff);
	dflincomb_cpu(plan,out_wcdf1,out_wcdf2,out_wcn);
}

void dfiwt3_cpu(struct dfwavelet_plan_s* plan, data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_wcdf1,data_t* in_wcdf2,data_t* in_wcn)
{
	dfunlincomb_cpu(plan,in_wcdf1,in_wcdf2,in_wcn);
	mult(in_wcdf1,plan->res[0],plan->numCoeff);
	mult(in_wcdf2,plan->res[1],plan->numCoeff);
	mult(in_wcn,plan->res[2],plan->numCoeff);
	iwt3_cpu(plan,out_vx,in_wcdf1,0);
	iwt3_cpu(plan,out_vy,in_wcdf2,1);
	iwt3_cpu(plan,out_vz,in_wcn,2);
}
/*
void dfsoftthresh_cpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn)
{
	softthresh_cpu(plan, dfthresh,out_wcdf1);
	softthresh_cpu(plan, dfthresh,out_wcdf2);
	softthresh_cpu(plan, nthresh,out_wcn);
}
*/

void dfsoftthresh_cpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh, data_t* wcdf1,data_t* wcdf2,data_t* wcn)
{
	data_t* HxLyLz1 = wcdf1 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	data_t* HxLyLz2 = wcdf2 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	data_t* HxLyLz3 = wcn + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	int l;
	for (l = 1; l <= plan->numLevels; ++l){
		HxLyLz1 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		HxLyLz2 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		HxLyLz3 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
	}
	int dx = plan->imSize[0];
	int dy = plan->imSize[1];
	int dz = plan->imSize[2];
	int dxNext = plan->waveSizes[0 + 3*plan->numLevels];
	int dyNext = plan->waveSizes[1 + 3*plan->numLevels];
	int dzNext = plan->waveSizes[2 + 3*plan->numLevels];
	int blockSize = dxNext*dyNext*dzNext;
	int naInd = 0;

	for (l = plan->numLevels; l >= 1; --l)
	{
		dxNext = plan->waveSizes[0 + 3*l];
		dyNext = plan->waveSizes[1 + 3*l];
		dzNext = plan->waveSizes[2 + 3*l];
		blockSize = dxNext*dyNext*dzNext;

		HxLyLz1 = HxLyLz1 - 7*blockSize;
		HxLyLz2 = HxLyLz2 - 7*blockSize;
		HxLyLz3 = HxLyLz3 - 7*blockSize;

		int bandInd;
		for (bandInd=0; bandInd<7*3;bandInd++)
		{
			data_t *subband;
			scalar_t lambda;
			if (bandInd<7)
			{
				subband = HxLyLz1 + bandInd*blockSize;
				lambda = dfthresh * plan->noiseAmp[naInd];
			} else if (bandInd<14)
			{
				subband = HxLyLz2 + (bandInd-7)*blockSize;
				lambda = dfthresh * plan->noiseAmp[naInd];
			} else
			{
				subband = HxLyLz3 + (bandInd-14)*blockSize;
				lambda = nthresh * plan->noiseAmp[naInd];
			}

			// SoftThresh
			softthresh_cpu(plan, blockSize, lambda,subband);
			naInd++;
	  
		} 
		dx = dxNext;
		dy = dyNext;
		dz = dzNext;
	}

}

void dfwavthresh3_cpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
	data_t *wcdf1,*wcdf2,*wcn;
	wcdf1 = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);
	wcdf2 = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);
	wcn = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);

	dffwt3_cpu(plan, wcdf1,wcdf2,wcn,in_vx,in_vy,in_vz);
	dfsoftthresh_cpu(plan,dfthresh,nthresh,wcdf1,wcdf2,wcn);
	dfiwt3_cpu(plan,out_vx,out_vy,out_vz,wcdf1,wcdf2,wcn);
  
	free(wcdf1);
	free(wcdf2);
	free(wcn);
}

void dfwavthresh3_spin_cpu(struct dfwavelet_plan_s* plan, scalar_t dfthresh, scalar_t nthresh,int spins,int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	data_t *temp_vx,*temp_vy,*temp_vz;
	temp_vx = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
	temp_vy = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
	temp_vz = (data_t*) malloc(sizeof(data_t)*plan->numPixel);

	int s1,s2,s3;
	for (s1=0;s1<spins;s1++)
		for (s2=0;s2<spins;s2++)
			for (s3=0;s3<spins;s3++)
			{
				if (isRand)
				{
					dfwavelet_new_randshift(plan);
				} else 
				{
					plan->randShift[0] = s1;
					plan->randShift[1] = s2;
					plan->randShift[2] = s3;
				}
				dfwavthresh3_cpu(plan,dfthresh,nthresh,temp_vx,temp_vy,temp_vz,in_vx,in_vy,in_vz);
				add(out_vx,temp_vx,plan->numPixel);
				add(out_vy,temp_vy,plan->numPixel);
				add(out_vz,temp_vz,plan->numPixel);
			}
	mult(out_vx,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
	mult(out_vy,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
	mult(out_vz,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
}

void dfwavthresh3_SURE_cpu(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
	data_t *wcdf1,*wcdf2,*wcn;
	wcdf1 = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);
	wcdf2 = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);
	wcn = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);

	count_zeros_cpu(plan,in_vx,in_vy,in_vz);

	dffwt3_cpu(plan, wcdf1,wcdf2,wcn,in_vx,in_vy,in_vz);
	dfSUREshrink_cpu(plan,sigma,wcdf1,wcdf2,wcn);
	dfiwt3_cpu(plan,out_vx,out_vy,out_vz,wcdf1,wcdf2,wcn);
  
	free(wcdf1);
	free(wcdf2);
	free(wcn);
}

void dfwavthresh3_SURE_spin_cpu(struct dfwavelet_plan_s* plan, scalar_t sigma,int spins,int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	memset(out_vx,0,sizeof(data_t)*plan->numPixel);
	memset(out_vy,0,sizeof(data_t)*plan->numPixel);
	memset(out_vz,0,sizeof(data_t)*plan->numPixel);

	data_t *temp_vx,*temp_vy,*temp_vz;
	temp_vx = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
	temp_vy = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
	temp_vz = (data_t*) malloc(sizeof(data_t)*plan->numPixel);

	int s1,s2,s3;
	for (s1=0;s1<spins;s1++)
		for (s2=0;s2<spins;s2++)
			for (s3=0;s3<spins;s3++)
			{
				plan->randShift[0] = s1;
				plan->randShift[1] = s2;
				plan->randShift[2] = s3;
				dfwavthresh3_SURE_cpu(plan,sigma,temp_vx,temp_vy,temp_vz,in_vx,in_vy,in_vz);
				add(out_vx,temp_vx,plan->numPixel);
				add(out_vy,temp_vy,plan->numPixel);
				add(out_vz,temp_vz,plan->numPixel);
			}
	mult(out_vx,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
	mult(out_vy,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
	mult(out_vz,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
}


void dfwavthresh3_SURE_MAD_cpu(struct dfwavelet_plan_s* plan,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
	data_t *wcdf1,*wcdf2,*wcn;
	wcdf1 = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);
	wcdf2 = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);
	wcn = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);

	count_zeros_cpu(plan,in_vx,in_vy,in_vz);

	dffwt3_cpu(plan, wcdf1,wcdf2,wcn,in_vx,in_vy,in_vz);
	scalar_t sigma = getMADsigma_cpu(plan,wcn);
	dfSUREshrink_cpu(plan,sigma,wcdf1,wcdf2,wcn);
	dfiwt3_cpu(plan,out_vx,out_vy,out_vz,wcdf1,wcdf2,wcn);
  
	free(wcdf1);
	free(wcdf2);
	free(wcn);
}


void dfwavthresh3_SURE_MAD_spin_cpu(struct dfwavelet_plan_s* plan,int spins,int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz)
{
	memset(out_vx,0,sizeof(data_t)*plan->numPixel);
	memset(out_vy,0,sizeof(data_t)*plan->numPixel);
	memset(out_vz,0,sizeof(data_t)*plan->numPixel);

	data_t *temp_vx,*temp_vy,*temp_vz;
	temp_vx = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
	temp_vy = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
	temp_vz = (data_t*) malloc(sizeof(data_t)*plan->numPixel);

	int s1,s2,s3;
	for (s1=0;s1<spins;s1++)
		for (s2=0;s2<spins;s2++)
			for (s3=0;s3<spins;s3++)
			{
				plan->randShift[0] = s1;
				plan->randShift[1] = s2;
				plan->randShift[2] = s3;
				dfwavthresh3_SURE_MAD_cpu(plan,temp_vx,temp_vy,temp_vz,in_vx,in_vy,in_vz);
				add(out_vx,temp_vx,plan->numPixel);
				add(out_vy,temp_vy,plan->numPixel);
				add(out_vz,temp_vz,plan->numPixel);
			}
	mult(out_vx,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
	mult(out_vy,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
	mult(out_vz,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
}

void dflincomb_cpu(struct dfwavelet_plan_s* plan,data_t* wc1,data_t* wc2,data_t* wc3)
{
	data_t* HxLyLz1 = wc1 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	data_t* HxLyLz2 = wc2 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	data_t* HxLyLz3 = wc3 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	int l;
	for (l = 1; l <= plan->numLevels; ++l){
		HxLyLz1 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		HxLyLz2 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		HxLyLz3 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
	}
	int dx = plan->imSize[0];
	int dy = plan->imSize[1];
	int dz = plan->imSize[2];
	int dxNext = plan->waveSizes[0 + 3*plan->numLevels];
	int dyNext = plan->waveSizes[1 + 3*plan->numLevels];
	int dzNext = plan->waveSizes[2 + 3*plan->numLevels];
	int blockSize = dxNext*dyNext*dzNext;
	int i,j,k;

	for (l = plan->numLevels; l >= 1; --l)
	{
		dxNext = plan->waveSizes[0 + 3*l];
		dyNext = plan->waveSizes[1 + 3*l];
		dzNext = plan->waveSizes[2 + 3*l];
		blockSize = dxNext*dyNext*dzNext;

		HxLyLz1 = HxLyLz1 - 7*blockSize;
		HxLyLz2 = HxLyLz2 - 7*blockSize;
		HxLyLz3 = HxLyLz3 - 7*blockSize;
		data_t* LxHyLz1 = HxLyLz1 + blockSize;
		data_t* HxHyLz1 = LxHyLz1 + blockSize;
		data_t* LxLyHz1 = HxHyLz1 + blockSize;
		data_t* HxLyHz1 = LxLyHz1 + blockSize;
		data_t* LxHyHz1 = HxLyHz1 + blockSize;
		data_t* HxHyHz1 = LxHyHz1 + blockSize;

		data_t* LxHyLz2 = HxLyLz2 + blockSize;
		data_t* HxHyLz2 = LxHyLz2 + blockSize;
		data_t* LxLyHz2 = HxHyLz2 + blockSize;
		data_t* HxLyHz2 = LxLyHz2 + blockSize;
		data_t* LxHyHz2 = HxLyHz2 + blockSize;
		data_t* HxHyHz2 = LxHyHz2 + blockSize;

		data_t* LxHyLz3 = HxLyLz3 + blockSize;
		data_t* HxHyLz3 = LxHyLz3 + blockSize;
		data_t* LxLyHz3 = HxHyLz3 + blockSize;
		data_t* HxLyHz3 = LxLyHz3 + blockSize;
		data_t* LxHyHz3 = HxLyHz3 + blockSize;
		data_t* HxHyHz3 = LxHyHz3 + blockSize;
#ifdef USE_OPENMP
#pragma omp parallel for private(i,j,k)
#endif
		for (k=0;k<dzNext;k++)
			for (j=0;j<dyNext;j++)
				for (i=0;i<dxNext;i++)
				{
					int ind = i+j*dxNext+k*dxNext*dyNext;
					data_t wcx100 = HxLyLz1[ind];
					data_t wcy100 = HxLyLz2[ind];
					data_t wcz100 = HxLyLz3[ind];
					data_t wcx010 = LxHyLz1[ind];
					data_t wcy010 = LxHyLz2[ind];
					data_t wcz010 = LxHyLz3[ind];
					data_t wcx001 = LxLyHz1[ind];
					data_t wcy001 = LxLyHz2[ind];
					data_t wcz001 = LxLyHz3[ind];
					data_t wcx110 = HxHyLz1[ind];
					data_t wcy110 = HxHyLz2[ind];
					data_t wcz110 = HxHyLz3[ind];
					data_t wcx101 = HxLyHz1[ind];
					data_t wcy101 = HxLyHz2[ind];
					data_t wcz101 = HxLyHz3[ind];
					data_t wcx011 = LxHyHz1[ind];
					data_t wcy011 = LxHyHz2[ind];
					data_t wcz011 = LxHyHz3[ind];
					data_t wcx111 = HxHyHz1[ind];
					data_t wcy111 = HxHyHz2[ind];
					data_t wcz111 = HxHyHz3[ind];

					HxLyLz1[ind] = wcy100;
					LxHyLz1[ind] = wcx010;
					LxLyHz1[ind] = wcy001;
					HxLyLz2[ind] = wcz100;
					LxHyLz2[ind] = wcz010;
					LxLyHz2[ind] = wcx001;
					HxLyLz3[ind] = wcx100;
					LxHyLz3[ind] = wcy010;
					LxLyHz3[ind] = wcz001;
	      
					HxHyLz1[ind] = 0.5*(wcx110-wcy110);
					HxLyHz1[ind] = 0.5*(wcz101-wcx101);
					LxHyHz1[ind] = 0.5*(wcy011-wcz011);
					HxHyLz2[ind] = wcz110;
					HxLyHz2[ind] = wcy101;
					LxHyHz2[ind] = wcx011;
					HxHyLz3[ind] = 0.5*(wcx110+wcy110);
					HxLyHz3[ind] = 0.5*(wcz101+wcx101);
					LxHyHz3[ind] = 0.5*(wcy011+wcz011);
	      
					HxHyHz1[ind] = 1/3.*(-2*wcx111+wcy111+wcz111);
					HxHyHz2[ind] = 1/3.*(-wcx111+2*wcy111-wcz111);
					HxHyHz3[ind] = 1/3.*(wcx111+wcy111+wcz111);
				}
#ifdef USE_OPENMP
#pragma omp barrier
#pragma omp parallel for private(i,j,k)
#endif
		for (k=0;k<dzNext;k++)
			for (j=0;j<dyNext;j++)
				for (i=0;i<dxNext;i++)
				{
					int ind = i+j*dxNext+k*dxNext*dyNext;
					int indxs = ind-1;
					int indys = ind-dxNext;
					int indzs = ind-dxNext*dyNext;
					if (i==0)
						indxs = 0;
					if (j==0)
						indys = 0;
					if (k==0)
						indzs = 0;
					data_t wcy100 = HxLyLz1[ind];
					data_t wcy100s = HxLyLz1[indys];
					data_t wcz100 = HxLyLz2[ind];
					data_t wcz100s = HxLyLz2[indzs];
					data_t wcx010 = LxHyLz1[ind];
					data_t wcx010s = LxHyLz1[indxs];
					data_t wcz010 = LxHyLz2[ind];
					data_t wcz010s = LxHyLz2[indzs];
					data_t wcx001 = LxLyHz2[ind];
					data_t wcx001s = LxLyHz2[indxs];
					data_t wcy001 = LxLyHz1[ind];
					data_t wcy001s = LxLyHz1[indys];
					data_t wcz110 = HxHyLz2[ind];
					data_t wcz110s = HxHyLz2[indzs];
					data_t wcy101 = HxLyHz2[ind];
					data_t wcy101s = HxLyHz2[indys];
					data_t wcx011 = LxHyHz2[ind];
					data_t wcx011s = LxHyHz2[indxs];
	      
					HxLyLz3[ind] = HxLyLz3[ind]+0.25*(wcy100-wcy100s+wcz100-wcz100s);
					LxHyLz3[ind] = LxHyLz3[ind]+0.25*(wcx010-wcx010s+wcz010-wcz010s);
					LxLyHz3[ind] = LxLyHz3[ind]+0.25*(wcx001-wcx001s+wcy001-wcy001s);
	      
					HxHyLz3[ind] = HxHyLz3[ind] + 0.125*(wcz110-wcz110s);
					HxLyHz3[ind] = HxLyHz3[ind] + 0.125*(wcy101-wcy101s);
					LxHyHz3[ind] = LxHyHz3[ind] + 0.125*(wcx011-wcx011s);
	      
				}
      
		dx = dxNext;
		dy = dyNext;
		dz = dzNext;
	}
}

void dfunlincomb_cpu(struct dfwavelet_plan_s* plan,data_t* wc1,data_t* wc2,data_t* wc3)
{
	data_t* HxLyLz1 = wc1 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	data_t* HxLyLz2 = wc2 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	data_t* HxLyLz3 = wc3 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	int l;
	for (l = 1; l <= plan->numLevels; ++l){
		HxLyLz1 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		HxLyLz2 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		HxLyLz3 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
	}
	int dx = plan->imSize[0];
	int dy = plan->imSize[1];
	int dz = plan->imSize[2];
	int dxNext = plan->waveSizes[0 + 3*plan->numLevels];
	int dyNext = plan->waveSizes[1 + 3*plan->numLevels];
	int dzNext = plan->waveSizes[2 + 3*plan->numLevels];
	int blockSize = dxNext*dyNext*dzNext;
	int i,j,k;

	for (l = plan->numLevels; l >= 1; --l)
	{
		dxNext = plan->waveSizes[0 + 3*l];
		dyNext = plan->waveSizes[1 + 3*l];
		dzNext = plan->waveSizes[2 + 3*l];
		blockSize = dxNext*dyNext*dzNext;

		HxLyLz1 = HxLyLz1 - 7*blockSize;
		HxLyLz2 = HxLyLz2 - 7*blockSize;
		HxLyLz3 = HxLyLz3 - 7*blockSize;
		data_t* LxHyLz1 = HxLyLz1 + blockSize;
		data_t* HxHyLz1 = LxHyLz1 + blockSize;
		data_t* LxLyHz1 = HxHyLz1 + blockSize;
		data_t* HxLyHz1 = LxLyHz1 + blockSize;
		data_t* LxHyHz1 = HxLyHz1 + blockSize;
		data_t* HxHyHz1 = LxHyHz1 + blockSize;

		data_t* LxHyLz2 = HxLyLz2 + blockSize;
		data_t* HxHyLz2 = LxHyLz2 + blockSize;
		data_t* LxLyHz2 = HxHyLz2 + blockSize;
		data_t* HxLyHz2 = LxLyHz2 + blockSize;
		data_t* LxHyHz2 = HxLyHz2 + blockSize;
		data_t* HxHyHz2 = LxHyHz2 + blockSize;

		data_t* LxHyLz3 = HxLyLz3 + blockSize;
		data_t* HxHyLz3 = LxHyLz3 + blockSize;
		data_t* LxLyHz3 = HxHyLz3 + blockSize;
		data_t* HxLyHz3 = LxLyHz3 + blockSize;
		data_t* LxHyHz3 = HxLyHz3 + blockSize;
		data_t* HxHyHz3 = LxHyHz3 + blockSize;

#ifdef USE_OPENMP
#pragma omp parallel for private(i,j,k)
#endif
		for (k=0;k<dzNext;k++)
			for (j=0;j<dyNext;j++)
				for (i=0;i<dxNext;i++)
				{
					int ind = i+j*dxNext+k*dxNext*dyNext;
					data_t df1_100 = HxLyLz1[ind];
					data_t df2_100 = HxLyLz2[ind];
					data_t n_100 = HxLyLz3[ind];
					data_t df1_010 = LxHyLz1[ind];
					data_t df2_010 = LxHyLz2[ind];
					data_t n_010 = LxHyLz3[ind];
					data_t df1_001 = LxLyHz1[ind];
					data_t df2_001 = LxLyHz2[ind];
					data_t n_001 = LxLyHz3[ind];
					data_t df1_110 = HxHyLz1[ind];
					data_t df2_110 = HxHyLz2[ind];
					data_t n_110 = HxHyLz3[ind];
					data_t df1_101 = HxLyHz1[ind];
					data_t df2_101 = HxLyHz2[ind];
					data_t n_101 = HxLyHz3[ind];
					data_t df1_011 = LxHyHz1[ind];
					data_t df2_011 = LxHyHz2[ind];
					data_t n_011 = LxHyHz3[ind];
					data_t df1_111 = HxHyHz1[ind];
					data_t df2_111 = HxHyHz2[ind];
					data_t n_111 = HxHyHz3[ind];

					HxLyLz2[ind] = df1_100;
					LxHyLz1[ind] = df1_010;
					LxLyHz2[ind] = df1_001;
					HxLyLz3[ind] = df2_100;
					LxHyLz3[ind] = df2_010;
					LxLyHz1[ind] = df2_001;
					HxLyLz1[ind] = n_100;
					LxHyLz2[ind] = n_010;
					LxLyHz3[ind] = n_001;

					HxHyLz3[ind] = df2_110;
					HxLyHz2[ind] = df2_101;
					LxHyHz1[ind] = df2_011;
					HxHyLz1[ind] = (df1_110+n_110);
					HxLyHz3[ind] = (df1_101+n_101);
					LxHyHz2[ind] = (df1_011+n_011);
					HxHyLz2[ind] = (-df1_110+n_110);
					HxLyHz1[ind] = (-df1_101+n_101);
					LxHyHz3[ind] = (-df1_011+n_011);

					HxHyHz1[ind] = (-df1_111+n_111);
					HxHyHz2[ind] = (df2_111+n_111);
					HxHyHz3[ind] = df1_111-df2_111+n_111;
				}

#ifdef USE_OPENMP
#pragma omp barrier
#pragma omp parallel for private(i,j,k)
#endif
		for (k=0;k<dzNext;k++)
			for (j=0;j<dyNext;j++)
				for (i=0;i<dxNext;i++)
				{
					int ind = i+j*dxNext+k*dxNext*dyNext;
					int indxs = ind-1;
					int indys = ind-dxNext;
					int indzs = ind-dxNext*dyNext;
					if (i==0)
						indxs = 0;
					if (j==0)
						indys = 0;
					if (k==0)
						indzs = 0;

					data_t df1_100 = HxLyLz2[ind];
					data_t df1_100s = HxLyLz2[indys];
					data_t df2_100 = HxLyLz3[ind];
					data_t df2_100s = HxLyLz3[indzs];
					data_t df1_010 = LxHyLz1[ind];
					data_t df1_010s = LxHyLz1[indxs];
					data_t df2_010 = LxHyLz3[ind];
					data_t df2_010s = LxHyLz3[indzs];
					data_t df2_001 = LxLyHz1[ind];
					data_t df2_001s = LxLyHz1[indxs];
					data_t df1_001 = LxLyHz2[ind];
					data_t df1_001s = LxLyHz2[indys];

					data_t df2_110 = HxHyLz3[ind];
					data_t df2_110s = HxHyLz3[indzs];
					data_t df2_101 = HxLyHz2[ind];
					data_t df2_101s = HxLyHz2[indys];
					data_t df2_011 = LxHyHz1[ind];
					data_t df2_011s = LxHyHz1[indxs];
	      
					HxLyLz1[ind] = HxLyLz1[ind]-0.25*(df1_100-df1_100s+df2_100-df2_100s);
					LxHyLz2[ind] = LxHyLz2[ind]-0.25*(df1_010-df1_010s+df2_010-df2_010s);
					LxLyHz3[ind] = LxLyHz3[ind]-0.25*(df2_001-df2_001s+df1_001-df1_001s);
	      
					HxHyLz1[ind] = HxHyLz1[ind] - 0.125*(df2_110-df2_110s);
					HxLyHz3[ind] = HxLyHz3[ind] - 0.125*(df2_101-df2_101s);
					LxHyHz2[ind] = LxHyHz2[ind] - 0.125*(df2_011-df2_011s);

					HxHyLz2[ind] = HxHyLz2[ind] - 0.125*(df2_110-df2_110s);
					HxLyHz1[ind] = HxLyHz1[ind] - 0.125*(df2_101-df2_101s);
					LxHyHz3[ind] = LxHyHz3[ind] - 0.125*(df2_011-df2_011s);
				}
      
		dx = dxNext;
		dy = dyNext;
		dz = dzNext;
	}
}

int compare (const void * a, const void * b)
{
	if ( *(scalar_t*)a <  *(scalar_t*)b ) return -1;
	if ( *(scalar_t*)a == *(scalar_t*)b ) return 0;
	if ( *(scalar_t*)a >  *(scalar_t*)b ) return 1;
	return 0;
}

// Use Median Absolute Deviation on the last subband to estimate sigma
// MAD = median(abs(x_i-median(x_i))). Assume median(x_i) = 0, MAD = median(abs(x_i));
// sigma = 1.4826*MAD
scalar_t getMADsigma_cpu(struct dfwavelet_plan_s* plan, data_t* wcn)
{
	get_noise_amp(plan);
	data_t* subband = wcn + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	int l;
	for (l = 1; l <= plan->numLevels; ++l){
		subband += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
	}

	int dx = plan->waveSizes[0 + 3*plan->numLevels];
	int dy = plan->waveSizes[1 + 3*plan->numLevels];
	int dz = plan->waveSizes[2 + 3*plan->numLevels];
	int blockSize = dx*dy*dz;
	int numZeros = (int) (plan->percentZero*blockSize);
	int num = blockSize-numZeros;
	subband = subband - blockSize;

	scalar_t *subband2 = (scalar_t *) malloc(sizeof(scalar_t)*blockSize);
	int i;
	for (i=0;i<blockSize;i++)
	{
		scalar_t t = fabs(subband[i]);
		subband2[i] = t*t;
	}
	qsort(subband2,blockSize,sizeof(data_t),compare);
	scalar_t sigma = 1.4826*sqrt(subband2[numZeros+num/2]);
	// Scale by 1/noiseAMP for that subband
	sigma = sigma/plan->noiseAmp[20];
	free(subband2);
	return sigma;
}

void dfSUREshrink_cpu(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* wcdf1,data_t* wcdf2,data_t* wcn)
{
	get_noise_amp(plan);
	scalar_t percentZero = plan->percentZero;
	data_t* HxLyLz1 = wcdf1 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	data_t* HxLyLz2 = wcdf2 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	data_t* HxLyLz3 = wcn + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	int l;
	for (l = 1; l <= plan->numLevels; ++l){
		HxLyLz1 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		HxLyLz2 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		HxLyLz3 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
	}
	int dx = plan->imSize[0];
	int dy = plan->imSize[1];
	int dz = plan->imSize[2];
	int dxNext = plan->waveSizes[0 + 3*plan->numLevels];
	int dyNext = plan->waveSizes[1 + 3*plan->numLevels];
	int dzNext = plan->waveSizes[2 + 3*plan->numLevels];
	int blockSize = dxNext*dyNext*dzNext;
	int naInd = 0;

	for (l = plan->numLevels; l >= 1; --l)
	{
		dxNext = plan->waveSizes[0 + 3*l];
		dyNext = plan->waveSizes[1 + 3*l];
		dzNext = plan->waveSizes[2 + 3*l];
		blockSize = dxNext*dyNext*dzNext;

		HxLyLz1 = HxLyLz1 - 7*blockSize;
		HxLyLz2 = HxLyLz2 - 7*blockSize;
		HxLyLz3 = HxLyLz3 - 7*blockSize;

		int bandInd;
		scalar_t *subband2 = (scalar_t*) malloc(sizeof(data_t)*blockSize);
#ifdef USE_OPENMP
#pragma omp parallel for private(bandInd)
#endif
		for (bandInd=0; bandInd<7*3;bandInd++)
		{
			data_t *subband;
			if (bandInd<7)
			{
				subband = HxLyLz1 + bandInd*blockSize;
			} else if (bandInd<14)
			{
				subband = HxLyLz2 + (bandInd-7)*blockSize;
			} else
			{
				subband = HxLyLz3 + (bandInd-14)*blockSize;
			}
			// Scale sigma by noise amplifiction in each subband
			scalar_t sigma_band = sigma*plan->noiseAmp[naInd];
			scalar_t sigma2 = sigma_band*sigma_band;

			// Get Energy and Density
			int i;
			scalar_t ener=0;
			for (i=0;i<blockSize;i++)
			{
				scalar_t t = fabs(subband[i]);
				subband2[i] = t*t;
				ener += t*t;
			}
			qsort(subband2,blockSize,sizeof(data_t),compare);

			// N = blockSize*(1-%zero)
			int numZeros = (int) (percentZero*blockSize);
			int num = blockSize-numZeros;

			scalar_t thresh=0;
			// Choose visuShrink or sureShrink
			/*scalar_t density = (ener/num/sigma2-1);
			  scalar_t critical = (scalar_t) pow(log2 ((double) num),1.5)/sqrt(num);
			  if (density < critical)
			  {
			  thresh = sqrt(sigma2*2*log(num)); //visuShrink
			  } else*/
			{
				// Get optimal SURE threshold
				scalar_t min_risk = 3e38;
				scalar_t cum_sum = 0;
				int sureInd;
				for(i=numZeros;i<blockSize;i++)
				{
					scalar_t t2 = subband2[i];
					scalar_t risk = -( 2*sigma2*(i-numZeros+1))+cum_sum+t2*(blockSize-i-1);
					cum_sum = cum_sum + t2;
					if (risk < min_risk)
					{
						min_risk = risk;
						thresh = sqrt(t2);
						sureInd = i;
					}
				}
				if (thresh> (scalar_t) sqrt(sigma2 * 2.0 * log( (scalar_t) num)))
					thresh = (scalar_t)  sqrt(sigma2 * 2.0 *  log( (scalar_t) num));
			}

			// SoftThresh
			for(i=0;i<blockSize;i++)
			{
				scalar_t norm = fabs(subband[i]);
				scalar_t red = norm - thresh;
				subband[i] = (red > 0.) ? ((red / norm) * (subband[i])) : 0.;
			}	 
			naInd++;
	  
		} 
      
		free(subband2);
		dx = dxNext;
		dy = dyNext;
		dz = dzNext;
	}
}

void fwt3_cpu(struct dfwavelet_plan_s* plan, data_t* coeff, data_t* inImage,int dir)
{
	circshift_cpu(plan,inImage);
	data_t* origInImage = inImage;
	data_t* HxLyLz = coeff + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
	int l;
	for (l = 1; l <= plan->numLevels; ++l){
		HxLyLz += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
	}
	int dx = plan->imSize[0];
	int dy = plan->imSize[1];
	int dz = plan->imSize[2];
	int dxNext = plan->waveSizes[0 + 3*plan->numLevels];
	int dyNext = plan->waveSizes[1 + 3*plan->numLevels];
	int dzNext = plan->waveSizes[2 + 3*plan->numLevels];
	int blockSize = dxNext*dyNext*dzNext;

	data_t* LxLyLz = (data_t*) malloc(sizeof(data_t)*blockSize);
	data_t* tempz = (data_t*) malloc(sizeof(data_t)*dx*dy*dzNext);
	data_t* tempyz = (data_t*) malloc(sizeof(data_t)*dx*dyNext*dzNext);
	data_t* tempxyz = (data_t*) malloc(sizeof(data_t)*blockSize);

	// Assign Filters
	scalar_t *lodx,*lody,*lodz,*hidx,*hidy,*hidz;
	lodx = plan->lod0;
	lody = plan->lod0;
	lodz = plan->lod0;
	hidx = plan->hid0;
	hidy = plan->hid0;
	hidz = plan->hid0;
	if (dir==0)
	{
		lodx = plan->lod1;
		hidx = plan->hid1;
	}
	if (dir==1)
	{
		lody = plan->lod1;
		hidy = plan->hid1;
	}
	if (dir==2)
	{
		lodz = plan->lod1;
		hidz = plan->hid1;
	}

	for (l = plan->numLevels; l >= 1; --l)
	{
		dxNext = plan->waveSizes[0 + 3*l];
		dyNext = plan->waveSizes[1 + 3*l];
		dzNext = plan->waveSizes[2 + 3*l];
		blockSize = dxNext*dyNext*dzNext;

		HxLyLz = HxLyLz - 7*blockSize;
		data_t* LxHyLz = HxLyLz + blockSize;
		data_t* HxHyLz = LxHyLz + blockSize;
		data_t* LxLyHz = HxHyLz + blockSize;
		data_t* HxLyHz = LxLyHz + blockSize;
		data_t* LxHyHz = HxLyHz + blockSize;
		data_t* HxHyHz = LxHyHz + blockSize;

		int dxy = dx*dy;
		int newdz = (dz + plan->filterLen-1) / 2;
		int newdy = (dy + plan->filterLen-1) / 2;
		int newdxy = dx*newdy;

		// Lz
		conv_down_3d(tempz, inImage, dz, dxy, dx, 1, dy, dx, lodz,plan->filterLen);
		// LyLz
		conv_down_3d(tempyz, tempz, dy, dx, dx, 1, newdz, dxy, lody,plan->filterLen);
		conv_down_3d(LxLyLz, tempyz, dx, 1, newdy, dx, newdz, newdxy, lodx,plan->filterLen);
		conv_down_3d(HxLyLz, tempyz, dx, 1, newdy, dx, newdz, newdxy, hidx,plan->filterLen);
		// HyLz
		conv_down_3d(tempyz, tempz, dy, dx, dx, 1, newdz, dxy, hidy,plan->filterLen);
		conv_down_3d(LxHyLz, tempyz, dx, 1, newdy, dx, newdz, newdxy, lodx,plan->filterLen);
		conv_down_3d(HxHyLz, tempyz, dx, 1, newdy, dx, newdz, newdxy, hidx,plan->filterLen);
		// Hz
		conv_down_3d(tempz, inImage, dz, dxy, dx, 1, dy, dx, hidz,plan->filterLen);
		// LyHz
		conv_down_3d(tempyz, tempz, dy, dx, dx, 1, newdz, dxy, lody,plan->filterLen);
		conv_down_3d(LxLyHz, tempyz, dx, 1, newdy, dx, newdz, newdxy, lodx,plan->filterLen);
		conv_down_3d(HxLyHz, tempyz, dx, 1, newdy, dx, newdz, newdxy, hidx,plan->filterLen);
		// HyHz
		conv_down_3d(tempyz, tempz, dy, dx, dx, 1, newdz, dxy, hidy,plan->filterLen);
		conv_down_3d(LxHyHz, tempyz, dx, 1, newdy, dx, newdz, newdxy, lodx,plan->filterLen);
		conv_down_3d(HxHyHz, tempyz, dx, 1, newdy, dx, newdz, newdxy, hidx,plan->filterLen);

		memcpy(tempxyz, LxLyLz, blockSize*sizeof(data_t));
		inImage = tempxyz;
		dx = dxNext;
		dy = dyNext;
		dz = dzNext;
	}

	// Final LxLyLz
	memcpy(coeff, inImage, plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2]*sizeof(data_t));
	free(LxLyLz);
	free(tempz);
	free(tempyz);
	free(tempxyz);
	circunshift_cpu(plan,origInImage);
}

void iwt3_cpu(struct dfwavelet_plan_s* plan, data_t* outImage, data_t* coeff,int dir)
{
	// Workspace dimensions
	int dxWork = plan->waveSizes[0 + 3*plan->numLevels]*2-1 + plan->filterLen-1;
	int dyWork = plan->waveSizes[1 + 3*plan->numLevels]*2-1 + plan->filterLen-1;
	int dzWork = plan->waveSizes[2 + 3*plan->numLevels]*2-1 + plan->filterLen-1;
	int dyWork2 = plan->waveSizes[1 + 3*(plan->numLevels-1)]*2-1 + plan->filterLen-1;
	int dzWork2 = plan->waveSizes[2 + 3*(plan->numLevels-1)]*2-1 + plan->filterLen-1;
	// Workspace
	data_t* tempyz = (data_t*) malloc(sizeof(data_t)*dxWork*dyWork2*dzWork2);
	data_t* tempz =  (data_t*) malloc(sizeof(data_t)*dxWork*dyWork*dzWork2);
	data_t* tempFull =  (data_t*) malloc(sizeof(data_t)*dxWork*dyWork*dzWork);

	int dx = plan->waveSizes[0];
	int dy = plan->waveSizes[1];
	int dz = plan->waveSizes[2];

	// Assign Filters
	scalar_t *lorx,*lory,*lorz,*hirx,*hiry,*hirz;
	lorx = plan->lor0;
	lory = plan->lor0;
	lorz = plan->lor0;
	hirx = plan->hir0;
	hiry = plan->hir0;
	hirz = plan->hir0;
	if (dir==0)
	{
		lorx = plan->lor1;
		hirx = plan->hir1;
	}
	if (dir==1)
	{
		lory = plan->lor1;
		hiry = plan->hir1;
	}
	if (dir==2)
	{
		lorz = plan->lor1;
		hirz = plan->hir1;
	}

	memcpy(outImage, coeff, dx*dy*dz*sizeof(data_t));
	data_t* HxLyLz = coeff + dx*dy*dz;
	int level;
	for (level = 1; level < plan->numLevels+1; ++level)
	{
		dx = plan->waveSizes[0 + 3*level];
		dy = plan->waveSizes[1 + 3*level];
		dz = plan->waveSizes[2 + 3*level];
		int blockSize = dx*dy*dz;

		data_t* LxHyLz = HxLyLz + blockSize;
		data_t* HxHyLz = LxHyLz + blockSize;
		data_t* LxLyHz = HxHyLz + blockSize;
		data_t* HxLyHz = LxLyHz + blockSize;
		data_t* LxHyHz = HxLyHz + blockSize;
		data_t* HxHyHz = LxHyHz + blockSize;
		data_t* LxLyLz = outImage;

		int newdx = 2*dx-1 + plan->filterLen-1;
		int newdy = 2*dy-1 + plan->filterLen-1;
		int newdz = 2*dz-1 + plan->filterLen-1;
		int dxy = dx*dy;
		int newdxy = newdx*dy;
		int newnewdxy = newdx*newdy;

		memset(tempFull, 0, newnewdxy*newdz*sizeof(data_t));
		memset(tempz, 0, newnewdxy*dz*sizeof(data_t));
		memset(tempyz, 0, newdxy*dz*sizeof(data_t));
		conv_up_3d(tempyz, LxLyLz, dx, 1, dy, dx, dz, dxy, lorx,plan->filterLen);
		conv_up_3d(tempyz, HxLyLz, dx, 1, dy, dx, dz, dxy, hirx,plan->filterLen);
		conv_up_3d(tempz, tempyz, dy, newdx, newdx, 1, dz, newdxy, lory,plan->filterLen);

		memset(tempyz, 0, newdxy*dz*sizeof(data_t));
		conv_up_3d(tempyz, LxHyLz, dx, 1, dy, dx, dz, dxy, lorx,plan->filterLen);
		conv_up_3d(tempyz, HxHyLz, dx, 1, dy, dx, dz, dxy, hirx,plan->filterLen);
		conv_up_3d(tempz, tempyz, dy, newdx, newdx, 1, dz, newdxy, hiry,plan->filterLen);
		conv_up_3d(tempFull, tempz, dz, newnewdxy, newdx, 1, newdy, newdx, lorz,plan->filterLen);

		memset(tempz, 0, newnewdxy*dz*sizeof(data_t));
		memset(tempyz, 0, newdxy*dz*sizeof(data_t));
		conv_up_3d(tempyz, LxLyHz, dx, 1, dy, dx, dz, dxy, lorx,plan->filterLen);
		conv_up_3d(tempyz, HxLyHz, dx, 1, dy, dx, dz, dxy, hirx,plan->filterLen);
		conv_up_3d(tempz, tempyz, dy, newdx, newdx, 1, dz, newdxy, lory,plan->filterLen);

		memset(tempyz, 0, newdxy*dz*sizeof(data_t));
		conv_up_3d(tempyz, LxHyHz, dx, 1, dy, dx, dz, dxy, lorx,plan->filterLen);
		conv_up_3d(tempyz, HxHyHz, dx, 1, dy, dx, dz, dxy, hirx,plan->filterLen);
		conv_up_3d(tempz, tempyz, dy, newdx, newdx, 1, dz, newdxy, hiry,plan->filterLen);

		conv_up_3d(tempFull, tempz, dz, newnewdxy, newdx, 1, newdy, newdx, hirz,plan->filterLen);

		// Crop center of workspace
		int dxNext = plan->waveSizes[0+3*(level+1)];
		int dyNext = plan->waveSizes[1+3*(level+1)];
		int dzNext = plan->waveSizes[2+3*(level+1)];
		int dxyNext = dxNext*dyNext;
		dxWork = (2*dx-1 + plan->filterLen-1);
		dyWork = (2*dy-1 + plan->filterLen-1);
		dzWork = (2*dz-1 + plan->filterLen-1);
		int dxyWork = dxWork*dyWork;
		int xOffset = (int) ((dxWork - dxNext) / 2.0);
		int yOffset = (int) ((dyWork - dyNext) / 2.0);
		int zOffset = (int) ((dzWork - dzNext) / 2.0);
		int k,j;
		for (k = 0; k < dzNext; ++k){
			for (j = 0; j < dyNext; ++j){
				memcpy(outImage+j*dxNext + k*dxyNext, tempFull+xOffset + (yOffset+j)*dxWork + (zOffset+k)*dxyWork, dxNext*sizeof(data_t));
			}
		}
		HxLyLz += 7*blockSize;
	}
	free(tempyz);
	free(tempz);
	free(tempFull);
	circunshift_cpu(plan,outImage);
}

void softthresh_cpu(struct dfwavelet_plan_s* plan, int length, scalar_t thresh, data_t* coeff)
{
	int i;
#ifdef USE_OPENMP
#pragma omp parallel for
#endif
	for(i = 0; i < length; i++)
	{
		scalar_t norm = fabs(coeff[i]);
		scalar_t red = norm - thresh;
		coeff[i] = (red > 0.) ? ((red / norm) * (coeff[i])) : 0.;
	}
}

void circshift_cpu(struct dfwavelet_plan_s* plan, data_t *data) {
	// Return if no shifts
	int zeroShift = 1;
	int i;
	for (i = 0; i< plan->numdims; i++)
	{
		zeroShift &= (plan->randShift[i]==0);
	}
	if(zeroShift) {
		return;
	}
	// Copy data
	data_t* dataCopy = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
	memcpy(dataCopy, data, plan->numPixel*sizeof(data_t));
	if (plan->numdims==2)
	{
		int dx,dy,r0,r1,j,i,index,indexShifted;
		dx = plan->imSize[0];
		dy = plan->imSize[1];
		r0 = plan->randShift[0];
		r1 = plan->randShift[1];
#ifdef USE_OPENMP
#pragma omp parallel for private(index, j, i,indexShifted)
#endif
		for(j = 0; j < dy; j++) {
			for(i = 0; i < dx; i++) {
				index = i+j*dx;
				indexShifted = (((i+r0) + (j+r1)*dx)%(dx*dy)+dx*dy)%(dx*dy);
				data[indexShifted] = dataCopy[index];
			}
		}
	}
	if (plan->numdims==3)
	{
		int dx,dy,dz,r0,r1,r2,k,j,i,index,indexShifted;
		dx = plan->imSize[0];
		dy = plan->imSize[1];
		dz = plan->imSize[2];
		r0 = plan->randShift[0];
		r1 = plan->randShift[1];
		r2 = plan->randShift[2];
#ifdef USE_OPENMP
#pragma omp parallel for private(index, k, j, i,indexShifted)
#endif
		for (k = 0; k < dz; k++) {
			for(j = 0; j < dy; j++) {
				for(i = 0; i < dx; i++) {
					index = i+j*dx+k*dx*dy;
					indexShifted = ((i+r0 + (j+r1)*dx + (k+r2)*dx*dy)%(dx*dy*dz)+(dx*dy*dz))%(dx*dy*dz);
					data[indexShifted] = dataCopy[index];
				}
			}
		}
	}
#ifdef USE_OPENMP
#pragma omp barrier
#endif

	free(dataCopy);
}

void circunshift_cpu(struct dfwavelet_plan_s* plan, data_t *data) {
	// Return if no shifts
	int zeroShift = 1;
	int i;
	for (i = 0; i< plan->numdims; i++)
	{
		zeroShift &= (plan->randShift[i]==0);
	}
	if(zeroShift) {
		return;
	}

	// Copy data
	data_t* dataCopy = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
	memcpy(dataCopy, data, plan->numPixel*sizeof(data_t));
	if (plan->numdims==2)
	{
		int dx,dy,r0,r1,j,i,index,indexShifted;
		dx = plan->imSize[0];
		dy = plan->imSize[1];
		r0 = plan->randShift[0];
		r1 = plan->randShift[1];
#ifdef USE_OPENMP
#pragma omp parallel for private(index, j, i,indexShifted)
#endif
		for(j = 0; j < dy; j++) {
			for(i = 0; i < dx; i++) {
				index = i+j*dx;
				indexShifted = (((i+r0) + (j+r1)*dx)%(dx*dy)+dx*dy)%(dx*dy);
				data[index] = dataCopy[indexShifted];
			}
		}
	}
	if (plan->numdims==3)
	{
		int dx,dy,dz,r0,r1,r2,k,j,i,index,indexShifted;
		dx = plan->imSize[0];
		dy = plan->imSize[1];
		dz = plan->imSize[2];
		r0 = plan->randShift[0];
		r1 = plan->randShift[1];
		r2 = plan->randShift[2];
#ifdef USE_OPENMP
#pragma omp parallel for private(index, k, j, i,indexShifted)
#endif
		for (k = 0; k < dz; k++) {
			for(j = 0; j < dy; j++) {
				for(i = 0; i < dx; i++) {
					index = i+j*dx+k*dx*dy;
					indexShifted = ((i+r0 + (j+r1)*dx + (k+r2)*dx*dy)%(dx*dy*dz)+(dx*dy*dz))%(dx*dy*dz);
					data[index] = dataCopy[indexShifted];
				}
			}
		}
	}

	free(dataCopy);
}

/********** Helper Function *********/
void conv_down_3d(data_t *out, data_t *in,
		  int size1, int skip1, int size2, int skip2, int size3, int skip3,
		  scalar_t *filter, int filterLen)
{
	int outSize1 = (size1 + filterLen-1) / 2;

	// Adjust out skip 2 and 3 if needed
	int outSkip2;
	if(skip2 > skip1) {
		outSkip2 = outSize1*skip2/size1;
	}
	else {
		outSkip2 = skip2;
	}
	int outSkip3;
	if(skip3 > skip1) {
		outSkip3 = outSize1*skip3/size1;
	}
	else {
		outSkip3 = skip3;
	}
	int i32;
#ifdef USE_OPENMP
#pragma omp parallel for
#endif
	for (i32 = 0; i32 < size2*size3; ++i32)
	{
		int i2 = i32 % size2;
		int i3 = i32 / size2;
		int i1;
		for (i1 = 0; i1 < outSize1; ++i1)
		{
			out[i3*outSkip3 + i2*outSkip2 + i1*skip1] = 0.0f;
			int k;
			for (k = 0; k < filterLen; ++k)
			{
				int out_i1 = 2*i1+1 - (filterLen-1) + k;
				if (out_i1 < 0) out_i1 = -out_i1-1;
				if (out_i1 >= size1) out_i1 = size1-1 - (out_i1-size1);

				out[i3*outSkip3 + i2*outSkip2 + i1*skip1] += in[i3*skip3 + i2*skip2 + out_i1*skip1] * filter[filterLen-1-k];
			}
		}
	}
}

void conv_up_3d(data_t *out, data_t *in,
		int size1, int skip1, int size2, int skip2, int size3, int skip3,
		scalar_t *filter, int filterLen)
{
	int outSize1 = 2*size1-1 + filterLen-1;

	// Adjust out skip 2 and 3 if needed
	int outSkip2;
	if(skip2 > skip1) {
		outSkip2 = outSize1*skip2/size1;
	}
	else {
		outSkip2 = skip2;
	}
	int outSkip3;
	if(skip3 > skip1) {
		outSkip3 = outSize1*skip3/size1;
	}
	else {
		outSkip3 = skip3;
	}
	int i32;
#ifdef USE_OPENMP
#pragma omp parallel for
#endif
	for (i32 = 0; i32 < size2*size3; ++i32)
	{
		int i2 = i32 % size2;
		int i3 = i32 / size2;
		int i1;
		for (i1 = 0; i1 < outSize1; ++i1) {
			int k;
			for (k = (i1 - (filterLen-1)) & 1; k < filterLen; k += 2){
				int in_i1 = (i1 - (filterLen-1) + k) >> 1;
				if (in_i1 >= 0 && in_i1 < size1)
					out[i3*outSkip3 + i2*outSkip2 + i1*skip1] += in[i3*skip3 + i2*skip2 + in_i1*skip1] * filter[filterLen-1-k];
			}
		}
	}
}

void add(data_t* out,data_t* in,int numMax)
{
	int i;
	for(i=0; i<numMax;i++)
		out[i]+=in[i];
}

void mult(data_t* in,scalar_t scale,int numMax)
{
	int i;
	for(i=0; i<numMax;i++)
		in[i]*=scale;
}

void create_numLevels(struct dfwavelet_plan_s* plan)
{
	int numdims = plan->numdims;
	int filterLen = plan->filterLen;
	int bandSize, l, minSize;
	plan->numLevels = 10000000;
	int d;
	for (d = 0; d < numdims; d++)
	{
		bandSize = plan->imSize[d];
		minSize = plan->minSize[d];
		l = 0;
		while (bandSize > minSize)
		{
			++l;
			bandSize = (bandSize + filterLen - 1) / 2;
		}
		l--;
		plan->numLevels = (l < plan->numLevels) ? l : plan->numLevels;
	}
}

void create_wavelet_sizes(struct dfwavelet_plan_s* plan)
{
	int numdims = plan->numdims;
	int filterLen = plan->filterLen;
	int numLevels = plan->numLevels;
	int numSubCoef;
	plan->waveSizes = (int*) malloc(sizeof(int)*numdims*(numLevels+2));

	// Get number of subband per level, (3 for 2d, 7 for 3d)
	// Set the last bandSize to be imSize
	int d,l;
	int numSubband = 1;
	for (d = 0; d<numdims; d++)
	{
		plan->waveSizes[d + numdims*(numLevels+1)] = plan->imSize[d];
		numSubband <<= 1;
	}
	numSubband--;

	// Get numCoeff and waveSizes
	// Each bandSize[l] is (bandSize[l+1] + filterLen - 1)/2
	plan->numCoeff = 0;
	for (l = plan->numLevels; l >= 1; --l) {
		numSubCoef = 1;
		for (d = 0; d < numdims; d++)
		{
			plan->waveSizes[d + numdims*l] = (plan->waveSizes[d + numdims*(l+1)] + filterLen - 1) / 2;
			numSubCoef *= plan->waveSizes[d + numdims*l];
		}
		plan->numCoeff += numSubband*numSubCoef;
		if (l==1)
			plan->numCoarse = numSubCoef;
	}

	numSubCoef = 1;
	for (d = 0; d < numdims; d++)
	{
		plan->waveSizes[d] = plan->waveSizes[numdims+d];
		numSubCoef *= plan->waveSizes[d];
	}
	plan->numCoeff += numSubCoef;

}

/* All filter coefficients are obtained from http://wavelets.pybytes.com/ */
void create_wavelet_filters(struct dfwavelet_plan_s* plan)
{
	int filterLen = 0;
	scalar_t* filter1, *filter2;


	filterLen = 6;

	// CDF 2.2 and CDF 3.1 Wavelet
	scalar_t cdf22[] = {
		0.0,-0.17677669529663689,0.35355339059327379,1.0606601717798214,0.35355339059327379,-0.17677669529663689,
		0.0,0.35355339059327379,-0.70710678118654757,0.35355339059327379,0.0,0.0,
		0.0,0.35355339059327379,0.70710678118654757,0.35355339059327379,0.0,0.0,
		0.0,0.17677669529663689,0.35355339059327379,-1.0606601717798214,0.35355339059327379,0.17677669529663689

	};
	scalar_t cdf31[] = {
		0.0,-0.35355339059327379,1.0606601717798214,1.0606601717798214,-0.35355339059327379,0.0 ,
		0.0,-0.17677669529663689,0.53033008588991071,-0.53033008588991071,0.17677669529663689,0.0,
		0.0,0.17677669529663689,0.53033008588991071,0.53033008588991071,0.17677669529663689,0.0,
		0.0,-0.35355339059327379,-1.0606601717798214,1.0606601717798214,0.35355339059327379,0.0
	};
	filter1 = cdf22;
	filter2 = cdf31;

	// Allocate filters contiguously (for convenience)
	plan->filterLen = filterLen;
	plan->lod0 = (scalar_t*) malloc(sizeof(scalar_t) * 4 * filterLen);
	memcpy(plan->lod0, filter1, 4*filterLen*sizeof(scalar_t));
	plan->lod1 = (scalar_t*) malloc(sizeof(scalar_t) * 4 * filterLen);
	memcpy(plan->lod1, filter2, 4*filterLen*sizeof(scalar_t));
	plan->hid0 = plan->lod0 + 1*filterLen;
	plan->lor0 = plan->lod0 + 2*filterLen;
	plan->hir0 = plan->lod0 + 3*filterLen;
	plan->hid1 = plan->lod1 + 1*filterLen;
	plan->lor1 = plan->lod1 + 2*filterLen;
	plan->hir1 = plan->lod1 + 3*filterLen;
}

void count_zeros_cpu(struct dfwavelet_plan_s* plan, data_t* vx, data_t* vy, data_t* vz)
{
	if (plan->percentZero==-1)
	{
		int i;
		scalar_t percentZero = 0;
		for (i=0;i<plan->numPixel;i++)
			if((vx[i]==0.)&(vy[i]==0.)&(vz[i]==0))
				percentZero += 1.;
		plan->percentZero = percentZero/plan->numPixel;
	}
}


#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

data_t drand()   /* uniform distribution, (0..1] */
{
	return (rand()+1.0)/(RAND_MAX+1.0);
}

void random_normal(data_t* in,int length) 
/* normal distribution, centered on 0, std dev 1 */
{
	int i;
	for (i=0;i<length;i++)
		in[i] = sqrt(-2*log(drand())) * cos(2*M_PI*drand());
}

void get_noise_amp(struct dfwavelet_plan_s* plan)
{
	if (plan->noiseAmp==NULL)
	{
		// Generate Gaussian w/ mean=0, std=1 data
		data_t* vx,*vy,*vz;
		data_t* wcdf1,*wcdf2,*wcn;
		vx = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
		vy = (data_t*) malloc(sizeof(data_t)*plan->numPixel);
		vz = (data_t*) malloc(sizeof(data_t)*plan->numPixel);

		random_normal(vx,plan->numPixel);
		random_normal(vy,plan->numPixel);
		random_normal(vz,plan->numPixel);

		wcdf1 = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);
		wcdf2 = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);
		wcn = (data_t*) malloc(sizeof(data_t)*plan->numCoeff);

		// Get Wavelet Coefficients
		int temp_use_gpu = plan->use_gpu;
		if (plan->use_gpu==1)
			plan->use_gpu = 2;
		dfwavelet_forward(plan,wcdf1,wcdf2,wcn,vx,vy,vz);
		plan->use_gpu = temp_use_gpu;

		// Get Noise Amp for each subband
		data_t* HxLyLz1 = wcdf1 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
		data_t* HxLyLz2 = wcdf2 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
		data_t* HxLyLz3 = wcn + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
		int l;
		for (l = 1; l <= plan->numLevels; ++l){
			HxLyLz1 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
			HxLyLz2 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
			HxLyLz3 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
		}
		int numBand = 7*plan->numLevels*3;
		plan->noiseAmp = (scalar_t*) malloc(sizeof(scalar_t)*numBand);

		int naInd = 0;
		for (l = plan->numLevels; l >= 1; --l)
		{
			int dxNext = plan->waveSizes[0 + 3*l];
			int dyNext = plan->waveSizes[1 + 3*l];
			int dzNext = plan->waveSizes[2 + 3*l];
			int blockSize = dxNext*dyNext*dzNext;

			HxLyLz1 = HxLyLz1 - 7*blockSize;
			HxLyLz2 = HxLyLz2 - 7*blockSize;
			HxLyLz3 = HxLyLz3 - 7*blockSize;

			int bandInd;

#ifdef USE_OPENMP
#pragma omp parallel for private(bandInd)
#endif
			for (bandInd=0; bandInd<7*3;bandInd++)
			{
				data_t *subband;
				if (bandInd<7)
				{
					subband = HxLyLz1 + bandInd*blockSize;
				} else if (bandInd<14)
				{
					subband = HxLyLz2 + (bandInd-7)*blockSize;
				} else
				{
					subband = HxLyLz3 + (bandInd-14)*blockSize;
				}

				data_t sig = 0;
				data_t mean = 0;
				data_t mean_old;
				int i;
				for (i=0; i<blockSize; i++)
				{
					scalar_t x = subband[i];
					mean_old = mean;
					mean = mean_old + (x-mean_old)/(i+1);
					sig = sig + (x - mean_old)*(x-mean);
				}
				sig = sqrt(sig/(blockSize-1));
				plan->noiseAmp[naInd] = sig;
				naInd++;
			} 
      
		}
		free(vx);
		free(vy);
		free(vz);
		free(wcdf1);
		free(wcdf2);
		free(wcn);
	}
}
