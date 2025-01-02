#include "dfwavelet.h"
#include <math.h>
#include "mex.h"
#include <stdio.h>

/* Input Arguments */

#define	WCDF1_IN   prhs[0]
#define	WCDF2_IN	prhs[1]
#define	WCN_IN	prhs[2]
#define	MINSIZE_IN	prhs[3]
#define RES_IN prhs[4]
#define FOV_IN prhs[5]
#define DFTHRESH_IN prhs[6]
#define NTHRESH_IN prhs[7]

/* Output Arguments */

#define	WCDF1_OUT	plhs[0]
#define	WCDF2_OUT	plhs[1]
#define	WCN_OUT	plhs[2]

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
  double *in_wcdf1,*in_wcdf2,*in_wcn, *out_wcdf1,*out_wcdf2,*out_wcn, *minSizeDouble,*res,*fovDouble;
  int *dims,*minSize;
  double* numlevels;
  double* wcSizes;
  double dfthresh,nthresh;
  
  /* Check for proper number of arguments */
  
  if (nrhs !=8) {
    mexErrMsgTxt("dfsoft_thresh requires 8 input arguments.");
  }

  if (mxIsComplex(WCDF1_IN))
    mexErrMsgTxt ("Input must be real");
  
  
  // Assign pointers to the various parameters
  in_wcdf1 = (double*) mxGetData(WCDF1_IN);
  in_wcdf2 = (double*) mxGetData(WCDF2_IN);
  in_wcn = (double*) mxGetData(WCN_IN);
  res = (double*) mxGetData(RES_IN);
  minSizeDouble = (double*) mxGetData(MINSIZE_IN);
  minSize = (int*) malloc(sizeof(int)*3);
  fovDouble = (double*) mxGetData(FOV_IN);
  dims = (int*) malloc(sizeof(int)*3);
  int i;
  for (i = 0; i<3; i++)
    {
      minSize[i] = (int) (minSizeDouble[i]);
      dims[i] = (int) fovDouble[i];
    }
  struct dfwavelet_plan_s* plan = prepare_dfwavelet_plan(3,dims,minSize,res,0);
  
  dims[0] = 1;
  dims[1] = plan->numCoeff;
  
  dfthresh = mxGetPr(DFTHRESH_IN)[0];
  nthresh = mxGetPr(NTHRESH_IN)[0];
  
  // Create a matrix for the return argument 
  WCDF1_OUT = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);
  WCDF2_OUT = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);
  WCN_OUT = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);

  out_wcdf1 = mxGetPr(WCDF1_OUT);
  out_wcdf2 = mxGetPr(WCDF2_OUT);
  out_wcn = mxGetPr(WCN_OUT);
  
  for ( i = 0; i < plan->numCoeff; i++)
  {
      out_wcdf1[i] = in_wcdf1[i];
      out_wcdf2[i] = in_wcdf2[i];
      out_wcn[i] = in_wcn[i];
  }
  
  // Do the actual computations in a subroutine
  dfsoft_thresh(plan,dfthresh,nthresh,out_wcdf1,out_wcdf2,out_wcn);
  
  dfwavelet_free(plan);
  free(minSize);
  free(dims);
  return;
}
