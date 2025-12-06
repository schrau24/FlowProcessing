#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <cuda.h>
#include "dfwavelet_kernels.h"
#ifndef WAV_IMPL
#include "dfwavelet_impl.h"
#define WAV_IMPL
#endif
#  define _hdev_ __host__ __device__

// _data_t is the interal representation of data_t in CUDA
// Must be float2/double2 for data_t=Complex float/double or float/double for data_t=float/double
typedef double _data_t;

// Float2 Operators
inline _hdev_ float2 operator+ (float2 z1, float2 z2) {
  return make_float2 (z1.x + z2.x, z1.y + z2.y);		
}
inline _hdev_ float2 operator- (float2 z1, float2 z2) {
  return make_float2 (z1.x - z2.x, z1.y - z2.y);		
}
inline _hdev_ float2 operator* (float2 z1, float2 z2) {
  return make_float2 (z1.x*z2.x - z1.y*z2.y, z1.x*z2.y + z1.y*z2.x);		
}
inline _hdev_ float2 operator* (float2 z1, float alpha) {
  return make_float2 (z1.x*alpha, z1.y*alpha);		
}
inline _hdev_ float2 operator* (float alpha,float2 z1) {
  return make_float2 (z1.x*alpha, z1.y*alpha);		
}
inline _hdev_ void operator+= (float2 &z1, float2 z2) {
  z1.x += z2.x;
  z1.y += z2.y;		
}
inline _hdev_ float abs(float2 z1) {
  return sqrt(z1.x*z1.x + z1.y*z1.y);		
}

// Double2 Operators
inline _hdev_ double2 operator+ (double2 z1, double2 z2) {
  return make_double2 (z1.x + z2.x, z1.y + z2.y);		
}
inline _hdev_ double2 operator- (double2 z1, double2 z2) {
  return make_double2 (z1.x - z2.x, z1.y - z2.y);		
}
inline _hdev_ double2 operator* (double2 z1, double2 z2) {
  return make_double2 (z1.x*z2.x - z1.y*z2.y, z1.x*z2.y + z1.y*z2.x);		
}
inline _hdev_ double2 operator* (double2 z1, float alpha) {
  return make_double2 (z1.x*alpha, z1.y*alpha);		
}
inline _hdev_ double2 operator* (float alpha,double2 z1) {
  return make_double2 (z1.x*alpha, z1.y*alpha);		
}
inline _hdev_ void operator+= (double2 &z1, double2 z2) {
  z1.x += z2.x;
  z1.y += z2.y;		
}
inline _hdev_ float abs(double2 z1) {
  return sqrt(z1.x*z1.x + z1.y*z1.y);		
}

/********** Macros ************/
#define cuda(Call) do {					\
    cudaError_t err = cuda ## Call ;			\
    if (err != cudaSuccess){				\
      fprintf(stderr, "%s\n", cudaGetErrorString(err));	\
      throw;						\
    }							\
  } while(0)

#define cuda_sync() do{				\
    cuda (ThreadSynchronize());			\
    cuda (GetLastError());			\
  } while(0)


/********** Macros ************/
#define cuda(Call) do {					\
    cudaError_t err = cuda ## Call ;			\
    if (err != cudaSuccess){				\
      fprintf(stderr, "%s\n", cudaGetErrorString(err));	\
      throw;						\
    }							\
  } while(0)

#define cuda_sync() do{				\
    cuda (ThreadSynchronize());			\
    cuda (GetLastError());			\
  } while(0)

// ############################################################################
// Headers
// ############################################################################
static __global__ void cu_fwt3df_col(_data_t *Lx,_data_t *Hx,_data_t *in,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,scalar_t *lod,scalar_t *hid,int filterLen);
static __global__ void cu_fwt3df_row(_data_t *Ly,_data_t *Hy,_data_t *in,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,scalar_t *lod,scalar_t *hid,int filterLen);
static __global__ void cu_fwt3df_dep(_data_t *Lz,_data_t *Hz,_data_t *in,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,scalar_t *lod,scalar_t *hid,int filterLen);
static __global__ void cu_iwt3df_dep(_data_t *out,_data_t *Lz,_data_t *Hz,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,int xOffset,int yOffset,int zOffset,scalar_t *lod,scalar_t *hid,int filterLen);
static __global__ void cu_iwt3df_row(_data_t *out,_data_t *Ly,_data_t *Hy,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,int xOffset,int yOffset,int zOffset,scalar_t *lod,scalar_t *hid,int filterLen);
static __global__ void cu_iwt3df_col(_data_t *out,_data_t *Lx,_data_t *Hx,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,int xOffset,int yOffset,int zOffset,scalar_t *lod,scalar_t *hid,int filterLen);
static __global__ void cu_fwt3df_LC1(_data_t *HxLyLz_df1,_data_t *HxLyLz_df2,_data_t *HxLyLz_n,_data_t *LxHyLz_df1,_data_t *LxHyLz_df2,_data_t *LxHyLz_n,_data_t *LxLyHz_df1,_data_t *LxLyHz_df2,_data_t *LxLyHz_n,int dxNext, int dyNext, int dzNext);
static __global__ void cu_fwt3df_LC2(_data_t* HxHyLz_df1,_data_t* HxHyLz_df2,_data_t* HxHyLz_n,_data_t* HxLyHz_df1,_data_t* HxLyHz_df2,_data_t* HxLyHz_n,_data_t* LxHyHz_df1,_data_t* LxHyHz_df2,_data_t* LxHyHz_n,int dxNext, int dyNext, int dzNext);
static __global__ void cu_fwt3df_LC1_diff(_data_t *HxLyLz_df1,_data_t *HxLyLz_df2,_data_t *HxLyLz_n,_data_t *LxHyLz_df1,_data_t *LxHyLz_df2,_data_t *LxHyLz_n,_data_t *LxLyHz_df1,_data_t *LxLyHz_df2,_data_t *LxLyHz_n,int dxNext, int dyNext, int dzNext);
static __global__ void cu_fwt3df_LC2_diff(_data_t* HxHyLz_df1,_data_t* HxHyLz_df2,_data_t* HxHyLz_n,_data_t* HxLyHz_df1,_data_t* HxLyHz_df2,_data_t* HxLyHz_n,_data_t* LxHyHz_df1,_data_t* LxHyHz_df2,_data_t* LxHyHz_n,int dxNext, int dyNext, int dzNext);
static __global__ void cu_fwt3df_LC3(_data_t* HxHyHz_df1,_data_t* HxHyHz_df2,_data_t* HxHyHz_n,int dxNext, int dyNext, int dzNext);
static __global__ void cu_iwt3df_LC1(_data_t *HxLyLz_df1,_data_t *HxLyLz_df2,_data_t *HxLyLz_n,_data_t *LxHyLz_df1,_data_t *LxHyLz_df2,_data_t *LxHyLz_n,_data_t *LxLyHz_df1,_data_t *LxLyHz_df2,_data_t *LxLyHz_n,int dx, int dy, int dz);
static __global__ void cu_iwt3df_LC2(_data_t* HxHyLz_df1,_data_t* HxHyLz_df2,_data_t* HxHyLz_n,_data_t* HxLyHz_df1,_data_t* HxLyHz_df2,_data_t* HxLyHz_n,_data_t* LxHyHz_df1,_data_t* LxHyHz_df2,_data_t* LxHyHz_n,int dx, int dy, int dz);
static __global__ void cu_iwt3df_LC1_diff(_data_t *HxLyLz_df1,_data_t *HxLyLz_df2,_data_t *HxLyLz_n,_data_t *LxHyLz_df1,_data_t *LxHyLz_df2,_data_t *LxHyLz_n,_data_t *LxLyHz_df1,_data_t *LxLyHz_df2,_data_t *LxLyHz_n,int dx, int dy, int dz);
static __global__ void cu_iwt3df_LC2_diff(_data_t* HxHyLz_df1,_data_t* HxHyLz_df2,_data_t* HxHyLz_n,_data_t* HxLyHz_df1,_data_t* HxLyHz_df2,_data_t* HxLyHz_n,_data_t* LxHyHz_df1,_data_t* LxHyHz_df2,_data_t* LxHyHz_n,int dx, int dy, int dz);
static __global__ void cu_iwt3df_LC3(_data_t* HxHyHz_df1,_data_t* HxHyHz_df2,_data_t* HxHyHz_n,int dx, int dy, int dz);

static __global__ void cu_add(_data_t* out, _data_t* in, int maxInd);
static __global__ void cu_mult(_data_t* in, _data_t mult, int maxInd);
static __global__ void cu_soft_thresh (_data_t* in, scalar_t thresh, int numMax);
static __global__ void cu_circshift(_data_t* data, _data_t* dataCopy, int dx, int dy, int dz, int shift1, int shift2, int shift3);
static __global__ void cu_circunshift(_data_t* data, _data_t* dataCopy, int dx, int dy, int dz, int shift1, int shift2, int shift3);

void dfSUREshrink_gpu(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* dev_wcdf1,data_t* dev_wcdf2,data_t* dev_wcn);
scalar_t get_SURE_thresh (scalar_t* subband2, scalar_t* cum_sum,scalar_t sigma2,int length);
void prefix_sum(scalar_t* ener,scalar_t* out_values, scalar_t *in_values,int length);
void count_zeros_gpu (struct dfwavelet_plan_s* plan,data_t* in_vx,data_t* in_vy,data_t* in_vz);
void bitonic_sort(scalar_t *dev_values,int length);
scalar_t getMADsigma_gpu(struct dfwavelet_plan_s* plan, data_t* wcn);

static __global__ void cu_subband2 (scalar_t* subband2, data_t* subband,int length);
static __global__ void cu_calc_SURE_risk (scalar_t* risk, scalar_t* subband2, scalar_t* cum_sum,scalar_t sigma2,int length);
static __global__ void cu_find_min_risk (scalar_t* out_risk,scalar_t* out_subband2,scalar_t* in_risk,scalar_t* in_subband2,int length);
static __global__ void cu_is_zeros (scalar_t* isZeros,data_t* in_vx,data_t* in_vy,data_t* in_vz,int length);
static __global__ void cu_sumAll (scalar_t* out,scalar_t* in, int length);
static __global__ void cu_bitonic_sort_step(scalar_t *dev_values, int j, int k);
static __global__ void cu_prescan(scalar_t* out,scalar_t *in, int n)  ;
static __global__ void cu_add_cum(scalar_t *out,scalar_t* in);


extern "C" void dffwt3_gpuHost(struct dfwavelet_plan_s* plan, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn, data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  assert(plan->use_gpu==2);
  data_t* dev_wcdf1,*dev_wcdf2,*dev_wcn,*dev_vx,*dev_vy,*dev_vz;
  cuda(Malloc( (void**)&dev_vx, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vy, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vz, plan->numPixel*sizeof(data_t) ));

  cuda(Memcpy( dev_vx, in_vx, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vy, in_vy, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vz, in_vz, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));

  cuda(Malloc( (void**)&dev_wcdf1, plan->numCoeff*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_wcdf2, plan->numCoeff*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_wcn, plan->numCoeff*sizeof(data_t) ));

  dffwt3_gpu(plan,dev_wcdf1,dev_wcdf2,dev_wcn,dev_vx,dev_vy,dev_vz);

  cuda(Memcpy( out_wcdf1, dev_wcdf1, plan->numCoeff*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_wcdf2, dev_wcdf2, plan->numCoeff*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_wcn, dev_wcn, plan->numCoeff*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_wcdf1 ));
  cuda(Free( dev_wcdf2 ));
  cuda(Free( dev_wcn ));
  cuda(Free( dev_vx ));
  cuda(Free( dev_vy ));
  cuda(Free( dev_vz ));
}

extern "C" void dfiwt3_gpuHost(struct dfwavelet_plan_s* plan, data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_wcdf1,data_t* in_wcdf2,data_t* in_wcn)
{
  assert(plan->use_gpu==2);
  data_t* dev_wcdf1,*dev_wcdf2,*dev_wcn,*dev_vx,*dev_vy,*dev_vz;
  cuda(Malloc( (void**)&dev_wcdf1, plan->numCoeff*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_wcdf2, plan->numCoeff*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_wcn, plan->numCoeff*sizeof(data_t) ));

  cuda(Memcpy( dev_wcdf1, in_wcdf1, plan->numCoeff*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_wcdf2, in_wcdf2, plan->numCoeff*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_wcn, in_wcn, plan->numCoeff*sizeof(data_t), cudaMemcpyHostToDevice ));

  cuda(Malloc( (void**)&dev_vx, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vy, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vz, plan->numPixel*sizeof(data_t) ));

  dfiwt3_gpu(plan,dev_vx,dev_vy,dev_vz,dev_wcdf1,dev_wcdf2,dev_wcn);
  cuda(Memcpy( out_vx, dev_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vy, dev_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vz, dev_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_wcdf1 ));
  cuda(Free( dev_wcdf2 ));
  cuda(Free( dev_wcn ));
  cuda(Free( dev_vx ));
  cuda(Free( dev_vy ));
  cuda(Free( dev_vz ));
}

extern "C" void dfsoftthresh_gpuHost(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn)
{
  assert(plan->use_gpu==2);
  data_t* dev_wcdf1,*dev_wcdf2,*dev_wcn;
  cuda(Malloc( (void**)&dev_wcdf1, plan->numCoeff*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_wcdf2, plan->numCoeff*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_wcn, plan->numCoeff*sizeof(data_t) ));

  cuda(Memcpy( dev_wcdf1, out_wcdf1, plan->numCoeff*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_wcdf2, out_wcdf2, plan->numCoeff*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_wcn, out_wcn, plan->numCoeff*sizeof(data_t), cudaMemcpyHostToDevice ));

  dfsoftthresh_gpu(plan,dfthresh,nthresh,dev_wcdf1,dev_wcdf2,dev_wcn);

  cuda(Memcpy( out_wcdf1, dev_wcdf1, plan->numCoeff*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_wcdf2, dev_wcdf2, plan->numCoeff*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_wcn, dev_wcn, plan->numCoeff*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_wcdf1 ));
  cuda(Free( dev_wcdf2 ));
  cuda(Free( dev_wcn ));
}

