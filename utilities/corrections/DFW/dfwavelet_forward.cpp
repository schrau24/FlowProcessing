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

#define	WCDF1_OUT	plhs[0]
#define	WCDF2_OUT	plhs[1]
#define	WCN_OUT	plhs[2]
#define NUMLEVELS plhs[3]
#define WC_SIZES plhs[4]

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
  double *in_vx,*in_vy,*in_vz, *out_wcdf1,*out_wcdf2,*out_wcn, *minSizeDouble,*res;
  int *dims,*minSize;
  double* numlevels;
  double* wcSizes;
  struct dfwavelet_plan_s* plan;
  int i;
  
  /* Check for proper number of arguments */
  
  if (nrhs !=5) {
    mexErrMsgTxt("dfwavelet_forward requires 5 input arguments.");
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
  dims = (int*) mxGetDimensions(VX_IN);
  for (i = 0; i<3; i++)
    {
      minSize[i] = (int) (minSizeDouble[i]);
    }
  plan = prepare_dfwavelet_plan(3,dims,minSize,res,0);
  
  dims[0] = 1;
  dims[1] = plan->numCoeff;
  
  // Create a matrix for the return argument 
  WCDF1_OUT = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);
  WCDF2_OUT = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);
  WCN_OUT = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);
  NUMLEVELS = mxCreateNumericArray(1,dims,mxDOUBLE_CLASS,mxREAL);
  dims[1] = (plan->numLevels+2)*3;
  WC_SIZES = mxCreateNumericArray(2,dims,mxDOUBLE_CLASS,mxREAL);

  out_wcdf1 = mxGetPr(WCDF1_OUT);
  out_wcdf2 = mxGetPr(WCDF2_OUT);
  out_wcn = mxGetPr(WCN_OUT);
  numlevels = mxGetPr(NUMLEVELS);
  wcSizes = mxGetPr(WC_SIZES);

  numlevels[0] = plan->numLevels;
  for (i=0;i<(plan->numLevels+2)*3;i++)
    wcSizes[i] = plan->waveSizes[i];
  
  // Do the actual computations in a subroutine
  dfwavelet_forward(plan,out_wcdf1,out_wcdf2,out_wcn,in_vx,in_vy,in_vz);
  
  dfwavelet_free(plan);
  free(minSize);
  return;
}
