CC = g++
LD = g++

# Compilation flags
CFLAGS = -I/usr/local/include -I. -I./blake3/ -w -O3 -std=c++17 -msse2 -msse -mssse3 -mavx2 -msse4.1 -ffast-math -maes -fpermissive -fopenmp -DBLAKE3_NO_AVX512

# Linker flags
LDFLAGS = -lcryptopp -lpthread -lgmpxx -lssl -lhiredis_ssl -lhiredis -lcrypto -lntl -lgmp -lm -lrt

BLAKE3_SRCS = ./blake3/blake_hash.cpp ./blake3/blake3.c ./blake3/blake3_dispatch.c ./blake3/blake3_portable.c ./blake3/blake3_avx2.c ./blake3/blake3_sse2.c ./blake3/blake3_sse41.c

# Targets
ntru-oqxt-setup: rawdatautil.cpp bloom_filter.cpp AES_256GCM.c \
  ./falcon-round3/Extra/c/shake.c ./falcon-round3/Extra/c/common.c \
  ./falcon-round3/Extra/c/keygen.c ./falcon-round3/Extra/c/fft.c \
  ./falcon-round3/Extra/c/fpr.c ./falcon-round3/Extra/c/vrfy.c \
  ./falcon-round3/Extra/c/codec.c ./falcon-round3/Extra/c/sign.c \
  ./falcon-round3/Extra/c/rng.c $(BLAKE3_SRCS) ntru-oqxt-setup.cpp
	$(CC) $(CFLAGS) -o ntru-oqxt-setup $^ $(LDFLAGS)

ntru-oqxt-search: rawdatautil.cpp bloom_filter.cpp AES_256GCM.c \
  ./falcon-round3/Extra/c/shake.c ./falcon-round3/Extra/c/common.c \
  ./falcon-round3/Extra/c/keygen.c ./falcon-round3/Extra/c/fft.c \
  ./falcon-round3/Extra/c/fpr.c ./falcon-round3/Extra/c/vrfy.c \
  ./falcon-round3/Extra/c/codec.c ./falcon-round3/Extra/c/sign.c \
  ./falcon-round3/Extra/c/rng.c $(BLAKE3_SRCS) ntru-oqxt-search.cpp
	$(CC) $(CFLAGS) -o ntru-oqxt-search $^ $(LDFLAGS)

clean_all:
	rm -rf *.o setup *.gch oqxt_falcon_setup oqxt_falcon_search EDB_test.csv bloom_filter.dat ntru-oqxt-setup ntru-oqxt-search
	@redis-cli flushall
	@redis-cli save