extern "C" void dfwavthresh3_gpuHost(struct dfwavelet_plan_s* plan, scalar_t dfthresh,scalar_t nthresh,data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  assert(plan->use_gpu==2);
  data_t*dev_vx,*dev_vy,*dev_vz;
  cuda(Malloc( (void**)&dev_vx, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vy, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vz, plan->numPixel*sizeof(data_t) ));

  cuda(Memcpy( dev_vx, in_vx, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vy, in_vy, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vz, in_vz, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));

  dfwavthresh3_gpu(plan,dfthresh,nthresh,dev_vx,dev_vy,dev_vz,dev_vx,dev_vy,dev_vz);

  cuda(Memcpy( out_vx, dev_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vy, dev_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vz, dev_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_vx ));
  cuda(Free( dev_vy ));
  cuda(Free( dev_vz ));
}

extern "C" void dfwavthresh3_spin_gpuHost(struct dfwavelet_plan_s* plan, scalar_t dfthresh,scalar_t nthresh,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  assert(plan->use_gpu==2);
  data_t*dev_vx,*dev_vy,*dev_vz;
  cuda(Malloc( (void**)&dev_vx, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vy, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vz, plan->numPixel*sizeof(data_t) ));

  cuda(Memcpy( dev_vx, in_vx, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vy, in_vy, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vz, in_vz, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));

  dfwavthresh3_spin_gpu(plan,dfthresh,nthresh,spins,isRand,dev_vx,dev_vy,dev_vz,dev_vx,dev_vy,dev_vz);

  cuda(Memcpy( out_vx, dev_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vy, dev_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vz, dev_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_vx ));
  cuda(Free( dev_vy ));
  cuda(Free( dev_vz ));
}

extern "C" void dfwavthresh3_SURE_gpuHost(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  assert(plan->use_gpu==2);
  data_t*dev_vx,*dev_vy,*dev_vz;
  cuda(Malloc( (void**)&dev_vx, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vy, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vz, plan->numPixel*sizeof(data_t) ));

  cuda(Memcpy( dev_vx, in_vx, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vy, in_vy, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vz, in_vz, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));

  dfwavthresh3_SURE_gpu(plan,sigma,dev_vx,dev_vy,dev_vz,dev_vx,dev_vy,dev_vz);

  cuda(Memcpy( out_vx, dev_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vy, dev_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vz, dev_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_vx ));
  cuda(Free( dev_vy ));
  cuda(Free( dev_vz ));
}

extern "C" void dfwavthresh3_SURE_spin_gpuHost(struct dfwavelet_plan_s* plan,scalar_t sigma,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  assert(plan->use_gpu==2);
  data_t*dev_vx,*dev_vy,*dev_vz;
  cuda(Malloc( (void**)&dev_vx, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vy, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vz, plan->numPixel*sizeof(data_t) ));

  cuda(Memcpy( dev_vx, in_vx, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vy, in_vy, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vz, in_vz, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));

  dfwavthresh3_SURE_spin_gpu(plan,sigma,spins,isRand,dev_vx,dev_vy,dev_vz,dev_vx,dev_vy,dev_vz);

  cuda(Memcpy( out_vx, dev_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vy, dev_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vz, dev_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_vx ));
  cuda(Free( dev_vy ));
  cuda(Free( dev_vz ));
}

extern "C" void dfwavthresh3_SURE_MAD_gpuHost(struct dfwavelet_plan_s* plan,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  assert(plan->use_gpu==2);
  data_t*dev_vx,*dev_vy,*dev_vz;
  cuda(Malloc( (void**)&dev_vx, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vy, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vz, plan->numPixel*sizeof(data_t) ));

  cuda(Memcpy( dev_vx, in_vx, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vy, in_vy, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vz, in_vz, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));

  dfwavthresh3_SURE_MAD_gpu(plan,dev_vx,dev_vy,dev_vz,dev_vx,dev_vy,dev_vz);

  cuda(Memcpy( out_vx, dev_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vy, dev_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vz, dev_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_vx ));
  cuda(Free( dev_vy ));
  cuda(Free( dev_vz ));
}

extern "C" void dfwavthresh3_SURE_MAD_spin_gpuHost(struct dfwavelet_plan_s* plan,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  assert(plan->use_gpu==2);
  data_t*dev_vx,*dev_vy,*dev_vz;
  cuda(Malloc( (void**)&dev_vx, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vy, plan->numPixel*sizeof(data_t) ));
  cuda(Malloc( (void**)&dev_vz, plan->numPixel*sizeof(data_t) ));

  cuda(Memcpy( dev_vx, in_vx, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vy, in_vy, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_vz, in_vz, plan->numPixel*sizeof(data_t), cudaMemcpyHostToDevice ));

  dfwavthresh3_SURE_MAD_spin_gpu(plan,spins,isRand,dev_vx,dev_vy,dev_vz,dev_vx,dev_vy,dev_vz);

  cuda(Memcpy( out_vx, dev_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vy, dev_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));
  cuda(Memcpy( out_vz, dev_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToHost ));

  cuda(Free( dev_vx ));
  cuda(Free( dev_vy ));
  cuda(Free( dev_vz ));
}

extern "C" void dffwt3_gpu(struct dfwavelet_plan_s* plan, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn, data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  circshift_gpu(plan,in_vx);
  circshift_gpu(plan,in_vy);
  circshift_gpu(plan,in_vz);
  
  int numCoeff, filterLen,*waveSizes,numLevels;
  numCoeff = plan->numCoeff;
  waveSizes = plan->waveSizes;
  filterLen = plan->filterLen;
  numLevels = plan->numLevels;
  // Cast from generic data_t to device compatible _data_t
  _data_t* dev_wcdf1 = (data_t*) out_wcdf1;
  _data_t* dev_wcdf2 = (data_t*) out_wcdf2;
  _data_t* dev_wcn = (data_t*) out_wcn;
  _data_t* dev_in_vx = (data_t*) in_vx;
  _data_t* dev_in_vy = (data_t*) in_vy;
  _data_t* dev_in_vz = (data_t*) in_vz;
  _data_t* dev_temp1,*dev_temp2;
  cuda(Malloc( (void**)&dev_temp1, numCoeff*sizeof(_data_t) ));
  cuda(Malloc( (void**)&dev_temp2, numCoeff*sizeof(_data_t) ));

  // Get dimensions
  int dx = plan->imSize[0];
  int dy = plan->imSize[1];
  int dz = plan->imSize[2];
  int dxNext = waveSizes[0 + 3*numLevels];
  int dyNext = waveSizes[1 + 3*numLevels];
  int dzNext = waveSizes[2 + 3*numLevels];
  int blockSize = dxNext*dyNext*dzNext;

  // allocate device memory and  copy filters to device
  scalar_t *dev_filters;
  cuda(Malloc( (void**)&dev_filters, 4*plan->filterLen*sizeof(scalar_t) ));
  scalar_t *dev_lod0 = dev_filters + 0*plan->filterLen;
  scalar_t *dev_hid0 = dev_filters + 1*plan->filterLen;
  scalar_t *dev_lod1 = dev_filters + 2*plan->filterLen;
  scalar_t *dev_hid1 = dev_filters + 3*plan->filterLen;
  cuda(Memcpy( dev_lod0, plan->lod0, 2*plan->filterLen*sizeof(scalar_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_lod1, plan->lod1, 2*plan->filterLen*sizeof(scalar_t), cudaMemcpyHostToDevice ));

  // Initialize variables and Pointers for FWT
  int const SHMEM_SIZE = 16384;
  int const T = 512;
  int mem, K;
  dim3 numBlocks, numThreads;

  // Temp Pointers
  _data_t *dev_tempLx,*dev_tempHx;
  dev_tempLx = dev_temp1;
  dev_tempHx = dev_tempLx + numCoeff/2;
  _data_t *dev_tempLxLy,*dev_tempHxLy,*dev_tempLxHy,*dev_tempHxHy;
  dev_tempLxLy = dev_temp2;
  dev_tempHxLy = dev_tempLxLy + numCoeff/4;
  dev_tempLxHy = dev_tempHxLy + numCoeff/4;
  dev_tempHxHy = dev_tempLxHy + numCoeff/4;

  // wcdf1 Pointers
  _data_t *dev_LxLyLz_df1,*dev_HxLyLz_df1,*dev_LxHyLz_df1,*dev_HxHyLz_df1,*dev_LxLyHz_df1,*dev_HxLyHz_df1,*dev_LxHyHz_df1,*dev_HxHyHz_df1,*dev_current_vx;
  dev_LxLyLz_df1 = dev_wcdf1;
  dev_HxLyLz_df1 = dev_LxLyLz_df1 + waveSizes[0]*waveSizes[1]*waveSizes[2];
  for (int l = 1; l <= numLevels; ++l){
    dev_HxLyLz_df1 += 7*waveSizes[0 + 3*l]*waveSizes[1 + 3*l]*waveSizes[2 + 3*l];
  }
  dev_current_vx = dev_in_vx;

  // wcdf2 Pointers
  _data_t *dev_LxLyLz_df2,*dev_HxLyLz_df2,*dev_LxHyLz_df2,*dev_HxHyLz_df2,*dev_LxLyHz_df2,*dev_HxLyHz_df2,*dev_LxHyHz_df2,*dev_HxHyHz_df2,*dev_current_vy;
  dev_LxLyLz_df2 = dev_wcdf2;
  dev_HxLyLz_df2 = dev_LxLyLz_df2 + waveSizes[0]*waveSizes[1]*waveSizes[2];
  for (int l = 1; l <= numLevels; ++l){
    dev_HxLyLz_df2 += 7*waveSizes[0 + 3*l]*waveSizes[1 + 3*l]*waveSizes[2 + 3*l];
  }
  dev_current_vy = dev_in_vy;

  // wcn Pointers
  _data_t *dev_LxLyLz_n,*dev_HxLyLz_n,*dev_LxHyLz_n,*dev_HxHyLz_n,*dev_LxLyHz_n,*dev_HxLyHz_n,*dev_LxHyHz_n,*dev_HxHyHz_n,*dev_current_vz;
  dev_LxLyLz_n = dev_wcn;
  dev_HxLyLz_n = dev_LxLyLz_n + waveSizes[0]*waveSizes[1]*waveSizes[2];
  for (int l = 1; l <= numLevels; ++l){
    dev_HxLyLz_n += 7*waveSizes[0 + 3*l]*waveSizes[1 + 3*l]*waveSizes[2 + 3*l];
  }
  dev_current_vz = dev_in_vz;

  //*****************Loop through levels****************
  for (int l = numLevels; l >= 1; --l)
    {
      dxNext = waveSizes[0 + 3*l];
      dyNext = waveSizes[1 + 3*l];
      dzNext = waveSizes[2 + 3*l];
      blockSize = dxNext*dyNext*dzNext;

      // Update Pointers
      // df1
      dev_HxLyLz_df1 = dev_HxLyLz_df1 - 7*blockSize;
      dev_LxHyLz_df1 = dev_HxLyLz_df1 + blockSize;
      dev_HxHyLz_df1 = dev_LxHyLz_df1 + blockSize;
      dev_LxLyHz_df1 = dev_HxHyLz_df1 + blockSize;
      dev_HxLyHz_df1 = dev_LxLyHz_df1 + blockSize;
      dev_LxHyHz_df1 = dev_HxLyHz_df1 + blockSize;
      dev_HxHyHz_df1 = dev_LxHyHz_df1 + blockSize;
      // df2
      dev_HxLyLz_df2 = dev_HxLyLz_df2 - 7*blockSize;
      dev_LxHyLz_df2 = dev_HxLyLz_df2 + blockSize;
      dev_HxHyLz_df2 = dev_LxHyLz_df2 + blockSize;
      dev_LxLyHz_df2 = dev_HxHyLz_df2 + blockSize;
      dev_HxLyHz_df2 = dev_LxLyHz_df2 + blockSize;
      dev_LxHyHz_df2 = dev_HxLyHz_df2 + blockSize;
      dev_HxHyHz_df2 = dev_LxHyHz_df2 + blockSize;
      // n
      dev_HxLyLz_n = dev_HxLyLz_n - 7*blockSize;
      dev_LxHyLz_n = dev_HxLyLz_n + blockSize;
      dev_HxHyLz_n = dev_LxHyLz_n + blockSize;
      dev_LxLyHz_n = dev_HxHyLz_n + blockSize;
      dev_HxLyHz_n = dev_LxLyHz_n + blockSize;
      dev_LxHyHz_n = dev_HxLyHz_n + blockSize;
      dev_HxHyHz_n = dev_LxHyHz_n + blockSize;

      //************WCVX***********
      // FWT Columns
      K = (SHMEM_SIZE-16)/(dx*sizeof(_data_t));
      numBlocks = dim3(1,(dy+K-1)/K,dz);
      numThreads = dim3(T/K,K,1);
      mem = K*dx*sizeof(_data_t);

      cu_fwt3df_col <<< numBlocks,numThreads,mem >>>(dev_tempLx,dev_tempHx,dev_current_vx,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod1,dev_hid1,filterLen);
      cuda_sync();
      // FWT Rows
      K = (SHMEM_SIZE-16)/(dy*sizeof(_data_t));
      numBlocks = dim3(((dxNext)+K-1)/K,1,dz);
      numThreads = dim3(K,T/K,1);
      mem = K*dy*sizeof(_data_t);
      
      cu_fwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempLxLy,dev_tempLxHy,dev_tempLx,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cu_fwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempHxLy,dev_tempHxHy,dev_tempHx,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cuda_sync();
      // FWT Depths
      K = (SHMEM_SIZE-16)/(dz*sizeof(_data_t));
      numBlocks = dim3(((dxNext)+K-1)/K,dyNext,1);
      numThreads = dim3(K,1,T/K);
      mem = K*dz*sizeof(_data_t);
      
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_LxLyLz_df1,dev_LxLyHz_df1,dev_tempLxLy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_LxHyLz_df1,dev_LxHyHz_df1,dev_tempLxHy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_HxLyLz_df1,dev_HxLyHz_df1,dev_tempHxLy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_HxHyLz_df1,dev_HxHyHz_df1,dev_tempHxHy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cuda_sync();

      //************WCVY***********
      // FWT Columns
      K = (SHMEM_SIZE-16)/(dx*sizeof(_data_t));
      numBlocks = dim3(1,(dy+K-1)/K,dz);
      numThreads = dim3(T/K,K,1);
      mem = K*dx*sizeof(_data_t);
      
      cu_fwt3df_col <<< numBlocks,numThreads,mem >>>(dev_tempLx,dev_tempHx,dev_current_vy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cuda_sync();
      // FWT Rows
      K = (SHMEM_SIZE-16)/(dy*sizeof(_data_t));
      numBlocks = dim3(((dxNext)+K-1)/K,1,dz);
      numThreads = dim3(K,T/K,1);
      mem = K*dy*sizeof(_data_t);
      
      cu_fwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempLxLy,dev_tempLxHy,dev_tempLx,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod1,dev_hid1,filterLen);
      cu_fwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempHxLy,dev_tempHxHy,dev_tempHx,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod1,dev_hid1,filterLen);
      cuda_sync();
      // FWT Depths
      K = (SHMEM_SIZE-16)/(dz*sizeof(_data_t));
      numBlocks = dim3(((dxNext)+K-1)/K,dyNext,1);
      numThreads = dim3(K,1,T/K);
      mem = K*dz*sizeof(_data_t);
      
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_LxLyLz_df2,dev_LxLyHz_df2,dev_tempLxLy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_LxHyLz_df2,dev_LxHyHz_df2,dev_tempLxHy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_HxLyLz_df2,dev_HxLyHz_df2,dev_tempHxLy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_HxHyLz_df2,dev_HxHyHz_df2,dev_tempHxHy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cuda_sync();

      //************WCVZ***********
      // FWT Columns
      K = (SHMEM_SIZE-16)/(dx*sizeof(_data_t));
      numBlocks = dim3(1,(dy+K-1)/K,dz);
      numThreads = dim3(T/K,K,1);
      mem = K*dx*sizeof(_data_t);

      cu_fwt3df_col <<< numBlocks,numThreads,mem >>>(dev_tempLx,dev_tempHx,dev_current_vz,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cuda_sync();
      // FWT Rows
      K = (SHMEM_SIZE-16)/(dy*sizeof(_data_t));
      numBlocks = dim3(((dxNext)+K-1)/K,1,dz);
      numThreads = dim3(K,T/K,1);
      mem = K*dy*sizeof(_data_t);
      
      cu_fwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempLxLy,dev_tempLxHy,dev_tempLx,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cu_fwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempHxLy,dev_tempHxHy,dev_tempHx,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod0,dev_hid0,filterLen);
      cuda_sync();
      // FWT Depths
      K = (SHMEM_SIZE-16)/(dz*sizeof(_data_t));
      numBlocks = dim3(((dxNext)+K-1)/K,dyNext,1);
      numThreads = dim3(K,1,T/K);
      mem = K*dz*sizeof(_data_t);
      
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_LxLyLz_n,dev_LxLyHz_n,dev_tempLxLy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod1,dev_hid1,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_LxHyLz_n,dev_LxHyHz_n,dev_tempLxHy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod1,dev_hid1,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_HxLyLz_n,dev_HxLyHz_n,dev_tempHxLy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod1,dev_hid1,filterLen);
      cu_fwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_HxHyLz_n,dev_HxHyHz_n,dev_tempHxHy,dx,dy,dz,dxNext,dyNext,dzNext,dev_lod1,dev_hid1,filterLen);
      cuda_sync();

      //******* Multi ******
      int maxInd = 7*blockSize;
      numThreads = T;
      numBlocks = (maxInd+numThreads.x-1)/numThreads.x;
      cu_mult <<< numBlocks, numThreads >>> (dev_HxLyLz_df1,1./plan->res[0],maxInd);
      cu_mult <<< numBlocks, numThreads >>> (dev_HxLyLz_df2,1./plan->res[1],maxInd);
      cu_mult <<< numBlocks, numThreads >>> (dev_HxLyLz_n,1./plan->res[2],maxInd);
      cuda_sync();

      //*******Linear Combination******
      int t1 = min(dxNext,T);
      int t2 = T/t1;
      numBlocks = dim3( (dxNext+t1-1)/t1, (dyNext+t2-1)/t2, dzNext);
      numThreads = dim3(t1,t2,1);
	  
      cu_fwt3df_LC1 <<< numBlocks,numThreads >>> (dev_HxLyLz_df1,dev_HxLyLz_df2,dev_HxLyLz_n,dev_LxHyLz_df1,dev_LxHyLz_df2,dev_LxHyLz_n,dev_LxLyHz_df1,dev_LxLyHz_df2,dev_LxLyHz_n,dxNext,dyNext,dzNext);
      cu_fwt3df_LC2 <<< numBlocks,numThreads >>> (dev_HxHyLz_df1,dev_HxHyLz_df2,dev_HxHyLz_n,dev_HxLyHz_df1,dev_HxLyHz_df2,dev_HxLyHz_n,dev_LxHyHz_df1,dev_LxHyHz_df2,dev_LxHyHz_n,dxNext,dyNext,dzNext);
      cu_fwt3df_LC3 <<< numBlocks,numThreads >>> (dev_HxHyHz_df1,dev_HxHyHz_df2,dev_HxHyHz_n,dxNext,dyNext,dzNext);
      cuda_sync();
      cu_fwt3df_LC1_diff <<< numBlocks,numThreads >>> (dev_HxLyLz_df1,dev_HxLyLz_df2,dev_HxLyLz_n,dev_LxHyLz_df1,dev_LxHyLz_df2,dev_LxHyLz_n,dev_LxLyHz_df1,dev_LxLyHz_df2,dev_LxLyHz_n,dxNext,dyNext,dzNext);
      cu_fwt3df_LC2_diff <<< numBlocks,numThreads >>> (dev_HxHyLz_df1,dev_HxHyLz_df2,dev_HxHyLz_n,dev_HxLyHz_df1,dev_HxLyHz_df2,dev_HxLyHz_n,dev_LxHyHz_df1,dev_LxHyHz_df2,dev_LxHyHz_n,dxNext,dyNext,dzNext);
      cuda_sync();

      dev_current_vx = dev_wcdf1;
      dev_current_vy = dev_wcdf2;
      dev_current_vz = dev_wcn;

      dx = dxNext;
      dy = dyNext;
      dz = dzNext;
    }
  cuda(Free( dev_filters ));
  cuda(Free( dev_temp1 ));
  cuda(Free( dev_temp2 ));
  
  circunshift_gpu(plan,in_vx);
  circunshift_gpu(plan,in_vy);
  circunshift_gpu(plan,in_vz);
}

