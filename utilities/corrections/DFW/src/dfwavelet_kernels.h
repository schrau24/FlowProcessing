
#include "dfwavelet.h"

#ifdef __cplusplus
extern "C" {
#endif

	struct dfwavelet_plan_s;

	/* GPU Host Funcstion */
	extern void dffwt3_gpuHost(struct dfwavelet_plan_s* plan, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn, data_t* in_vx,data_t* in_vy,data_t* in_vz);
	extern void dfiwt3_gpuHost(struct dfwavelet_plan_s* plan, data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_wcdf1,data_t* in_wcdf2,data_t* in_wcn);
	extern void dfsoftthresh_gpuHost(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn);

	extern void dfwavthresh3_gpuHost(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
	extern void dfwavthresh3_spin_gpuHost(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);

	extern void dfwavthresh3_SURE_gpuHost(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
	extern void dfwavthresh3_SURE_spin_gpuHost(struct dfwavelet_plan_s* plan,scalar_t sigma,int spins,int isRand, data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);


	extern void dfwavthresh3_SURE_MAD_gpuHost(struct dfwavelet_plan_s* plan,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
	extern void dfwavthresh3_SURE_MAD_spin_gpuHost(struct dfwavelet_plan_s* plan,int spins,int isRand, data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);


	/* GPU Function */
	extern void dffwt3_gpu(struct dfwavelet_plan_s* plan, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn, data_t* in_vx,data_t* in_vy,data_t* in_vz);
	extern void dfiwt3_gpu(struct dfwavelet_plan_s* plan, data_t* out_vx,data_t* out_vy,data_t* out_vz, data_t* in_wcdf1,data_t* in_wcdf2,data_t* in_wcn);
	extern void dfsoftthresh_gpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh, data_t* out_wcdf1,data_t* out_wcdf2,data_t* out_wcn);

	extern void dfwavthresh3_gpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
	extern void dfwavthresh3_spin_gpu(struct dfwavelet_plan_s* plan,scalar_t dfthresh, scalar_t nthresh,int spins,int isRand,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);

	extern void dfwavthresh3_SURE_gpu(struct dfwavelet_plan_s* plan,scalar_t sigma,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
	extern void dfwavthresh3_SURE_spin_gpu(struct dfwavelet_plan_s* plan,scalar_t sigma,int spins,int isRand, data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);

	extern void dfwavthresh3_SURE_MAD_gpu(struct dfwavelet_plan_s* plan,data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);
	extern void dfwavthresh3_SURE_MAD_spin_gpu(struct dfwavelet_plan_s* plan,int spins,int isRand, data_t* out_vx,data_t* out_vy,data_t* out_vz,data_t* in_vx,data_t* in_vy,data_t* in_vz);

	extern void softthresh_gpu(struct dfwavelet_plan_s* plan, int length, scalar_t thresh, data_t* in);
	extern void circshift_gpu(struct dfwavelet_plan_s* plan, data_t* data);
	extern void circunshift_gpu(struct dfwavelet_plan_s* plan, data_t* data);

#ifdef __cplusplus
}
#endif
