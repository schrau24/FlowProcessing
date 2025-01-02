
// data_t is the type for input/output data, can be float/double or _Complex float/double.
// scalar_t is the type for filter and scalers, can be float/double
typedef double data_t;
typedef double scalar_t;

struct dfwavelet_plan_s {
  int use_gpu;

  int numdims;
  int* imSize; // Input Image Size
  int numPixel; // Number of image pixels
  int numCoeff; // Number of wavelet coefficients
  scalar_t* res; // Resolution
  scalar_t* noiseAmp; // Noise amplification for each subband
  scalar_t percentZero;

  int* minSize; // Minimum size for the scaling subband
  int numCoarse;
  int* waveSizes; // Contains all wavelet subband sizes
  int numLevels;
  int* randShift;

  // Temp memory
  data_t* tmp_mem;

  // Filter parameters
  int filterLen;
  scalar_t* lod0;
  scalar_t* hid0;
  scalar_t* lor0;
  scalar_t* hir0;
  scalar_t* lod1;
  scalar_t* hid1;
  scalar_t* lor1;
  scalar_t* hir1;

};


