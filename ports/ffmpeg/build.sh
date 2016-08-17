# Copyright (c) 2012 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

if [ "${NACL_LIBC}" = "newlib" ]; then
  # needed for RLIMIT_CPU
  NACLPORTS_CPPFLAGS+=" -I${NACLPORTS_INCLUDE}/glibc-compat"
fi

ConfigureStep() {
  SetupCrossEnvironment

  local extra_args=""
  if [ "${TOOLCHAIN}" = "pnacl" ]; then
    extra_args="--cc=pnacl-clang"
  elif [ "${TOOLCHAIN}" = "clang-newlib" ]; then
    extra_args="--cc=${CC}"
  fi

  if [ "${NACL_ARCH}" = "pnacl" ]; then
    extra_args+=" --arch=pnacl"
  elif [ "${NACL_ARCH}" = "arm" ]; then
    extra_args+=" --arch=arm"
  else
    extra_args+=" --arch=x86"
  fi

  LogExecute ${SRC_DIR}/configure \
    --cross-prefix=${NACL_CROSS_PREFIX}- \
    --target-os=linux \
    --enable-cross-compile \
    --disable-programs \
    --disable-doc \
    --disable-everything \
    --enable-decoder=aac,h264,mjpeg,mpeg2video,mpeg4,pcm_mulaw \
    --enable-encoder=aac,mpeg4,mjpeg \
    --enable-protocol=concat,file,rtp,tls_openssl \
    --enable-demuxer=aac,avi,h264,image2,matroska,pcm_s16le,pcm_mulaw,mov,m4v,rawvideo,wav,rtsp,mjpeg \
    --enable-muxer=h264,ipod,mov,mp4 \
    --enable-parser=aac,h264,mjpeg,mpeg4video,mpegaudio,mpegvideo,png \
    --enable-bsf=aac_adtstoasc \
    --enable-filter=transpose \
    --enable-avresample \
    --enable-openssl \
    --prefix=${PREFIX} \
    ${extra_args}
}