extern "C" void dfiwt3_gpu(struct dfwavelet_plan_s* plan, data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_wcdf1,data_t* in_wcdf2,data_t* in_wcn)
{
  int numCoeff, filterLen,*waveSizes,numLevels;
  numCoeff = plan->numCoeff;
  waveSizes = plan->waveSizes;
  filterLen = plan->filterLen;
  numLevels = plan->numLevels;
  // Cast from generic data_t to device compatible _data_t
  data_t* dev_out_vx = (_data_t*)out_vx;
  data_t* dev_out_vy = (_data_t*)out_vy;
  data_t* dev_out_vz = (_data_t*)out_vz;
  data_t* dev_wcdf1 = (_data_t*)in_wcdf1;
  data_t* dev_wcdf2 = (_data_t*)in_wcdf2;
  data_t* dev_wcn = (_data_t*)in_wcn;
  _data_t* dev_temp1, *dev_temp2;
  cuda(Malloc( (void**)&dev_temp1, numCoeff*sizeof(_data_t) ));
  cuda(Malloc( (void**)&dev_temp2, numCoeff*sizeof(_data_t)) );
  // allocate device memory
  scalar_t *dev_filters;
  cuda(Malloc( (void**)&dev_filters, 4*(plan->filterLen)*sizeof(scalar_t) ));
  scalar_t *dev_lor0 = dev_filters + 0*plan->filterLen;
  scalar_t *dev_hir0 = dev_filters + 1*plan->filterLen;
  scalar_t *dev_lor1 = dev_filters + 2*plan->filterLen;
  scalar_t *dev_hir1 = dev_filters + 3*plan->filterLen;
  cuda(Memcpy( dev_lor0, plan->lor0, 2*plan->filterLen*sizeof(scalar_t), cudaMemcpyHostToDevice ));
  cuda(Memcpy( dev_lor1, plan->lor1, 2*plan->filterLen*sizeof(scalar_t), cudaMemcpyHostToDevice ));
      
  // Workspace dimensions
  int dxWork = waveSizes[0 + 3*numLevels]*2-1 + filterLen-1;
  int dyWork = waveSizes[1 + 3*numLevels]*2-1 + filterLen-1;
  int dzWork = waveSizes[2 + 3*numLevels]*2-1 + filterLen-1;

  // Initialize variables and pointers for IWT
  int const SHMEM_SIZE = 16384;
  int const T = 512;
  int mem,K;
  dim3 numBlocks, numThreads;
  int dx = waveSizes[0];
  int dy = waveSizes[1];
  int dz = waveSizes[2];

  // Temp Pointers
  _data_t *dev_tempLxLy,*dev_tempHxLy,*dev_tempLxHy,*dev_tempHxHy;
  dev_tempLxLy = dev_temp1;
  dev_tempHxLy = dev_tempLxLy + numCoeff/4;
  dev_tempLxHy = dev_tempHxLy + numCoeff/4;
  dev_tempHxHy = dev_tempLxHy + numCoeff/4;
  _data_t *dev_tempLx,*dev_tempHx;
  dev_tempLx = dev_temp2;
  dev_tempHx = dev_tempLx + numCoeff/2;
  // wcdf1 Pointers
  _data_t *dev_LxLyLz_df1,*dev_HxLyLz_df1,*dev_LxHyLz_df1,*dev_HxHyLz_df1,*dev_LxLyHz_df1,*dev_HxLyHz_df1,*dev_LxHyHz_df1,*dev_HxHyHz_df1,*dev_current_vx;
  dev_LxLyLz_df1 = dev_wcdf1;
  dev_HxLyLz_df1 = dev_LxLyLz_df1 + dx*dy*dz;
  dev_current_vx = dev_LxLyLz_df1;
  // wcdf2 Pointers
  _data_t *dev_LxLyLz_df2,*dev_HxLyLz_df2,*dev_LxHyLz_df2,*dev_HxHyLz_df2,*dev_LxLyHz_df2,*dev_HxLyHz_df2,*dev_LxHyHz_df2,*dev_HxHyHz_df2,*dev_current_vy;
  dev_LxLyLz_df2 = dev_wcdf2;
  dev_HxLyLz_df2 = dev_LxLyLz_df2 + dx*dy*dz;
  dev_current_vy = dev_LxLyLz_df2;
  // wcn Pointers
  _data_t *dev_LxLyLz_n,*dev_HxLyLz_n,*dev_LxHyLz_n,*dev_HxHyLz_n,*dev_LxLyHz_n,*dev_HxLyHz_n,*dev_LxHyHz_n,*dev_HxHyHz_n,*dev_current_vz;
  dev_LxLyLz_n = dev_wcn;
  dev_HxLyLz_n = dev_LxLyLz_n + dx*dy*dz;
  dev_current_vz = dev_LxLyLz_n;

  for (int level = 1; level < numLevels+1; ++level)
    {
      dx = waveSizes[0 + 3*level];
      dy = waveSizes[1 + 3*level];
      dz = waveSizes[2 + 3*level];
      int blockSize = dx*dy*dz;
      int dxNext = waveSizes[0+3*(level+1)];
      int dyNext = waveSizes[1+3*(level+1)];
      int dzNext = waveSizes[2+3*(level+1)];
	  
      // Calclate Offset
      dxWork = (2*dx-1 + filterLen-1);
      dyWork = (2*dy-1 + filterLen-1);
      dzWork = (2*dz-1 + filterLen-1);
      int xOffset = (int) floor((dxWork - dxNext) / 2.0);
      int yOffset = (int) floor((dyWork - dyNext) / 2.0);
      int zOffset = (int) floor((dzWork - dzNext) / 2.0);

      // Update Pointers
      // df1
      dev_LxHyLz_df1 = dev_HxLyLz_df1 + blockSize;
      dev_HxHyLz_df1 = dev_LxHyLz_df1 + blockSize;
      dev_LxLyHz_df1 = dev_HxHyLz_df1 + blockSize;
      dev_HxLyHz_df1 = dev_LxLyHz_df1 + blockSize;
      dev_LxHyHz_df1 = dev_HxLyHz_df1 + blockSize;
      dev_HxHyHz_df1 = dev_LxHyHz_df1 + blockSize;
      // df2
      dev_LxHyLz_df2 = dev_HxLyLz_df2 + blockSize;
      dev_HxHyLz_df2 = dev_LxHyLz_df2 + blockSize;
      dev_LxLyHz_df2 = dev_HxHyLz_df2 + blockSize;
      dev_HxLyHz_df2 = dev_LxLyHz_df2 + blockSize;
      dev_LxHyHz_df2 = dev_HxLyHz_df2 + blockSize;
      dev_HxHyHz_df2 = dev_LxHyHz_df2 + blockSize;
      // n
      dev_LxHyLz_n = dev_HxLyLz_n + blockSize;
      dev_HxHyLz_n = dev_LxHyLz_n + blockSize;
      dev_LxLyHz_n = dev_HxHyLz_n + blockSize;
      dev_HxLyHz_n = dev_LxLyHz_n + blockSize;
      dev_LxHyHz_n = dev_HxLyHz_n + blockSize;
      dev_HxHyHz_n = dev_LxHyHz_n + blockSize;

      //*******Linear Combination******

      int t1 = min(dxNext,T);
      int t2 = T/t1;
      numBlocks = dim3( (dx+t1-1)/t1, (dy+t2-1)/t2, dz);
      numThreads = dim3(t1,t2,1);

      cu_iwt3df_LC1 <<< numBlocks,numThreads >>> (dev_HxLyLz_df1,dev_HxLyLz_df2,dev_HxLyLz_n,dev_LxHyLz_df1,dev_LxHyLz_df2,dev_LxHyLz_n,dev_LxLyHz_df1,dev_LxLyHz_df2,dev_LxLyHz_n,dx,dy,dz);
      cu_iwt3df_LC2 <<< numBlocks,numThreads >>> (dev_HxHyLz_df1,dev_HxHyLz_df2,dev_HxHyLz_n,dev_HxLyHz_df1,dev_HxLyHz_df2,dev_HxLyHz_n,dev_LxHyHz_df1,dev_LxHyHz_df2,dev_LxHyHz_n,dx,dy,dz);
      cu_iwt3df_LC3 <<< numBlocks,numThreads >>> (dev_HxHyHz_df1,dev_HxHyHz_df2,dev_HxHyHz_n,dx,dy,dz);
      cuda_sync();
      cu_iwt3df_LC1_diff <<< numBlocks,numThreads >>> (dev_HxLyLz_df1,dev_HxLyLz_df2,dev_HxLyLz_n,dev_LxHyLz_df1,dev_LxHyLz_df2,dev_LxHyLz_n,dev_LxLyHz_df1,dev_LxLyHz_df2,dev_LxLyHz_n,dx,dy,dz);
      cu_iwt3df_LC2_diff <<< numBlocks,numThreads >>> (dev_HxHyLz_df1,dev_HxHyLz_df2,dev_HxHyLz_n,dev_HxLyHz_df1,dev_HxLyHz_df2,dev_HxLyHz_n,dev_LxHyHz_df1,dev_LxHyHz_df2,dev_LxHyHz_n,dx,dy,dz);
      cuda_sync();
      
      //******* Multi ******
      int maxInd = 7*blockSize;
      numThreads = T;
      numBlocks = (maxInd+numThreads.x-1)/numThreads.x;
      cu_mult <<< numBlocks, numThreads >>> (dev_HxLyLz_df1,plan->res[0],maxInd);
      cu_mult <<< numBlocks, numThreads >>> (dev_HxLyLz_df2,plan->res[1],maxInd);
      cu_mult <<< numBlocks, numThreads >>> (dev_HxLyLz_n,plan->res[2],maxInd);
      cuda_sync();

      //************WCX************
      // Update Pointers
      if (level==numLevels)
	dev_current_vx = dev_out_vx;
      // IWT Depths
      K = (SHMEM_SIZE-16)/(2*dz*sizeof(_data_t));
      numBlocks = dim3((dx+K-1)/K,dy,1);
      numThreads = dim3(K,1,(T/K));
      mem = K*2*dz*sizeof(_data_t);

      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempLxLy,dev_LxLyLz_df1,dev_LxLyHz_df1,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempHxLy,dev_HxLyLz_df1,dev_HxLyHz_df1,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempLxHy,dev_LxHyLz_df1,dev_LxHyHz_df1,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempHxHy,dev_HxHyLz_df1,dev_HxHyHz_df1,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,filterLen);
      cuda_sync();
      // IWT Rows
      K = (SHMEM_SIZE-16)/(2*dy*sizeof(_data_t));
      numBlocks = dim3((dx+K-1)/K,1,dzNext);
      numThreads = dim3(K,(T/K),1);
      mem = K*2*dy*sizeof(_data_t);

      cu_iwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempLx,dev_tempLxLy,dev_tempLxHy,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,plan->filterLen);
      cu_iwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempHx,dev_tempHxLy,dev_tempHxHy,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,plan->filterLen);
      cuda_sync();
      // IWT Columns
      K = (SHMEM_SIZE-16)/(2*dx*sizeof(_data_t));
      numBlocks = dim3(1,(dyNext+K-1)/K,dzNext);
      numThreads = dim3((T/K),K,1);
      mem = K*2*dx*sizeof(_data_t);

      cu_iwt3df_col <<< numBlocks,numThreads,mem >>>(dev_current_vx,dev_tempLx,dev_tempHx,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor1,dev_hir1,plan->filterLen);
      cuda_sync();

      //************WCY************
      // Update Pointers
      if (level==numLevels)
	dev_current_vy = dev_out_vy;
      // IWT Depths
      K = (SHMEM_SIZE-16)/(2*dz*sizeof(_data_t));
      numBlocks = dim3((dx+K-1)/K,dy,1);
      numThreads = dim3(K,1,(T/K));
      mem = K*2*dz*sizeof(_data_t);

      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempLxLy,dev_LxLyLz_df2,dev_LxLyHz_df2,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempHxLy,dev_HxLyLz_df2,dev_HxLyHz_df2,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempLxHy,dev_LxHyLz_df2,dev_LxHyHz_df2,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempHxHy,dev_HxHyLz_df2,dev_HxHyHz_df2,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,filterLen);
      cuda_sync();
      // IWT Rows
      K = (SHMEM_SIZE-16)/(2*dy*sizeof(_data_t));
      numBlocks = dim3((dx+K-1)/K,1,dzNext);
      numThreads = dim3(K,(T/K),1);
      mem = K*2*dy*sizeof(_data_t);

      cu_iwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempLx,dev_tempLxLy,dev_tempLxHy,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor1,dev_hir1,plan->filterLen);
      cu_iwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempHx,dev_tempHxLy,dev_tempHxHy,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor1,dev_hir1,plan->filterLen);
      cuda_sync();
      // IWT Columns
      K = (SHMEM_SIZE-16)/(2*dx*sizeof(_data_t));
      numBlocks = dim3(1,(dyNext+K-1)/K,dzNext);
      numThreads = dim3((T/K),K,1);
      mem = K*2*dx*sizeof(_data_t);

      cu_iwt3df_col <<< numBlocks,numThreads,mem >>>(dev_current_vy,dev_tempLx,dev_tempHx,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,plan->filterLen);
      cuda_sync();

      //************WCZ************
      // Update Pointers
      if (level==numLevels)
	dev_current_vz = dev_out_vz;
      // IWT Depths
      K = (SHMEM_SIZE-16)/(2*dz*sizeof(_data_t));
      numBlocks = dim3((dx+K-1)/K,dy,1);
      numThreads = dim3(K,1,(T/K));
      mem = K*2*dz*sizeof(_data_t);

      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempLxLy,dev_LxLyLz_n,dev_LxLyHz_n,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor1,dev_hir1,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempHxLy,dev_HxLyLz_n,dev_HxLyHz_n,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor1,dev_hir1,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempLxHy,dev_LxHyLz_n,dev_LxHyHz_n,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor1,dev_hir1,filterLen);
      cu_iwt3df_dep <<< numBlocks,numThreads,mem >>>(dev_tempHxHy,dev_HxHyLz_n,dev_HxHyHz_n,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor1,dev_hir1,filterLen);
      cuda_sync();
      // IWT Rows
      K = (SHMEM_SIZE-16)/(2*dy*sizeof(_data_t));
      numBlocks = dim3((dx+K-1)/K,1,dzNext);
      numThreads = dim3(K,(T/K),1);
      mem = K*2*dy*sizeof(_data_t);

      cu_iwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempLx,dev_tempLxLy,dev_tempLxHy,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,plan->filterLen);
      cu_iwt3df_row <<< numBlocks,numThreads,mem >>>(dev_tempHx,dev_tempHxLy,dev_tempHxHy,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,plan->filterLen);
      cuda_sync();
      // IWT Columns
      K = (SHMEM_SIZE-16)/(2*dx*sizeof(_data_t));
      numBlocks = dim3(1,(dyNext+K-1)/K,dzNext);
      numThreads = dim3((T/K),K,1);
      mem = K*2*dx*sizeof(_data_t);

      cu_iwt3df_col <<< numBlocks,numThreads,mem >>>(dev_current_vz,dev_tempLx,dev_tempHx,dx,dy,dz,dxNext,dyNext,dzNext,xOffset,yOffset,zOffset,dev_lor0,dev_hir0,plan->filterLen);
      cuda_sync();
      dev_HxLyLz_df1 += 7*blockSize;
      dev_HxLyLz_df2 += 7*blockSize;
      dev_HxLyLz_n += 7*blockSize;

    }
  cuda(Free( dev_filters ));
  cuda(Free( dev_temp1 ));
  cuda(Free( dev_temp2 ));
  
  circunshift_gpu(plan,out_vx);
  circunshift_gpu(plan,out_vy);
  circunshift_gpu(plan,out_vz);
}

