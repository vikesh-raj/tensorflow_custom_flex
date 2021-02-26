load("//tensorflow/lite:build_def.bzl", "tflite_cc_shared_object")
load(
    "//tensorflow:tensorflow.bzl",
    "clean_dep",
)


tflite_cc_shared_object(
    name = "flex_delegate",
    srcs = [
        "dummy_delegate.cc",
    ],
    per_os_targets = True,
    includes = [
        ".",
    ],
    deps = [
        clean_dep("//tensorflow/lite/c:common"),
    ]
)
