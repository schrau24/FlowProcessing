#include "dfwavelet.h"
#include <math.h>
#include "mex.h"
#include <stdio.h>

/* Input Arguments */

#define	VX_IN	prhs[0]
#define	VY_IN	prhs[1]
#define	VZ_IN	prhs[2]
#define	MINSIZE_IN	prhs[3]
#define RES_IN prhs[4]

/* Output Arguments */

#define	VX_OUT	plhs[0]
#define	VY_OUT	plhs[1]
#define	VZ_OUT	plhs[2]

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
  double *in_vx,*in_vy,*in_vz, *out_vx,*out_vy,*out_vz, *minSizeDouble,*res;
  int * dimsint;
  int *dims,*minSize;
  
  /* Check for proper number of arguments */
  
  if (nrhs !=5) {
    mexErrMsgTxt("dfwavelet_thresh requires 5 input arguments.");
  }

  if (mxIsComplex(VX_IN))
    mexErrMsgTxt ("Input must be real");
  
  
  // Assign pointers to the various parameters
  in_vx = (double*) mxGetData(VX_IN);
  in_vy = (double*) mxGetData(VY_IN);
  in_vz = (double*) mxGetData(VZ_IN);
  res = (double*) mxGetData(RES_IN);
  minSizeDouble = (double*) mxGetData(MINSIZE_IN);
  minSize = (int*) malloc(sizeof(int)*3);
  dimsint = (int*) mxGetDimensions(VX_IN);
  dims = (int*) malloc(sizeof(int)*3);
  int i;
  for (i = 0; i<3; i++)
    {
      minSize[i] = (int) (minSizeDouble[i]);
      dims[i] = (int) (dimsint[i]);
    }
  
  // Create a matrix for the return argument 
  VX_OUT = mxCreateNumericArray(3, dimsint, mxDOUBLE_CLASS, mxREAL);
  VY_OUT = mxCreateNumericArray(3, dimsint, mxDOUBLE_CLASS, mxREAL);
  VZ_OUT = mxCreateNumericArray(3, dimsint, mxDOUBLE_CLASS, mxREAL);

  out_vx = mxGetPr(VX_OUT);
  out_vy = mxGetPr(VY_OUT);
  out_vz = mxGetPr(VZ_OUT);

  int use_gpu = 0;
#ifdef USE_CUDA
  use_gpu = 2;
#endif
  
  // Do the actual computations in a subroutine
  struct dfwavelet_plan_s* plan = prepare_dfwavelet_plan(3,dims,minSize,res,use_gpu);
  dfwavelet_thresh_SURE_MAD(plan,out_vx,out_vy,out_vz,in_vx,in_vy,in_vz);
  
  dfwavelet_free(plan);
  free(dims);
  free(minSize);
  return;
}