int rand_lim(int limit) {

  int divisor = RAND_MAX/(limit+1);
  int retval;

  do { 
    retval = rand() / divisor;
  } while (retval > limit);

  return retval;
}

void dfwavelet_new_randshift_gpu (struct dfwavelet_plan_s* plan) {
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

extern "C" void dfwavthresh3_gpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  data_t* dev_wcdf1,*dev_wcdf2,*dev_wcn;
  cuda(Malloc( (void**)&dev_wcdf1, plan->numCoeff*sizeof(_data_t) ));
  cuda(Malloc( (void**)&dev_wcdf2, plan->numCoeff*sizeof(_data_t) ));
  cuda(Malloc( (void**)&dev_wcn, plan->numCoeff*sizeof(_data_t) ));

  dffwt3_gpu(plan,dev_wcdf1,dev_wcdf2,dev_wcn,in_vx,in_vy,in_vz);
  dfsoftthresh_gpu(plan,dfthresh,nthresh,dev_wcdf1,dev_wcdf2,dev_wcn);
  dfiwt3_gpu(plan,out_vx,out_vy,out_vz,dev_wcdf1,dev_wcdf2,dev_wcn);

  cuda(Free( dev_wcdf1 ));
  cuda(Free( dev_wcdf2 ));
  cuda(Free( dev_wcn ));
}

