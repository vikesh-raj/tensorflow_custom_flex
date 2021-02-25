#!/bin/bash -xe

if [ $# -lt 1 ] ; then
    echo "Usage : $0 ACTION"
    exit 1
fi

action="$1"
shift

OUTPUT=$HOME/tfbuild
LINUX_DIR=$OUTPUT/linux_x86
ARM_DIR=$OUTPUT/android/armeabi-v7a
ARM64_DIR=$OUTPUT/android/arm64-v8a

FLEX_ARGS="-c opt --config=monolithic --config=noaws --config=nogcp --config=nohdfs --config=nonccl"
FLEX_SO=libflex_delegate.so
FLEX_TARGET=//custom_flex:flex_delegate
FLEX_OUTPUT=bazel-bin/custom_flex/$FLEX_SO

TFC_ARGS="-c opt"
TFC_TARGET=//tensorflow/lite/c:tensorflowlite_c
TFC_SO=libtensorflowlite_c.so
TFC_OUTPUT=bazel-bin/tensorflow/lite/c/$TFC_SO


case "$action" in
flex_delegate_linux) bazel build $FLEX_ARGS $FLEX_TARGET
	mkdir -p $LINUX_DIR
	cp $FLEX_OUTPUT $LINUX_DIR
	chmod +w $LINUX_DIR/*.so
    ;;
flex_delegate_android_arm) bazel build $FLEX_ARGS --config=android_arm $FLEX_TARGET --verbose_failures
	mkdir -p $ARM_DIR
	cp $FLEX_OUTPUT $ARM_DIR
	chmod +w $ARM_DIR/*.so
    ;;
flex_delegate_android_arm64) bazel build $FLEX_ARGS --config=android_arm64 $FLEX_TARGET
	mkdir -p $ARM64_DIR
	cp $FLEX_OUTPUT $ARM64_DIR
	chmod +w $ARM64_DIR/*.so
	;;
tensorflow_lite_c_linux) bazel build $TFC_ARGS $TFC_TARGET
	mkdir -p $LINUX_DIR
	cp $TFC_OUTPUT $LINUX_DIR
	chmod +w $LINUX_DIR/*.so
	;;
tensorflow_lite_c_android_arm) bazel build $TFC_ARGS --config=android_arm $TFC_TARGET
	mkdir -p $ARM_DIR
	cp $TFC_OUTPUT $ARM_DIR
	chmod +w $ARM_DIR/*.so
	;;
tensorflow_lite_c_android_arm64) bazel build $TFC_ARGS --config=android_arm64 $TFC_TARGET
	mkdir -p $ARM64_DIR
	cp $TFC_OUTPUT $ARM64_DIR
	chmod +w $ARM64_DIR/*.so
	;;
*) echo "Unknown command"
   exit 1
   ;;
esac
