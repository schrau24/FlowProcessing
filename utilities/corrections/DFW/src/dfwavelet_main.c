// Testing function for dfwavelet

#include "dfwavelet.h"
#include <string.h>
#include <stdio.h>
#include <omp.h>
#include <stdlib.h>
#include <complex.h>
#include <time.h>
#include <sys/time.h>

void timestamp()
{
  time_t ltime; /* calendar time */
  ltime=time(NULL); /* get current cal time */
  printf("%s",asctime( localtime(&ltime) ) );
}

int main(int argc, char* argv[])
{
  //Initialize
  int numdims = 3;
  int imSize[] = {32,32,32};
  int minSize[] = {8,8,8};
  int numPixel = imSize[0]*imSize[1]*imSize[2];
  scalar_t res[] = {1.,1.,1.};
  data_t* in_vx = (data_t*) malloc(sizeof(data_t)*numPixel);
  data_t* in_vy = (data_t*) malloc(sizeof(data_t)*numPixel);
  data_t* in_vz = (data_t*) malloc(sizeof(data_t)*numPixel);
  data_t* out_vx_cpu = (data_t*) malloc(sizeof(data_t)*numPixel);
  data_t* out_vy_cpu = (data_t*) malloc(sizeof(data_t)*numPixel);
  data_t* out_vz_cpu = (data_t*) malloc(sizeof(data_t)*numPixel);
#ifdef USE_CUDA
  data_t* out_vx_gpu = (data_t*) malloc(sizeof(data_t)*numPixel);
  data_t* out_vy_gpu = (data_t*) malloc(sizeof(data_t)*numPixel);
  data_t* out_vz_gpu = (data_t*) malloc(sizeof(data_t)*numPixel);
#endif

  // ******* Generate Data ******* 
  int i;
  for(i = 0; i < numPixel; i++) {
    in_vx[i] = ((data_t)rand()/RAND_MAX-0.5);
    in_vy[i] = ((data_t)rand()/RAND_MAX-0.5);
    in_vz[i] = ((data_t)rand()/RAND_MAX-0.5);
    in_vx[i] = 1.;
    in_vy[i] = 1.;
    in_vz[i] = 1.;
  }

  // ******* Initialize Plan ******* 
  int no_gpu = 0;
  int use_gpu = 2;
  float dfthresh = .0f;
  float nthresh = .0f;
  float sigma = .0f;
  int spins = 2;
  int isRand = 1;
  struct dfwavelet_plan_s* plan_cpu = prepare_dfwavelet_plan(numdims,imSize,minSize,res,no_gpu);
#ifdef USE_CUDA
  struct dfwavelet_plan_s* plan_gpu = prepare_dfwavelet_plan(numdims,imSize,minSize,res,use_gpu);
#endif
  print_plan(plan_cpu);
  double t;
  struct timeval tv;
  float max,min;
  int count;

  // ******* CPU ********
  printf("CPU Wavelet Thresh:\n");
  gettimeofday(&tv,NULL);
  t = tv.tv_sec+tv.tv_usec*1e-6; // microseconds

  dfwavelet_thresh(plan_cpu,sigma,sigma,out_vx_cpu,out_vy_cpu,out_vz_cpu,in_vx,in_vy,in_vz);

  //dfwavelet_thresh_SURE_spin(plan_cpu,sigma,spins,isRand,out_vx_cpu,out_vy_cpu,out_vz_cpu,in_vx,in_vy,in_vz);
  //dfwavelet_thresh_SURE(plan_cpu,sigma,out_vx_cpu,out_vy_cpu,out_vz_cpu,in_vx,in_vy,in_vz);


  gettimeofday(&tv,NULL);
  t = tv.tv_sec+tv.tv_usec*1e-6-t;
  printf("Time Elapsed for CPU: %lf sec\n",t);

  // ******* Check CPU result ******* 
  max = -100000;
  min = 100000;
  count = 0;
  for(i = 0; i < numPixel; i++) {
    float diff = cabsf(out_vx_cpu[i] - in_vx[i])+cabsf(out_vy_cpu[i] - in_vy[i])+cabsf(out_vz_cpu[i] - in_vz[i]);
    if(diff < min) {
      min = diff;
    }
    if(diff > max) {
      max = diff;
    }
    if(diff > 0.001 || diff < -0.001) {
      count++;
    }
  }
  if (max>0.1)
    printf("Does not match with original, Maxx=%f\n\n",max);
  else
    printf("Done. Match with original\n\n");

#ifdef USE_CUDA
  // ******* GPU ******* 
  printf("GPU Wavelet Thresh:\n");
  gettimeofday(&tv,NULL);
  t = tv.tv_sec+tv.tv_usec*1e-6; // microseconds

  dfwavelet_thresh(plan_gpu,sigma,sigma,out_vx_gpu,out_vy_gpu,out_vz_gpu,in_vx,in_vy,in_vz);
  

  gettimeofday(&tv,NULL);
  t = tv.tv_sec+tv.tv_usec*1e-6-t;
  printf("Time Elapsed for GPU: %lf sec\n",t);
  // ******* Check GPU result ******* 
  for(i = 0; i < numPixel; i++) {
    float diff = cabs(out_vx_gpu[i] - in_vx[i]);
    if(diff < min) {
      min = diff;
    }
    if(diff > max) {
      max = diff;
    }
    if(diff > 0.01 || diff < -0.01) {
      count++;
    }
  }
  if (max>0.1)
    printf("Does not match with original, Maxx=%f\n\n",max);
  else
    printf("Done. Match with original\n\n");

  // ******* Check CPU VX - GPU VX ******* 
  printf("CPU vx -GPU vx:\n");
  max = -100000;
  min = 100000;
  count = 0;
  for(i = 0; i < numPixel; i++) {
    float diff = cabs(out_vx_cpu[i] - out_vx_gpu[i]);
    if(diff < min) {
      min = diff;
    }
    if(diff > max) {
      max = diff;
    }
    if(diff > 0.01 || diff < -0.01) {
      count++;
    }
  }
  if (max>0.001)
    printf("CPU-GPU does not match, Maxx=%f\n\n",max);
  else
    printf("Done. CPU-GPU match\n\n");
  
  // ******* Check CPU-GPU Coeff ******* 
  long numCoeff = plan_cpu->numCoeff;
  data_t* wcdf1_cpu = (data_t*) malloc(sizeof(data_t)*numCoeff);
  data_t* wcdf2_cpu = (data_t*) malloc(sizeof(data_t)*numCoeff);
  data_t* wcn_cpu = (data_t*) malloc(sizeof(data_t)*numCoeff);
  data_t* wcdf1_gpu = (data_t*) malloc(sizeof(data_t)*numCoeff);
  data_t* wcdf2_gpu = (data_t*) malloc(sizeof(data_t)*numCoeff);
  data_t* wcn_gpu = (data_t*) malloc(sizeof(data_t)*numCoeff);
  dfwavelet_clear_randshift(plan_cpu);
  dfwavelet_clear_randshift(plan_gpu);

  printf("CPU-GPU Check Coeff:\n");
  dfwavelet_forward(plan_cpu, wcdf1_cpu,wcdf2_cpu,wcn_cpu, in_vx, in_vy,in_vz);
  dfwavelet_forward(plan_gpu, wcdf1_gpu,wcdf2_gpu,wcn_gpu, in_vx, in_vy,in_vz);

  max = -100000;
  min = 100000;
  // Check CPU-GPU result
  for(i = 0; i < numCoeff; i++) {
    float diff = cabs(wcdf1_cpu[i] - wcdf1_gpu[i]);
    if(diff < min) {
      min = diff;
    }
    if(diff > max) {
      max = diff;
    }
  }


  if (max>0.001)
    printf("Wrong Answer, Maxx=%f\n\n",max);
  else
    printf("Done. Correct Answer\n\n");
  
#endif

  free(in_vx);
  free(in_vy);
  free(in_vz);
  free(out_vx_cpu);
  free(out_vy_cpu);
  free(out_vz_cpu);
  dfwavelet_free(plan_cpu);
#ifdef USE_CUDA
  dfwavelet_free(plan_gpu);
  free(out_vx_gpu);
  free(out_vy_gpu);
  free(out_vz_gpu);
#endif
  return 0;
  
}
