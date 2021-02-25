#!/bin/bash

tensorflow/lite/tools/build_aar.sh --input_models=custom_flex/model.tflite --target_archs=x86,x86_64,arm64-v8a,armeabi-v7a
