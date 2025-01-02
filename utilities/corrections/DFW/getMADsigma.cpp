#include "dfwavelet.h"
#include <math.h>
#include "mex.h"
#include <stdio.h>

/* Input Arguments */

#define	WCN_IN	prhs[0]
#define	MINSIZE_IN	prhs[1]
#define RES_IN prhs[2]
#define FOV_IN prhs[3]
#define PERCENTZERO_IN prhs[4]

/* Output Arguments */

#define	SIGMA_OUT	plhs[0]

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
  double *in_wcn, *out_sigma, *minSizeDouble,*res,*fovDouble;
  int *dims,*minSize;
  double* numlevels;
  double* wcSizes;
  double percentZero;
  
  /* Check for proper number of arguments */
  
  if (nrhs !=5) {
    mexErrMsgTxt("dfsoft_thresh requires 5 input arguments.");
  }

  if (mxIsComplex(WCN_IN))
    mexErrMsgTxt ("Input must be real");
  
  
  // Assign pointers to the various parameters
  in_wcn = (double*) mxGetData(WCN_IN);
  res = (double*) mxGetData(RES_IN);
  minSizeDouble = (double*) mxGetData(MINSIZE_IN);
  minSize = (int*) malloc(sizeof(int)*3);
  fovDouble = (double*) mxGetData(FOV_IN);
  percentZero = mxGetPr(PERCENTZERO_IN)[0];
  dims = (int*) malloc(sizeof(int)*3);
  int i;
  for (i = 0; i<3; i++)
    {
      minSize[i] = (int) (minSizeDouble[i]);
      dims[i] = (int) fovDouble[i];
    }
  struct dfwavelet_plan_s* plan = prepare_dfwavelet_plan(3,dims,minSize,res,0);
  plan->percentZero = percentZero;
  
  dims[0] = 1;
  SIGMA_OUT = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxREAL);

  // Create a matrix for the return argument 
  out_sigma = mxGetPr(SIGMA_OUT);
  
  // Do the actual computations in a subroutine
  double sigma = getMADsigma_cpu(plan, in_wcn);
  out_sigma[0] = sigma;

  
  dfwavelet_free(plan);
  free(minSize);
  free(dims);
  return;
}