extern "C" void dfwavthresh3_spin_gpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  data_t *temp_vx,*temp_vy,*temp_vz;
  cuda(Malloc( (void**)&temp_vx, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_vy, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_vz, plan->numPixel*sizeof(_data_t) ));

  data_t *temp_out_vx,*temp_out_vy,*temp_out_vz;
  cuda(Malloc( (void**)&temp_out_vx, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_out_vy, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_out_vz, plan->numPixel*sizeof(_data_t) ));
  cudaMemset(temp_out_vx,0,sizeof(data_t)*plan->numPixel);
  cudaMemset(temp_out_vy,0,sizeof(data_t)*plan->numPixel);
  cudaMemset(temp_out_vz,0,sizeof(data_t)*plan->numPixel);

  int T = 512;
  dim3 numThreads(T,1);
  dim3 numBlocks( (plan->numPixel+T-1)/T, 1);
  int s1,s2,s3;
  for (s1=0;s1<spins;s1++)
    for (s2=0;s2<spins;s2++)
      for (s3=0;s3<spins;s3++)
	{
	  if (isRand)
	    {
	      dfwavelet_new_randshift_gpu(plan);
	    } else 
	    {
	      plan->randShift[0] = s1;
	      plan->randShift[1] = s2;
	      plan->randShift[2] = s3;
	    }
	  dfwavthresh3_gpu(plan,dfthresh,nthresh,temp_vx,temp_vy,temp_vz,in_vx,in_vy,in_vz);
	  
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vx,temp_vx,plan->numPixel);
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vy,temp_vy,plan->numPixel);
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vz,temp_vz,plan->numPixel);
	}
  cuda(Memcpy(out_vx,temp_out_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));
  cuda(Memcpy(out_vy,temp_out_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));
  cuda(Memcpy(out_vz,temp_out_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));

  cu_mult<<<numBlocks,numThreads>>>(out_vx,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
  cu_mult<<<numBlocks,numThreads>>>(out_vy,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
  cu_mult<<<numBlocks,numThreads>>>(out_vz,1.0/((scalar_t) spins*spins*spins),plan->numPixel);

  cuda(Free( temp_vx ));
  cuda(Free( temp_vy ));
  cuda(Free( temp_vz ));
  cuda(Free( temp_out_vx ));
  cuda(Free( temp_out_vy ));
  cuda(Free( temp_out_vz ));
}

extern "C" void dfwavthresh3_SURE_gpu(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  data_t* dev_wcdf1,*dev_wcdf2,*dev_wcn;
  cuda(Malloc( (void**)&dev_wcdf1, plan->numCoeff*sizeof(_data_t) ));
  cuda(Malloc( (void**)&dev_wcdf2, plan->numCoeff*sizeof(_data_t) ));
  cuda(Malloc( (void**)&dev_wcn, plan->numCoeff*sizeof(_data_t) ));

  count_zeros_gpu(plan,in_vx,in_vy,in_vz);

  dffwt3_gpu(plan,dev_wcdf1,dev_wcdf2,dev_wcn,in_vx,in_vy,in_vz);
  dfSUREshrink_gpu(plan,sigma,dev_wcdf1,dev_wcdf2,dev_wcn);
  dfiwt3_gpu(plan,out_vx,out_vy,out_vz,dev_wcdf1,dev_wcdf2,dev_wcn);

  cuda(Free( dev_wcdf1 ));
  cuda(Free( dev_wcdf2 ));
  cuda(Free( dev_wcn ));
}

extern "C" void dfwavthresh3_SURE_spin_gpu(struct dfwavelet_plan_s* plan,scalar_t sigma,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  data_t *temp_vx,*temp_vy,*temp_vz;
  cuda(Malloc( (void**)&temp_vx, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_vy, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_vz, plan->numPixel*sizeof(_data_t) ));

  data_t *temp_out_vx,*temp_out_vy,*temp_out_vz;
  cuda(Malloc( (void**)&temp_out_vx, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_out_vy, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_out_vz, plan->numPixel*sizeof(_data_t) ));
  cudaMemset(temp_out_vx,0,sizeof(data_t)*plan->numPixel);
  cudaMemset(temp_out_vy,0,sizeof(data_t)*plan->numPixel);
  cudaMemset(temp_out_vz,0,sizeof(data_t)*plan->numPixel);

  count_zeros_gpu(plan,in_vx,in_vy,in_vz);

  int T = 512;
  dim3 numThreads(T,1);
  dim3 numBlocks( (plan->numPixel+T-1)/T, 1);
  int s1,s2,s3;
  for (s1=0;s1<spins;s1++)
    for (s2=0;s2<spins;s2++)
      for (s3=0;s3<spins;s3++)
	{
	  if (isRand)
	    {
	      dfwavelet_new_randshift_gpu(plan);
	    } else 
	    {
	      plan->randShift[0] = s1;
	      plan->randShift[1] = s2;
	      plan->randShift[2] = s3;
	    }
	  dfwavthresh3_SURE_gpu(plan,sigma,temp_vx,temp_vy,temp_vz,in_vx,in_vy,in_vz);
	  
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vx,temp_vx,plan->numPixel);
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vy,temp_vy,plan->numPixel);
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vz,temp_vz,plan->numPixel);
	}
  cuda(Memcpy(out_vx,temp_out_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));
  cuda(Memcpy(out_vy,temp_out_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));
  cuda(Memcpy(out_vz,temp_out_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));

  cu_mult<<<numBlocks,numThreads>>>(out_vx,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
  cu_mult<<<numBlocks,numThreads>>>(out_vy,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
  cu_mult<<<numBlocks,numThreads>>>(out_vz,1.0/((scalar_t) spins*spins*spins),plan->numPixel);

  cuda(Free( temp_vx ));
  cuda(Free( temp_vy ));
  cuda(Free( temp_vz ));
  cuda(Free( temp_out_vx ));
  cuda(Free( temp_out_vy ));
  cuda(Free( temp_out_vz ));
}

extern "C" void dfwavthresh3_SURE_MAD_gpu(struct dfwavelet_plan_s* plan,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  data_t* dev_wcdf1,*dev_wcdf2,*dev_wcn;
  cuda(Malloc( (void**)&dev_wcdf1, plan->numCoeff*sizeof(_data_t) ));
  cuda(Malloc( (void**)&dev_wcdf2, plan->numCoeff*sizeof(_data_t) ));
  cuda(Malloc( (void**)&dev_wcn, plan->numCoeff*sizeof(_data_t) ));

  count_zeros_gpu(plan,in_vx,in_vy,in_vz);

  dffwt3_gpu(plan,dev_wcdf1,dev_wcdf2,dev_wcn,in_vx,in_vy,in_vz);
  scalar_t sigma = getMADsigma_gpu(plan,dev_wcn);
  dfSUREshrink_gpu(plan,sigma,dev_wcdf1,dev_wcdf2,dev_wcn);
  dfiwt3_gpu(plan,out_vx,out_vy,out_vz,dev_wcdf1,dev_wcdf2,dev_wcn);

  cuda(Free( dev_wcdf1 ));
  cuda(Free( dev_wcdf2 ));
  cuda(Free( dev_wcn ));
}

extern "C" void dfwavthresh3_SURE_MAD_spin_gpu(struct dfwavelet_plan_s* plan,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{
  data_t *temp_vx,*temp_vy,*temp_vz;
  cuda(Malloc( (void**)&temp_vx, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_vy, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_vz, plan->numPixel*sizeof(_data_t) ));

  data_t *temp_out_vx,*temp_out_vy,*temp_out_vz;
  cuda(Malloc( (void**)&temp_out_vx, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_out_vy, plan->numPixel*sizeof(_data_t) ));
  cuda(Malloc( (void**)&temp_out_vz, plan->numPixel*sizeof(_data_t) ));
  cudaMemset(temp_out_vx,0,sizeof(data_t)*plan->numPixel);
  cudaMemset(temp_out_vy,0,sizeof(data_t)*plan->numPixel);
  cudaMemset(temp_out_vz,0,sizeof(data_t)*plan->numPixel);

  count_zeros_gpu(plan,in_vx,in_vy,in_vz);

  int T = 512;
  dim3 numThreads(T,1);
  dim3 numBlocks( (plan->numPixel+T-1)/T, 1);
  int s1,s2,s3;
  for (s1=0;s1<spins;s1++)
    for (s2=0;s2<spins;s2++)
      for (s3=0;s3<spins;s3++)
	{
	  if (isRand)
	    {
	      dfwavelet_new_randshift_gpu(plan);
	    } else 
	    {
	      plan->randShift[0] = s1;
	      plan->randShift[1] = s2;
	      plan->randShift[2] = s3;
	    }
	  dfwavthresh3_SURE_MAD_gpu(plan,temp_vx,temp_vy,temp_vz,in_vx,in_vy,in_vz);
	  
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vx,temp_vx,plan->numPixel);
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vy,temp_vy,plan->numPixel);
	  cu_add<<<numBlocks,numThreads>>>(temp_out_vz,temp_vz,plan->numPixel);
	}
  cuda(Memcpy(out_vx,temp_out_vx, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));
  cuda(Memcpy(out_vy,temp_out_vy, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));
  cuda(Memcpy(out_vz,temp_out_vz, plan->numPixel*sizeof(data_t), cudaMemcpyDeviceToDevice));

  cu_mult<<<numBlocks,numThreads>>>(out_vx,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
  cu_mult<<<numBlocks,numThreads>>>(out_vy,1.0/((scalar_t) spins*spins*spins),plan->numPixel);
  cu_mult<<<numBlocks,numThreads>>>(out_vz,1.0/((scalar_t) spins*spins*spins),plan->numPixel);

  cuda(Free( temp_vx ));
  cuda(Free( temp_vy ));
  cuda(Free( temp_vz ));
  cuda(Free( temp_out_vx ));
  cuda(Free( temp_out_vy ));
  cuda(Free( temp_out_vz ));
}

scalar_t getMADsigma_gpu(struct dfwavelet_plan_s* plan, data_t* wcn)
{
  data_t* subband = wcn + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
  int l;
  for (l = 1; l <= plan->numLevels; ++l){
    subband += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
  }

  int dx = plan->waveSizes[0 + 3*plan->numLevels];
  int dy = plan->waveSizes[1 + 3*plan->numLevels];
  int dz = plan->waveSizes[2 + 3*plan->numLevels];
  int blockSize = dx*dy*dz;
  int numZeros = (plan->percentZero*blockSize);
  int num = blockSize-numZeros;
  subband = subband - blockSize;

  int const T = 512;
  dim3 numBlocks = dim3((blockSize+T-1)/T,1);
  dim3 numThreads = dim3(T,1);

  scalar_t *subband2;
  cuda(Malloc( (void**)&subband2, blockSize*sizeof(scalar_t) ));
  cu_subband2<<<numBlocks,numThreads>>>(subband2,subband,blockSize);

  bitonic_sort(subband2,blockSize);
  scalar_t sigma;
  cuda(Memcpy(&sigma, subband2 + numZeros + num/2 , sizeof(scalar_t), cudaMemcpyDeviceToHost));
  // Scale by 1/noiseAMP for that subband
  sigma = 1.4826*sqrt(sigma)/plan->noiseAmp[20];
  cuda(Free(subband2));

  return sigma;
}


extern "C" void dfsoftthresh_gpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh, data_t* wcdf1,data_t* wcdf2,data_t* wcn)
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
			softthresh_gpu(plan, blockSize, lambda,subband);
			naInd++;
	  
		} 
	}
}

void dfSUREshrink_gpu(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* dev_wcdf1,data_t* dev_wcdf2,data_t* dev_wcn)
{
  scalar_t percentZero = plan->percentZero;
  data_t* HxLyLz1 = dev_wcdf1 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
  data_t* HxLyLz2 = dev_wcdf2 + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
  data_t* HxLyLz3 = dev_wcn + plan->waveSizes[0]*plan->waveSizes[1]*plan->waveSizes[2];
  int l;
  for (l = 1; l <= plan->numLevels; ++l){
    HxLyLz1 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
    HxLyLz2 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
    HxLyLz3 += 7*plan->waveSizes[0 + 3*l]*plan->waveSizes[1 + 3*l]*plan->waveSizes[2 + 3*l];
  }
  int dxNext = plan->waveSizes[0 + 3*plan->numLevels];
  int dyNext = plan->waveSizes[1 + 3*plan->numLevels];
  int dzNext = plan->waveSizes[2 + 3*plan->numLevels];
  int blockSize = dxNext*dyNext*dzNext;
  scalar_t *subband2, *cum_sum;
  cuda(Malloc( (void**)&subband2, blockSize*sizeof(scalar_t) ));
  cuda(Malloc( (void**)&cum_sum, blockSize*sizeof(scalar_t) ));
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
	  naInd++;

	  // Sort, Get cum_sum
	  scalar_t ener;
	  int const T = 512;
	  dim3 numBlocks = dim3((blockSize+T-1)/T,1);
	  dim3 numThreads = dim3(T,1);
	  cu_subband2<<<numBlocks,numThreads>>>(subband2,subband,blockSize);
	  bitonic_sort(subband2,blockSize);
	  prefix_sum(&ener,cum_sum,subband2,blockSize);

	  // N = blockSize*(1-%zero)
	  int numZeros = (percentZero*blockSize);
	  int num = blockSize-numZeros;

	  scalar_t thresh;
	  // Choose visu or sure
	  /*scalar_t density = (ener/num/sigma2-1);
	  scalar_t critical = (scalar_t) pow(log2 ((double) num),1.5)/sqrt(num);

	  if (density < critical)
	    {
	      thresh = sqrt(2*sigma2*log(num)); //visuShrink
	      } else*/
	    {
	      // Get SURE threshold
	      thresh = get_SURE_thresh(subband2+numZeros,cum_sum+numZeros,sigma2,num);
	    }
	    //printf("Sigma = %f, Sigma2 = %f, Thresh = %f, VisuThresh = %f, Ener = %f, percentZero = %f\n",sigma,sigma2,thresh,sqrt(sigma2*2*log(num)),ener,percentZero);

	  // SoftThresh
	  numBlocks = dim3((blockSize+T-1)/T,1);
	  numThreads = dim3(T,1);
	  cu_soft_thresh <<< numBlocks,numThreads>>> (subband,thresh,blockSize);
	} 
    }
  cuda(Free(subband2));
  cuda(Free(cum_sum));
}

__global__ void cu_subband2 (scalar_t* subband2, data_t* subband,int length)
{
  int const i = threadIdx.x + blockDim.x*blockIdx.x;
  if (i>length)
    return;

  subband2[i] = abs(subband[i])*abs(subband[i]);
}

__global__ void cu_calc_SURE_risk (scalar_t* risk, scalar_t* subband2, scalar_t* cum_sum,scalar_t sigma2,int length)
{
  int const i = threadIdx.x + blockDim.x*blockIdx.x;
  if (i>length)
    return;

  risk[i] = -( 2*sigma2*(i+1))+cum_sum[i]+subband2[i]*(length-i-1);
}

__global__ void cu_find_min_risk (scalar_t* out_risk,scalar_t* out_subband2,scalar_t* in_risk,scalar_t* in_subband2,int length)
{
  extern __shared__ scalar_t temp[];
  int const i = threadIdx.x + blockDim.x*blockIdx.x;
  int thid = threadIdx.x;
  int blid = blockIdx.x;
  scalar_t* temp_risk = temp;
  scalar_t* temp_subband2 = temp+blockDim.x;
  if (i<length)
    {
      temp_risk[thid] = in_risk[i]; 
      temp_subband2[thid] = in_subband2[i];
    } else
    {
      temp_risk[thid] = 3e38;
      temp_subband2[thid] = 0;
    }
  
  for (int jump = blockDim.x>>1; jump > 0; jump >>= 1) 
    {   
      __syncthreads();  
      int ai = thid;  
      int bi = thid+jump; 

      if (ai < jump)
	if (temp_risk[bi]<temp_risk[ai])
	  {
	    temp_risk[ai] = temp_risk[bi]; 
	    temp_subband2[ai] = temp_subband2[bi];
	  }
    }
  __syncthreads();  
  
  if (thid==0) 
    out_risk[blid] = temp_risk[0]; out_subband2[blid] = temp_subband2[0];
}

scalar_t get_SURE_thresh (scalar_t* subband2, scalar_t* cum_sum,scalar_t sigma2,int length)
{
  scalar_t* risk;
  cuda(Malloc( (void**)&risk, (length)*sizeof(scalar_t) ));

  int const T = 512;
  dim3 numThreads(T,1);
  dim3 numBlocks( (length+T-1)/T, 1);
  // Map
  cu_calc_SURE_risk <<< numBlocks, numThreads >>>(risk,subband2,cum_sum,sigma2,length);
  cuda_sync();
  // Reduce
  scalar_t* in_risk = risk;
  scalar_t* in_subband2 = subband2;
  scalar_t* temp;
  cuda(Malloc( (void**)&temp, length*2*sizeof(scalar_t) ));
  scalar_t* out_risk = temp;
  scalar_t* out_subband2 = temp+length;

  int mem = T*sizeof(_data_t)*2;
  scalar_t* result_risk = out_risk;
  scalar_t* result_subband2 = out_subband2;
  int l = length;
  do {
      numBlocks = dim3( (l+T-1)/T, 1);
      cu_find_min_risk <<< numBlocks,numThreads,mem>>> (out_risk,out_subband2,in_risk,in_subband2,l);
      cuda_sync();

      result_risk = out_risk;
      result_subband2 = out_subband2;
      out_risk = in_risk;
      out_subband2 = in_subband2;
      in_risk = result_risk;
      in_subband2 = result_subband2;
      l = numBlocks.x;
  } while (numBlocks.x > 1);
  scalar_t thresh;
  cuda(Memcpy(&thresh, result_subband2, sizeof(scalar_t), cudaMemcpyDeviceToHost));
  
  thresh = sqrtf(thresh);

  if (thresh>sqrtf(2*sigma2*log(length)))
    thresh = sqrtf(2*sigma2*log(length));
  
  cuda(Free(risk));
  cuda(Free(temp));
  return thresh;
}

