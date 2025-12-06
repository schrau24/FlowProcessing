CUDA=0
OPENMP=1

cuda.top := /usr/local/cuda
NVCC = $(cuda.top)/bin/nvcc
CC = gcc -lm


ifeq ($(CUDA),1)
	CC += -DUSE_CUDA
	CUDA_H := -I$(cuda.top)/include
	CUDA_L := -L$(cuda.top)/lib64 -lcudart -lcuda
	NVCC_FLAGS = -Xcompiler -fPIC -fopenmp -O3 -arch=sm_20 -m64
else
	CUDA_H :=
	CUDA_L :=
	NVCC_FLAGS :=
endif

ifeq ($(OPENMP),1)
	CC += -DUSE_OPENMP -fopenmp
endif


OBJS = dfwavelet_main.o dfwavelet.o 

ifeq ($(CUDA),1)
	OBJS += dfwavelet_kernels.o
endif

TARGET = dfwavelet

all:	$(TARGET)

%.o: %.cu
	$(NVCC) $(NVCCFLAGS) -c $^ -o $@

$(TARGET):	$(OBJS)
	$(CC) -o $(TARGET) $(OBJS) $(CUDA_L) $(CUDA_H) 

clean:
	rm -f $(OBJS) $(TARGET)
