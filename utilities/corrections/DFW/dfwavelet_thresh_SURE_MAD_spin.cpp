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
#define SPINS_IN prhs[5]
#define ISRAND_IN prhs[6]

/* Output Arguments */
#define	VX_OUT	plhs[0]
#define	VY_OUT	plhs[1]
#define	VZ_OUT	plhs[2]

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
    double *in_vx, *in_vy, *in_vz;
    double *out_vx, *out_vy, *out_vz;
    double *minSizeDouble, *res;

    const mwSize *dims_mw;   // MATLAB dims
    mwSize *dims_mw_copy;    // local copy (mwSize)
    mwSize *minSize_mw;      // minSize as mwSize for MATLAB

    int *dims_int;           // dims passed to dfwavelet (int)
    int *minSize_int;        // minSize passed to dfwavelet (int)

  int spins,isRand;
    int i;
  
    /* Check number of inputs */
  if (nrhs !=7) {
    mexErrMsgTxt("dfwavelet_thresh requires 7 input arguments.");
  }

    /* Check that VX is real */
    if (mxIsComplex(VX_IN)) {
        mexErrMsgTxt("Input must be real.");
    }
  
    /* --- Get pointers to input data --- */
  in_vx = (double*) mxGetData(VX_IN);
  in_vy = (double*) mxGetData(VY_IN);
  in_vz = (double*) mxGetData(VZ_IN);
  res = (double*) mxGetData(RES_IN);
  minSizeDouble = (double*) mxGetData(MINSIZE_IN);

    /* --- Get MATLAB dimensions --- */
    dims_mw = mxGetDimensions(VX_IN);

    /* --- Allocate dimension arrays --- */
    dims_mw_copy = (mwSize*) mxMalloc(3 * sizeof(mwSize));
    minSize_mw   = (mwSize*) mxMalloc(3 * sizeof(mwSize));

    dims_int     = (int*) mxMalloc(3 * sizeof(int));
    minSize_int  = (int*) mxMalloc(3 * sizeof(int));

    /* --- Convert dims and minSize --- */
    for (i = 0; i < 3; i++) {
        dims_mw_copy[i] = dims_mw[i];
        minSize_mw[i]   = (mwSize) minSizeDouble[i];

        dims_int[i]     = (int) dims_mw_copy[i];
        minSize_int[i]  = (int) minSize_mw[i];
    }
  
    /* --- Create output arrays --- */
    VX_OUT = mxCreateNumericArray(3, dims_mw, mxDOUBLE_CLASS, mxREAL);
    VY_OUT = mxCreateNumericArray(3, dims_mw, mxDOUBLE_CLASS, mxREAL);
    VZ_OUT = mxCreateNumericArray(3, dims_mw, mxDOUBLE_CLASS, mxREAL);

  out_vx = mxGetPr(VX_OUT);
  out_vy = mxGetPr(VY_OUT);
  out_vz = mxGetPr(VZ_OUT);

    /* --- Scalars --- */
  spins = (int) mxGetPr(SPINS_IN)[0];
  isRand = (int) mxGetPr(ISRAND_IN)[0];

    /* --- GPU Flag --- */
    int use_gpu = 0;
#ifdef USE_CUDA
  use_gpu = 2;
#endif
  
    /* --- Prepare wavelet plan --- */
    struct dfwavelet_plan_s* plan =
        prepare_dfwavelet_plan(3, dims_int, minSize_int, res, use_gpu);

    /* --- Run transform --- */
    dfwavelet_thresh_SURE_MAD_spin(
        plan, spins, isRand,
        out_vx, out_vy, out_vz,
        in_vx,  in_vy,  in_vz
    );
  
    /* --- Cleanup --- */
  dfwavelet_free(plan);

    mxFree(dims_mw_copy);
    mxFree(minSize_mw);

    mxFree(dims_int);
    mxFree(minSize_int);
}
