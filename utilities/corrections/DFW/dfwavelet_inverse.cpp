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

/* Output Arguments */

#define	VX_OUT	plhs[0]
#define	VY_OUT	plhs[1]
#define	VZ_OUT	plhs[2]

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
  double *in_wcdf1,*in_wcdf2,*in_wcn, *out_vx,*out_vy,*out_vz, *minSizeDouble,*res,*fovDouble;
  int *dims,*minSize;
  double* numlevels;
  double* wcSizes;
  
  /* Check for proper number of arguments */
  
  if (nrhs !=6) {
    mexErrMsgTxt("dfwavelet_inverse requires 6 input arguments.");
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
  
  // Create a matrix for the return argument 
  VX_OUT = mxCreateNumericArray(3, dims, mxDOUBLE_CLASS, mxREAL);
  VY_OUT = mxCreateNumericArray(3, dims, mxDOUBLE_CLASS, mxREAL);
  VZ_OUT = mxCreateNumericArray(3, dims, mxDOUBLE_CLASS, mxREAL);

  out_vx = mxGetPr(VX_OUT);
  out_vy = mxGetPr(VY_OUT);
  out_vz = mxGetPr(VZ_OUT);
  
  // Do the actual computations in a subroutine
  dfwavelet_inverse(plan,out_vx,out_vy,out_vz,in_wcdf1,in_wcdf2,in_wcn);
  
  dfwavelet_free(plan);
  free(minSize);
  free(dims);
  return;
}