__global__ void cu_is_zeros (scalar_t* isZeros,data_t* in_vx,data_t* in_vy,data_t* in_vz,int length)
{
  int const i = threadIdx.x + blockDim.x*blockIdx.x;
  if (i<length)
    isZeros[i] = ((in_vx[i]==0.)&&(in_vy[i]==0.)&&(in_vz[i]==0.));
}

__global__ void cu_sumAll (scalar_t* out,scalar_t* in, int length)
{
  extern __shared__ scalar_t temp[];
  int const i = threadIdx.x + blockDim.x*blockIdx.x;
  int thid = threadIdx.x;
  int blid = blockIdx.x;
  if (i<length)
    temp[thid] = in[i];
  else
    temp[thid] = 0;

  for (int jump = blockDim.x>>1; jump > 0; jump >>= 1) 
    {   
      __syncthreads();  
      int ai = thid;  
      int bi = thid+jump; 

      if (ai < jump)
	temp[ai]+=temp[bi];
    }
  __syncthreads();  
  
  if (thid==0) 
    out[blid] = temp[0];
}

void count_zeros_gpu (struct dfwavelet_plan_s* plan,data_t* in_vx,data_t* in_vy,data_t* in_vz)
{

  if (plan->percentZero==-1)
    {
      int length = plan->numPixel;
      scalar_t* isZeros;
      cuda(Malloc( (void**)&isZeros, length*sizeof(scalar_t) ));

      int const T = 512;
      dim3 numThreads(T,1);
      dim3 numBlocks( (length+T-1)/T, 1);
      // Map
      cu_is_zeros <<< numBlocks, numThreads >>>(isZeros,in_vx,in_vy,in_vz,length);
      cuda_sync();
      // Reduce
      scalar_t* in_numZeros = isZeros;
      scalar_t* temp;
      cuda(Malloc( (void**)&temp, length*sizeof(scalar_t) ));
      scalar_t* out_numZeros = temp;

      int mem = T*sizeof(_data_t);
      scalar_t* result = out_numZeros;
      int l = length;
      do {
	numBlocks = dim3( (l+T-1)/T, 1);
	cu_sumAll <<< numBlocks,numThreads,mem>>> (out_numZeros,in_numZeros,l);
	cuda_sync();
	result = out_numZeros;
	out_numZeros = in_numZeros;
	in_numZeros = result;
	l = numBlocks.x;
      } while (numBlocks.x > 1);
      cuda(Memcpy(&plan->percentZero, result, sizeof(scalar_t), cudaMemcpyDeviceToHost));
      plan->percentZero = plan->percentZero/length;
      cuda(Free(isZeros));
      cuda(Free(temp));
    }
}

__global__ void cu_bitonic_sort_step(scalar_t *dev_values, int j, int k)
{
  unsigned int i, ixj; /* Sorting partners: i and ixj */
  i = threadIdx.x + blockDim.x * blockIdx.x;
  ixj = i^j;

  /* The threads with the lowest ids sort the array. */
  if ((ixj)>i) {
    if ((i&k)==0) {
      /* Sort ascending */
      if (dev_values[i]>dev_values[ixj]) {
        /* exchange(i,ixj); */
        scalar_t temp = dev_values[i];
        dev_values[i] = dev_values[ixj];
        dev_values[ixj] = temp;
      }
    }
    if ((i&k)!=0) {
      /* Sort descending */
      if (dev_values[i]<dev_values[ixj]) {
        /* exchange(i,ixj); */
        scalar_t temp = dev_values[i];
        dev_values[i] = dev_values[ixj];
        dev_values[ixj] = temp;
      }
    }
  }
}

/**
 * Bitonic sort using CUDA, accepts only nonnegative numbers
 */
void bitonic_sort(scalar_t *dev_values,int length)
{
  int length2 = 1;
  int l = length;
  while (l>>=1)
    length2<<=1;
  if (length2!=length)
    length2<<=1;

  scalar_t *dev_temp_values;
  cudaMalloc((void**) &dev_temp_values, length2*sizeof(scalar_t));
  cudaMemset(dev_temp_values+length,0,(length2-length)*sizeof(scalar_t));
  cudaMemcpy(dev_temp_values, dev_values, length*sizeof(scalar_t), cudaMemcpyDeviceToDevice);
  
  int const T = (length2>512)? 512 : length2;
  dim3 numBlocks(length2/T,1);    /* Number of blocks   */
  dim3 numThreads(T,1);  /* Number of threads  */

  int j, k;
  for (k = 2; k <= length2; k <<= 1) {
    for (j=k>>1; j>0; j=j>>1) {
      cu_bitonic_sort_step<<<numBlocks, numThreads>>>(dev_temp_values, j, k);
    }
  }
  cuda(Memcpy(dev_values, dev_temp_values+(length2-length), length*sizeof(scalar_t), cudaMemcpyDeviceToDevice));
  cudaFree(dev_temp_values);
}


__global__ void cu_prescan(scalar_t* out,scalar_t *in, int n)  
{   
  extern __shared__ scalar_t temp[];  // allocated on invocation  
  int thid = threadIdx.x;  
  int offset = 1;  
 	
  temp[2*thid] = in[2*thid]; // load input into shared memory  
  temp[2*thid+1] = in[2*thid+1]; 

  for (int d = n>>1; d > 0; d >>= 1)                    // build sum in place up the tree  
    {   
      __syncthreads();  
      if (thid < d)  
	{  
	  int ai = offset*(2*thid+1)-1;  
	  int bi = offset*(2*thid+2)-1;  
 	
	  temp[bi] += temp[ai];  
	}  
      offset *= 2;  
    }

  if (thid == 0) { temp[n - 1] = 0; } // clear the last element   

  for (int d = 1; d < n; d *= 2) // traverse down tree & build scan  
    {  
      offset >>= 1;  
      __syncthreads();  
      if (thid < d)                       
	{  
     
	  int ai = offset*(2*thid+1)-1;  
	  int bi = offset*(2*thid+2)-1;  
 	
	  scalar_t t = temp[ai];  
	  temp[ai] = temp[bi];  
	  temp[bi] += t;   
	}  
    }  

  __syncthreads();  
  out[2*thid] = temp[2*thid];
  out[2*thid+1] = temp[2*thid+1];
}  

__global__ void cu_add_cum(scalar_t *out,scalar_t* in)
{
  int thid = threadIdx.x;
  out[thid] += in[-1];
  out[thid] += out[-1];
}

void prefix_sum(scalar_t* ener,scalar_t* out_values, scalar_t *in_values,int length)
{
  int length2 = 1;
  int l = length;
  while (l>>=1)
    length2<<=1;
  if (length2!=length)
    length2<<=1;
  scalar_t *dev_temp_values_in,*dev_temp_values_out;
  cudaMalloc((void**) &dev_temp_values_in, length2*sizeof(scalar_t));
  cudaMalloc((void**) &dev_temp_values_out, length2*sizeof(scalar_t));
  cudaMemset(dev_temp_values_in+length,0,(length2-length)*sizeof(scalar_t));
  cudaMemcpy(dev_temp_values_in, in_values, length*sizeof(scalar_t), cudaMemcpyDeviceToDevice);
  int T = (length2>512)? 512 : length2;
  dim3 numBlocks(length2/T,1);    /* Number of blocks   */
  dim3 numThreads(T/2,1);  /* Number of threads  */
  int mem = T*sizeof(_data_t);

  int i;
  for (i=0; i < length2/T; i++)
    {
      cu_prescan<<<numBlocks, numThreads, mem>>>(dev_temp_values_out+i*T,dev_temp_values_in+i*T,T);
      cuda_sync();
    }
  
  for (i = 1; i< numBlocks.x; i++)
    {
      cu_add_cum<<< 1, T >>> (dev_temp_values_out+i*T,dev_temp_values_in+i*T);
      cuda_sync();
    }
  
  cudaMemcpy(out_values, dev_temp_values_out, length*sizeof(scalar_t), cudaMemcpyDeviceToDevice);
  cudaFree(dev_temp_values_in);
  cudaFree(dev_temp_values_out);

  // Get Energy
  scalar_t ener_1;
  cudaMemcpy(&ener_1, out_values+length-1, sizeof(scalar_t), cudaMemcpyDeviceToHost);
  cudaMemcpy(ener, in_values+length-1, sizeof(scalar_t), cudaMemcpyDeviceToHost);
  ener[0] += ener_1;
}



/********** Aux functions **********/
extern "C" void softthresh_gpu (struct dfwavelet_plan_s* plan,int length, scalar_t thresh,data_t* coeff_c)
{
  assert(plan->use_gpu==1||plan->use_gpu==2);

  _data_t* dev_coeff;
  dev_coeff = (_data_t*) coeff_c;
  int numMax;
  int const T = 512;
  dim3 numBlocks, numThreads;
  numMax = length;
  numBlocks = dim3((numMax+T-1)/T,1,1);
  numThreads = dim3(T,1,1);
  cu_soft_thresh <<< numBlocks,numThreads>>> (dev_coeff,thresh,numMax);
}

extern "C" void circshift_gpu(struct dfwavelet_plan_s* plan, data_t* data_c) {
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
  _data_t* data = (_data_t*) data_c;
  // Copy data
  _data_t* dataCopy;
  cuda(Malloc((void**)&dataCopy, plan->numPixel*sizeof(_data_t)));
  cuda(Memcpy(dataCopy, data, plan->numPixel*sizeof(_data_t), cudaMemcpyDeviceToDevice));
  int T = 512;
  if (plan->numdims==2)
    {
      int dx,dy,r0,r1;
      dx = plan->imSize[0];
      dy = plan->imSize[1];
      r0 = plan->randShift[0];
      r1 = plan->randShift[1];
      cu_circshift <<< (plan->numPixel+T-1)/T, T>>>(data,dataCopy,dx,dy,1,r0,r1,0);
    } else if (plan->numdims==3)
    {
      int dx,dy,dz,r0,r1,r2;
      dx = plan->imSize[0];
      dy = plan->imSize[1];
      dz = plan->imSize[2];
      r0 = plan->randShift[0];
      r1 = plan->randShift[1];
      r2 = plan->randShift[2];
      cu_circshift <<< (plan->numPixel+T-1)/T, T>>>(data,dataCopy,dx,dy,dz,r0,r1,r2);
    }
  cuda(Free(dataCopy));
}

extern "C" void circunshift_gpu(struct dfwavelet_plan_s* plan, data_t* data_c) {
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
  _data_t* data = (_data_t*) data_c;
  // Copy data
  _data_t* dataCopy;
  cuda(Malloc((void**)&dataCopy, plan->numPixel*sizeof(_data_t)));
  cuda(Memcpy(dataCopy, data, plan->numPixel*sizeof(_data_t), cudaMemcpyDeviceToDevice));
  int T = 512;
  if (plan->numdims==2)
    {
      int dx,dy,r0,r1;
      dx = plan->imSize[0];
      dy = plan->imSize[1];
      r0 = plan->randShift[0];
      r1 = plan->randShift[1];
      cu_circunshift <<< (plan->numPixel+T-1)/T, T>>>(data,dataCopy,dx,dy,1,r0,r1,0);
    } else if (plan->numdims==3)
    {
      int dx,dy,dz,r0,r1,r2;
      dx = plan->imSize[0];
      dy = plan->imSize[1];
      dz = plan->imSize[2];
      r0 = plan->randShift[0];
      r1 = plan->randShift[1];
      r2 = plan->randShift[2];
      cu_circunshift <<< (plan->numPixel+T-1)/T, T>>>(data,dataCopy,dx,dy,dz,r0,r1,r2);
    }
  cuda(Free(dataCopy));
}

// ############################################################################
// CUDA function of fwt column convolution
// Loads data to scratchpad (shared memory) and convolve w/ low pass and high pass
// Output: Lx, Hx
// Input:  in, dx, dy, dz, dxNext, lod, hid, filterLen
// ############################################################################
extern "C" __global__ void cu_fwt3df_col(_data_t *Lx,_data_t *Hx,_data_t *in,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,scalar_t *lod,scalar_t *hid,int filterLen)
{
  extern __shared__ _data_t cols [];
  int ti = threadIdx.x;
  int tj = threadIdx.y;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;

  if (j>=dy) {
    return;
  }

  // Load Input to Temp Array
  for (int i = ti; i < dx; i += blockDim.x){
    cols[i + tj*dx] = in[i + j*dx + k*dx*dy];
  }
  __syncthreads();
  // Low-Pass and High-Pass Downsample
  int ind, lessThan, greaThan;
  for (int i = ti; i < dxNext; i += blockDim.x){
    _data_t y = cols[0]-cols[0];
    _data_t z = cols[0]-cols[0];
#pragma unroll
    for (int f = 0; f < filterLen; f++){
      ind = 2*i+1 - (filterLen-1)+f;

      lessThan = (int) (ind<0);
      greaThan = (int) (ind>=dx);
      ind = -1*lessThan+ind*(-2*lessThan+1);
      ind = (2*dx-1)*greaThan+ind*(-2*greaThan+1);

      y += cols[ind + tj*dx] * lod[filterLen-1-f];
      z += cols[ind + tj*dx] * hid[filterLen-1-f];
    }
    Lx[i + j*dxNext + k*dxNext*dy] = y;
    Hx[i + j*dxNext + k*dxNext*dy] = z;
  }
}

