#ifndef WAV_IMPL
#include "dfwavelet_impl.h"
#define WAV_IMPL
#endif
    
struct dfwavelet_plan_s;

extern struct dfwavelet_plan_s* prepare_dfwavelet_plan(int numdims, int* imSize, int* minSize_tr,scalar_t* res,int use_gpu);

extern void dfwavelet_forward(struct dfwavelet_plan_s* plan, data_t* out_wcdf1, data_t* out_wcdf2, data_t* out_wcn, data_t* in_vx, data_t* in_vy, data_t* in_vz);

extern void dfwavelet_inverse(struct dfwavelet_plan_s* plan, data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_wcdf1,data_t* in_wcdf2,data_t* in_wcn);

extern void dfsoft_thresh(struct dfwavelet_plan_s* plan, scalar_t dfthresh, scalar_t nthresh,data_t* wcdf1,data_t* wcdf2, data_t* wcn);

extern void dfwavelet_thresh(struct dfwavelet_plan_s* plan, scalar_t dfthresh, scalar_t nthresh,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz);

extern void dfwavelet_thresh_spin(struct dfwavelet_plan_s* plan, scalar_t dfthresh, scalar_t nthresh,int spins,int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz);

extern void dfSUREshrink_cpu(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* wcdf1,data_t* wcdf2,data_t* wcn);

extern void dfwavelet_thresh_SURE(struct dfwavelet_plan_s* plan, scalar_t sigma,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz);

extern void dfwavelet_thresh_SURE_spin(struct dfwavelet_plan_s* plan, scalar_t sigma,int spins,int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz);

extern scalar_t getMADsigma_cpu(struct dfwavelet_plan_s* plan, data_t* wcn);


extern void dfwavelet_thresh_SURE_MAD(struct dfwavelet_plan_s* plan,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz);

extern void dfwavelet_thresh_SURE_MAD_spin(struct dfwavelet_plan_s* plan,int spins,int isRand,data_t* out_vx, data_t* out_vy, data_t* out_vz, data_t* in_vx,data_t* in_vy, data_t* in_vz);

extern void dfwavelet_new_randshift(struct dfwavelet_plan_s* plan);
extern void dfwavelet_clear_randshift(struct dfwavelet_plan_s* plan);
extern void dfwavelet_free(struct dfwavelet_plan_s* plan);