// ############################################################################
// CUDA function of fwt row convolution. Assumes fwt_col() has already been called
// Loads data to scratchpad (shared memory) and convolve w/ low pass and high pass
// Output: LxLy, LxHy / HxLy, HxHy
// Input:  Lx/Hx, dx, dy, dxNext, dyNext, lod, hid, filterLen
// ############################################################################
extern "C" __global__ void cu_fwt3df_row(_data_t *Ly,_data_t *Hy,_data_t *in,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,scalar_t *lod,scalar_t *hid,int filterLen)
{
  extern __shared__ _data_t rows [];
  int const K = blockDim.x;
  int ti = threadIdx.x;
  int tj = threadIdx.y;
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int k = blockIdx.z*blockDim.z+threadIdx.z;

  if (i>=dxNext)
    {
      return;
    }

  for (int j = tj; j < dy; j += blockDim.y){
    rows[ti + j*K] = in[i + j*dxNext + k*dxNext*dy];
  }
  __syncthreads();

  // Low-Pass and High Pass Downsample
  int ind, lessThan, greaThan;
  for (int j = tj; j < dyNext; j += blockDim.y){
    _data_t y = rows[0]-rows[0];
    _data_t z = rows[0]-rows[0];
#pragma unroll
    for (int f = 0; f < filterLen; f++){
      ind = 2*j+1 - (filterLen-1)+f;
      lessThan = (int) (ind<0);
      greaThan = (int) (ind>=dy);
      ind = -1*lessThan+ind*(-2*lessThan+1);
      ind = (2*dy-1)*greaThan+ind*(-2*greaThan+1);
      y += rows[ti + ind*K] * lod[filterLen-1-f];
      z += rows[ti + ind*K] * hid[filterLen-1-f];
    }
    Ly[i + j*dxNext + k*dxNext*dyNext] = y;
    Hy[i + j*dxNext + k*dxNext*dyNext] = z;
  }
}

// ############################################################################
// CUDA function of fwt depth convolution. Assumes fwt_row() has already been called
// Loads data to scratchpad (shared memory) and convolve w/ low pass and high pass
// Output: LxLy, LxHy / HxLy, HxHy
// Input:  Lx/Hx, dx, dy, dxNext, dyNext, lod, hid, filterLen
// ############################################################################
extern "C" __global__ void cu_fwt3df_dep(_data_t *Lz,_data_t *Hz,_data_t *in,int dx,int dy,int dz,int dxNext,int dyNext,int dzNext,scalar_t *lod,scalar_t *hid,int filterLen)
{
  extern __shared__ _data_t deps [];
  int const K = blockDim.x;
  int ti = threadIdx.x;
  int tk = threadIdx.z;
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;

  if (i>=dxNext)
    {
      return;
    }

  for (int k = tk; k < dz; k += blockDim.z){
    deps[ti + k*K] = in[i + j*dxNext + k*dxNext*dyNext];
  }
  __syncthreads();

  // Low-Pass and High Pass Downsample
  int ind, lessThan, greaThan;
  for (int k = tk; k < dzNext; k += blockDim.z){
    _data_t y = deps[0]-deps[0];
    _data_t z = deps[0]-deps[0];
#pragma unroll
    for (int f = 0; f < filterLen; f++){
      ind = 2*k+1 - (filterLen-1)+f;
      lessThan = (int) (ind<0);
      greaThan = (int) (ind>=dz);
      ind = -1*lessThan+ind*(-2*lessThan+1);
      ind = (2*dz-1)*greaThan+ind*(-2*greaThan+1);
      y += deps[ti + ind*K] * lod[filterLen-1-f];
      z += deps[ti + ind*K] * hid[filterLen-1-f];
    }
    Lz[i + j*dxNext + k*dxNext*dyNext] = y;
    Hz[i + j*dxNext + k*dxNext*dyNext] = z;
  }
}

extern "C" __global__ void cu_fwt3df_LC1(_data_t *HxLyLz_df1,_data_t *HxLyLz_df2,_data_t *HxLyLz_n,_data_t *LxHyLz_df1,_data_t *LxHyLz_df2,_data_t *LxHyLz_n,_data_t *LxLyHz_df1,_data_t *LxLyHz_df2,_data_t *LxLyHz_n,int dxNext, int dyNext, int dzNext)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t x,y,z,xGreatZero,yGreatZero,zGreatZero;
  if ((i>=dxNext)||(j>=dyNext)||(k>=dzNext))
    {
      return;
    }

  //HLL
  x = HxLyLz_df1[i+j*dxNext+k*dxNext*dyNext];
  y = HxLyLz_df2[i+j*dxNext+k*dxNext*dyNext];
  z = HxLyLz_n[i+j*dxNext+k*dxNext*dyNext];
  HxLyLz_df1[i+j*dxNext+k*dxNext*dyNext] = y;
  HxLyLz_df2[i+j*dxNext+k*dxNext*dyNext] = z;
  yGreatZero = j>0;
  zGreatZero = k>0;
  HxLyLz_n[i+j*dxNext+k*dxNext*dyNext] = x + yGreatZero*0.25*y + zGreatZero*0.25*z;

  //LHL
  x = LxHyLz_df1[i+j*dxNext+k*dxNext*dyNext];
  y = LxHyLz_df2[i+j*dxNext+k*dxNext*dyNext];
  z = LxHyLz_n[i+j*dxNext+k*dxNext*dyNext];
  LxHyLz_df2[i+j*dxNext+k*dxNext*dyNext] = z;
  xGreatZero = i>0;
  zGreatZero = k>0;
  LxHyLz_n[i+j*dxNext+k*dxNext*dyNext] = y + xGreatZero*0.25*x + zGreatZero*0.25*z;
      
  //LLH
  x = LxLyHz_df1[i+j*dxNext+k*dxNext*dyNext];
  y = LxLyHz_df2[i+j*dxNext+k*dxNext*dyNext];
  z = LxLyHz_n[i+j*dxNext+k*dxNext*dyNext];
  LxLyHz_df1[i+j*dxNext+k*dxNext*dyNext] = y;
  LxLyHz_df2[i+j*dxNext+k*dxNext*dyNext] = x;
  yGreatZero = j>0;
  xGreatZero = i>0;
  LxLyHz_n[i+j*dxNext+k*dxNext*dyNext] = z + yGreatZero*0.25*y + xGreatZero*0.25*x;
}
extern "C" __global__ void cu_fwt3df_LC1_diff(_data_t *HxLyLz_df1,_data_t *HxLyLz_df2,_data_t *HxLyLz_n,_data_t *LxHyLz_df1,_data_t *LxHyLz_df2,_data_t *LxHyLz_n,_data_t *LxLyHz_df1,_data_t *LxLyHz_df2,_data_t *LxLyHz_n,int dxNext, int dyNext, int dzNext)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t x,y,z;
  if ((i>=dxNext)||(j>=dyNext)||(k>=dzNext))
    {
      return;
    }

  //HLL
  if (j>0)
    y = HxLyLz_df1[i+(j-1)*dxNext+k*dxNext*dyNext];
  else
    y = 0;
  if (k>0)
    z = HxLyLz_df2[i+j*dxNext+(k-1)*dxNext*dyNext];
  else
    z = 0;
  HxLyLz_n[i+j*dxNext+k*dxNext*dyNext] += -0.25*y - 0.25*z;

  //LHL
  if (i>0)
    x = LxHyLz_df1[(i-1)+j*dxNext+k*dxNext*dyNext];
  else
    x = 0;
  if (k>0)
    z = LxHyLz_df2[i+j*dxNext+(k-1)*dxNext*dyNext];
  else
    z = 0;
  LxHyLz_n[i+j*dxNext+k*dxNext*dyNext] += -0.25*x - 0.25*z;

  //LLH
  if (j>0)
    y = LxLyHz_df1[i+(j-1)*dxNext+k*dxNext*dyNext];
  else
    y = 0;
  if (i>0)
    x = LxLyHz_df2[(i-1)+j*dxNext+k*dxNext*dyNext];
  else
    x = 0;
  LxLyHz_n[i+j*dxNext+k*dxNext*dyNext] += -0.25*y - 0.25*x;
}
extern "C" __global__ void cu_fwt3df_LC2(_data_t* HxHyLz_df1,_data_t* HxHyLz_df2,_data_t* HxHyLz_n,_data_t* HxLyHz_df1,_data_t* HxLyHz_df2,_data_t* HxLyHz_n,_data_t* LxHyHz_df1,_data_t* LxHyHz_df2,_data_t* LxHyHz_n,int dxNext, int dyNext, int dzNext)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t x,y,z,xGreatZero,yGreatZero,zGreatZero;
  if ((i>=dxNext)||(j>=dyNext)||(k>=dzNext))
    {
      return;
    }

  //HHL
  x = HxHyLz_df1[i+j*dxNext+k*dxNext*dyNext];
  y = HxHyLz_df2[i+j*dxNext+k*dxNext*dyNext];
  z = HxHyLz_n[i+j*dxNext+k*dxNext*dyNext];
  HxHyLz_df1[i+j*dxNext+k*dxNext*dyNext] = 0.5*(x-y);
  HxHyLz_df2[i+j*dxNext+k*dxNext*dyNext] = z;
  zGreatZero = k>0;
  HxHyLz_n[i+j*dxNext+k*dxNext*dyNext] = 0.5*(x+y) + zGreatZero*0.125*z;

  //HLH
  x = HxLyHz_df1[i+j*dxNext+k*dxNext*dyNext];
  y = HxLyHz_df2[i+j*dxNext+k*dxNext*dyNext];
  z = HxLyHz_n[i+j*dxNext+k*dxNext*dyNext];
  HxLyHz_df1[i+j*dxNext+k*dxNext*dyNext] = 0.5*(z-x);
  HxLyHz_df2[i+j*dxNext+k*dxNext*dyNext] = y;
  yGreatZero = j>0;
  HxLyHz_n[i+j*dxNext+k*dxNext*dyNext] = 0.5*(z+x) + yGreatZero*0.125*y;
      
  //LHH
  x = LxHyHz_df1[i+j*dxNext+k*dxNext*dyNext];
  y = LxHyHz_df2[i+j*dxNext+k*dxNext*dyNext];
  z = LxHyHz_n[i+j*dxNext+k*dxNext*dyNext];
  LxHyHz_df1[i+j*dxNext+k*dxNext*dyNext] = 0.5*(y-z);
  LxHyHz_df2[i+j*dxNext+k*dxNext*dyNext] = x;
  xGreatZero = i>0;
  LxHyHz_n[i+j*dxNext+k*dxNext*dyNext] = 0.5*(y+z) + xGreatZero*0.125*x;
}

extern "C" __global__ void cu_fwt3df_LC2_diff(_data_t* HxHyLz_df1,_data_t* HxHyLz_df2,_data_t* HxHyLz_n,_data_t* HxLyHz_df1,_data_t* HxLyHz_df2,_data_t* HxLyHz_n,_data_t* LxHyHz_df1,_data_t* LxHyHz_df2,_data_t* LxHyHz_n,int dxNext, int dyNext, int dzNext)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t x,y,z;
  if ((i>=dxNext)||(j>=dyNext)||(k>=dzNext))
    {
      return;
    }

  //HHL
  if (k>0)
    z = HxHyLz_df2[i+j*dxNext+(k-1)*dxNext*dyNext];
  else 
    z = 0;
  HxHyLz_n[i+j*dxNext+k*dxNext*dyNext] += -0.125*z;

  //HLH
  if (j>0)
    y = HxLyHz_df2[i+(j-1)*dxNext+k*dxNext*dyNext];
  else 
    y = 0;
  HxLyHz_n[i+j*dxNext+k*dxNext*dyNext] += -0.125*y;
      
  //LHH
  if (i>0)
    x = LxHyHz_df2[(i-1)+j*dxNext+k*dxNext*dyNext];
  else 
    x = 0;
  LxHyHz_n[i+j*dxNext+k*dxNext*dyNext] += -0.125*x;
}

extern "C" __global__ void cu_fwt3df_LC3(_data_t* HxHyHz_df1,_data_t* HxHyHz_df2,_data_t* HxHyHz_n,int dxNext, int dyNext, int dzNext)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t x,y,z;
  if ((i>=dxNext)||(j>=dyNext)||(k>=dzNext))
    {
      return;
    }

  //HHH
  x = HxHyHz_df1[i+j*dxNext+k*dxNext*dyNext];
  y = HxHyHz_df2[i+j*dxNext+k*dxNext*dyNext];
  z = HxHyHz_n[i+j*dxNext+k*dxNext*dyNext];
  HxHyHz_df1[i+j*dxNext+k*dxNext*dyNext] = 1.0/3.0*(-2.0*x+y+z);
  HxHyHz_df2[i+j*dxNext+k*dxNext*dyNext] = 1.0/3.0*(-x+2*y-z);
  HxHyHz_n[i+j*dxNext+k*dxNext*dyNext] = 1.0/3.0*(x+y+z);
}

// ############################################################################
// CUDA function of iwt depth convolution.
// Loads data to scratchpad (shared memory) and convolve w/ low pass and high pass
// Scratchpad size: K x 2*dy
// Output: Lz/Hz
// Input:  LxLy,LxHy / HxLy, HxHy, dx, dy, dxNext, dyNext,xOffset, yOffset,lod, hid, filterLen
// ############################################################################
extern "C" __global__ void cu_iwt3df_dep(_data_t *out, _data_t *Lz, _data_t *Hz, int dx, int dy,int dz,int dxNext, int dyNext, int dzNext,int xOffset, int yOffset,int zOffset,scalar_t *lod, scalar_t *hid, int filterLen)
{
  extern __shared__ _data_t deps [];
  int const K = blockDim.x;

  int ti = threadIdx.x;
  int tk = threadIdx.z;
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  if (i>=dx){
    return;
  }
  for (int k = tk; k < dz; k += blockDim.z){
    deps[ti + k*K] = Lz[i + j*dx + k*dx*dy];
    deps[ti + (k+dz)*K] = Hz[i + j*dx + k*dx*dy];
  }
  __syncthreads();

  // Low-Pass and High Pass Downsample
  int ind;
  for (int k = tk+zOffset; k < dzNext+zOffset; k += blockDim.z){
	
    _data_t y = deps[0]-deps[0];
#pragma unroll
    for (int f = (k-(filterLen-1)) & 1; f < filterLen; f+=2){
      ind = (k-(filterLen-1)+f)>>1;
      if ((ind >= 0) && (ind < dz)) {
	y += deps[ti + ind*K] * lod[filterLen-1-f];
	y += deps[ti + (ind+dz)*K] * hid[filterLen-1-f];
      }
    }
	
    out[i + j*dx + (k-zOffset)*dx*dy] = y;
  }
}

// ############################################################################
// CUDA function of iwt row convolution. Assumes fwt_col() has already been called.
// Loads data to scratchpad (shared memory) and convolve w/ low pass and high pass
// Scratchpad size: K x 2*dy
// Output: Lx/Hx
// Input:  LxLy,LxHy / HxLy, HxHy, dx, dy, dxNext, dyNext,xOffset, yOffset,lod, hid, filterLen
// ############################################################################
extern "C" __global__ void cu_iwt3df_row(_data_t *out, _data_t *Ly, _data_t *Hy, int dx, int dy,int dz,int dxNext, int dyNext,int dzNext,int xOffset, int yOffset, int zOffset,scalar_t *lod, scalar_t *hid, int filterLen)
{
  extern __shared__ _data_t rows [];
  int const K = blockDim.x;

  int ti = threadIdx.x;
  int tj = threadIdx.y;
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  if (i>=dx){
    return;
  }
  for (int j = tj; j < dy; j += blockDim.y){
    rows[ti + j*K] = Ly[i + j*dx + k*dx*dy];
    rows[ti + (j+dy)*K] = Hy[i + j*dx + k*dx*dy];
  }
  __syncthreads();

  // Low-Pass and High Pass Downsample
  int ind;
  for (int j = tj+yOffset; j < dyNext+yOffset; j += blockDim.y){
	
    _data_t y = rows[0]-rows[0];
#pragma unroll
    for (int f = (j-(filterLen-1)) & 1; f < filterLen; f+=2){
      ind = (j-(filterLen-1)+f)>>1;
      if ((ind >= 0) && (ind < dy)) {
	y += rows[ti + ind*K] * lod[filterLen-1-f];
	y += rows[ti + (ind+dy)*K] * hid[filterLen-1-f];
      }
    }
	
    out[i + (j-yOffset)*dx + k*dx*dyNext] = y;
  }
}

// ############################################################################
// CUDA function of iwt column convolution
// Loads data to scratchpad (shared memory) and convolve w/ low pass and high pass
// Scratchpad size: 2*dx x K
// Output: out
// Input:  Lx, Hx, dx, dy, dxNext, dyNext, lod, hid, filterLen
// ############################################################################
extern "C" __global__ void cu_iwt3df_col(_data_t *out, _data_t *Lx, _data_t *Hx, int dx, int dy,int dz,int dxNext, int dyNext, int dzNext,int xOffset, int yOffset, int zOffset,scalar_t *lod, scalar_t *hid, int filterLen)
{
  extern __shared__ _data_t cols [];

  int ti = threadIdx.x;
  int tj = threadIdx.y;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  if (j>=dyNext){
    return;
  }
  int dx2 = 2*dx;
  // Load Input to Temp Array
  for (int i = ti; i < dx; i += blockDim.x){
    cols[i + tj*dx2] = Lx[i + j*dx + k*dx*dyNext];
    cols[dx+i + tj*dx2] = Hx[i + j*dx + k*dx*dyNext];
  }
  __syncthreads();

  // Low-Pass and High Pass Downsample
  int ind;
  for (int i = ti+xOffset; i < dxNext+xOffset; i += blockDim.x){
    _data_t y = cols[0]-cols[0];
#pragma unroll
    for (int f = (i-(filterLen-1)) & 1; f < filterLen; f+=2){
      ind = (i-(filterLen-1)+f)>>1;
      if (ind >= 0 && ind < dx) {
	y += cols[ind + tj*dx2] * lod[filterLen-1-f];
	y += cols[dx+ind + tj*dx2] * hid[filterLen-1-f];
      }
    }
    out[(i-xOffset) + j*dxNext + k*dxNext*dyNext] = y;
  }
}

extern "C" __global__ void cu_iwt3df_LC1 (_data_t *HxLyLz_df1,_data_t *HxLyLz_df2,_data_t *HxLyLz_n,_data_t *LxHyLz_df1,_data_t *LxHyLz_df2,_data_t *LxHyLz_n,_data_t *LxLyHz_df1,_data_t *LxLyHz_df2,_data_t *LxLyHz_n,int dx, int dy, int dz)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t df1,df2,n,xGreatZero,yGreatZero,zGreatZero;
  if ((i>=dx)||(j>=dy)||(k>=dz))
    {
      return;
    }

  //HLL
  df1 = HxLyLz_df1[i+j*dx+k*dx*dy];
  df2 = HxLyLz_df2[i+j*dx+k*dx*dy];
  n = HxLyLz_n[i+j*dx+k*dx*dy];
  HxLyLz_df2[i+j*dx+k*dx*dy] = df1;
  HxLyLz_n[i+j*dx+k*dx*dy] = df2;
  yGreatZero = j>0;
  zGreatZero = k>0;
  HxLyLz_df1[i+j*dx+k*dx*dy] = n - yGreatZero*0.25*df1 - zGreatZero*0.25*df2;

  //LHL
  df1 = LxHyLz_df1[i+j*dx+k*dx*dy];
  df2 = LxHyLz_df2[i+j*dx+k*dx*dy];
  n = LxHyLz_n[i+j*dx+k*dx*dy];
  LxHyLz_n[i+j*dx+k*dx*dy] = df2;
  xGreatZero = i>0;
  zGreatZero = k>0;
  LxHyLz_df2[i+j*dx+k*dx*dy] = n - xGreatZero*0.25*df1 - zGreatZero*0.25*df2;
      
  //LLH
  df1 = LxLyHz_df1[i+j*dx+k*dx*dy];
  df2 = LxLyHz_df2[i+j*dx+k*dx*dy];
  n = LxLyHz_n[i+j*dx+k*dx*dy];
  LxLyHz_df1[i+j*dx+k*dx*dy] = df2;
  LxLyHz_df2[i+j*dx+k*dx*dy] = df1;
  yGreatZero = j>0;
  xGreatZero = i>0;
  LxLyHz_n[i+j*dx+k*dx*dy] = n - yGreatZero*0.25*df1 - xGreatZero*0.25*df2;
}

extern "C" __global__ void cu_iwt3df_LC1_diff (_data_t *HxLyLz_df1,_data_t *HxLyLz_df2,_data_t *HxLyLz_n,_data_t *LxHyLz_df1,_data_t *LxHyLz_df2,_data_t *LxHyLz_n,_data_t *LxLyHz_df1,_data_t *LxLyHz_df2,_data_t *LxLyHz_n,int dx, int dy, int dz)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t x,y,z;
  if ((i>=dx)||(j>=dy)||(k>=dz))
    {
      return;
    }

  //HLL
  if (j>0)
    y = HxLyLz_df2[i+(j-1)*dx+k*dx*dy];
  else
    y = 0;
  if (k>0)
    z = HxLyLz_n[i+j*dx+(k-1)*dx*dy];
  else
    z = 0;
  HxLyLz_df1[i+j*dx+k*dx*dy] += 0.25*y + 0.25*z;

  //LHL
  if (i>0)
    x = LxHyLz_df1[(i-1)+j*dx+k*dx*dy];
  else
    x = 0;
  if (k>0)
    z = LxHyLz_n[i+j*dx+(k-1)*dx*dy];
  else
    z = 0;
  LxHyLz_df2[i+j*dx+k*dx*dy] += 0.25*x + 0.25*z;

  //LLH
  if (j>0)
    y = LxLyHz_df2[i+(j-1)*dx+k*dx*dy];
  else
    y = 0;
  if (i>0)
    x = LxLyHz_df1[(i-1)+j*dx+k*dx*dy];
  else
    x = 0;
  LxLyHz_n[i+j*dx+k*dx*dy] += 0.25*y + 0.25*x;
}

extern "C" __global__ void cu_iwt3df_LC2 (_data_t* HxHyLz_df1,_data_t* HxHyLz_df2,_data_t* HxHyLz_n,_data_t* HxLyHz_df1,_data_t* HxLyHz_df2,_data_t* HxLyHz_n,_data_t* LxHyHz_df1,_data_t* LxHyHz_df2,_data_t* LxHyHz_n,int dx, int dy, int dz)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t df1,df2,n,xGreatZero,yGreatZero,zGreatZero;
  if ((i>=dx)||(j>=dy)||(k>=dz))
    {
      return;
    }

  //HHL
  df1 = HxHyLz_df1[i+j*dx+k*dx*dy];
  df2 = HxHyLz_df2[i+j*dx+k*dx*dy];
  n = HxHyLz_n[i+j*dx+k*dx*dy];
  HxHyLz_n[i+j*dx+k*dx*dy] = df2;
  zGreatZero = k>0;
  HxHyLz_df1[i+j*dx+k*dx*dy] = df1+n-zGreatZero*0.125*df2;
  HxHyLz_df2[i+j*dx+k*dx*dy] = -df1+n-zGreatZero*0.125*df2;

  //HLH
  df1 = HxLyHz_df1[i+j*dx+k*dx*dy];
  df2 = HxLyHz_df2[i+j*dx+k*dx*dy];
  n = HxLyHz_n[i+j*dx+k*dx*dy];
  HxLyHz_df2[i+j*dx+k*dx*dy] = df2;
  yGreatZero = j>0;
  HxLyHz_n[i+j*dx+k*dx*dy] = df1+n-yGreatZero*0.125*df2;
  HxLyHz_df1[i+j*dx+k*dx*dy] = -df1+n-yGreatZero*0.125*df2;
      
  //LHH
  df1 = LxHyHz_df1[i+j*dx+k*dx*dy];
  df2 = LxHyHz_df2[i+j*dx+k*dx*dy];
  n = LxHyHz_n[i+j*dx+k*dx*dy];
  LxHyHz_df1[i+j*dx+k*dx*dy] = df2;
  xGreatZero = i>0;
  LxHyHz_df2[i+j*dx+k*dx*dy] = df1+n-xGreatZero*0.125*df2;
  LxHyHz_n[i+j*dx+k*dx*dy] = -df1+n-xGreatZero*0.125*df2;
}

extern "C" __global__ void cu_iwt3df_LC2_diff (_data_t* HxHyLz_df1,_data_t* HxHyLz_df2,_data_t* HxHyLz_n,_data_t* HxLyHz_df1,_data_t* HxLyHz_df2,_data_t* HxLyHz_n,_data_t* LxHyHz_df1,_data_t* LxHyHz_df2,_data_t* LxHyHz_n,int dx, int dy, int dz)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t x,y,z;
  if ((i>=dx)||(j>=dy)||(k>=dz))
    {
      return;
    }

  //HHL
  if (k>0)
    z = HxHyLz_n[i+j*dx+(k-1)*dx*dy];
  else 
    z = 0;
  HxHyLz_df1[i+j*dx+k*dx*dy] += 0.125*z;
  HxHyLz_df2[i+j*dx+k*dx*dy] += 0.125*z;

  //HLH
  if (j>0)
    y = HxLyHz_df2[i+(j-1)*dx+k*dx*dy];
  else 
    y = 0;
  HxLyHz_df1[i+j*dx+k*dx*dy] += 0.125*y;
  HxLyHz_n[i+j*dx+k*dx*dy] += 0.125*y;
      
  //LHH
  if (i>0)
    x = LxHyHz_df1[(i-1)+j*dx+k*dx*dy];
  else 
    x = 0;
  LxHyHz_df2[i+j*dx+k*dx*dy] += 0.125*x;
  LxHyHz_n[i+j*dx+k*dx*dy] += 0.125*x;
}

extern "C" __global__ void cu_iwt3df_LC3 (_data_t* HxHyHz_df1,_data_t* HxHyHz_df2,_data_t* HxHyHz_n,int dx, int dy, int dz)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  int k = blockIdx.z*blockDim.z+threadIdx.z;
  _data_t df1,df2,n;
  if ((i>=dx)||(j>=dy)||(k>=dz))
    {
      return;
    }

  //HHH
  df1 = HxHyHz_df1[i+j*dx+k*dx*dy];
  df2 = HxHyHz_df2[i+j*dx+k*dx*dy];
  n = HxHyHz_n[i+j*dx+k*dx*dy];
  HxHyHz_df1[i+j*dx+k*dx*dy] = -df1+n;
  HxHyHz_df2[i+j*dx+k*dx*dy] = df2+n;
  HxHyHz_n[i+j*dx+k*dx*dy] = df1-df2+n;
}
extern "C" __global__ void cu_mult(_data_t* in, _data_t mult, int maxInd)
{
  int ind = blockIdx.x*blockDim.x+threadIdx.x;
  if (ind > maxInd)
    {
      return;
    }
  in[ind] = in[ind]*mult;
}

extern "C" __global__ void cu_add(_data_t* out, _data_t* in, int maxInd)
{
  int ind = blockIdx.x*blockDim.x+threadIdx.x;
  if (ind > maxInd)
    {
      return;
    }
  out[ind] += in[ind];
}

extern "C" __global__ void cu_add_mult(_data_t* out, _data_t* in, _data_t mult, int maxInd)
{
  int ind = blockIdx.x*blockDim.x+threadIdx.x;
  if (ind > maxInd)
    {
      return;
    }
  _data_t i = out[ind];
  out[ind] = i+(out[ind]-i)*mult;
}

__global__ void cu_soft_thresh (_data_t* in, scalar_t thresh, int numMax)
{
  int const i = threadIdx.x + blockDim.x*blockIdx.x;
  if (i>numMax)
    return;
  scalar_t norm = abs(in[i]);
  scalar_t red = norm - thresh;
  in[i] = (red > 0.f) ? ((red / norm) * (in[i])) : in[i]-in[i];
}

__global__ void cu_circshift(_data_t* data, _data_t* dataCopy, int dx, int dy, int dz,int shift1, int shift2,int shift3) {

  int index = blockIdx.x*blockDim.x + threadIdx.x;

  if (index >= dx*dy*dz) {
    return;
  }
  int indexShifted = (index+shift1+shift2*dx+shift3*dx*dy)%(dx*dy*dz);
  data[indexShifted] = dataCopy[index];
}

__global__ void cu_circunshift(_data_t* data, _data_t* dataCopy, int dx, int dy, int dz,int shift1, int shift2,int shift3) {

  int index = blockIdx.x*blockDim.x + threadIdx.x;

  if (index >= dx*dy*dz) {
    return;
  }
  int indexShifted = (index+shift1+shift2*dx+shift3*dx*dy)%(dx*dy*dz);
  data[index] = dataCopy[indexShifted];
}

