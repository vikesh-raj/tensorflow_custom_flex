load("//tensorflow/lite:build_def.bzl", "tflite_cc_shared_object")
load(
    "//tensorflow:tensorflow.bzl",
    "clean_dep",
    "if_android",
    "if_ios",
    "if_mobile",
    "tf_copts",
    "tf_defines_nortti_if_lite_protos",
    "tf_features_nomodules_if_mobile",
    "tf_opts_nortti_if_lite_protos",
    "tf_portable_full_lite_protos",
)
load("//tensorflow/lite:special_rules.bzl", "flex_portable_tensorflow_deps")

cc_library(
    name = "flex_ops",
    srcs = if_mobile([
        clean_dep("//tensorflow/core:portable_op_registrations_and_gradients"),
        clean_dep("//tensorflow/core/kernels:android_core_ops"),
        clean_dep("//tensorflow/core/kernels:android_extended_ops"),
    ]) + [
        "ops_to_register.h"
    ],
    copts = tf_copts(android_optimization_level_override = None) + tf_opts_nortti_if_lite_protos() + if_ios(["-Os"]),
    defines = [
        "SELECTIVE_REGISTRATION",
        "SUPPORT_SELECTIVE_REGISTRATION",
    ] + tf_portable_full_lite_protos(
        full = [],
        lite = ["TENSORFLOW_LITE_PROTOS"],
    ) + tf_defines_nortti_if_lite_protos(),
    features = tf_features_nomodules_if_mobile(),
    linkopts = ["-lz"],
    includes = [
        ".",
    ],
    textual_hdrs = [
        clean_dep("//tensorflow/core/kernels:android_all_ops_textual_hdrs"),
    ],
    deps = flex_portable_tensorflow_deps() + [
        clean_dep("//tensorflow/core:protos_all_cc"),
        clean_dep("//tensorflow/core:portable_tensorflow_lib_lite"),
        clean_dep("//tensorflow/core/platform:strong_hash"),
        clean_dep("//tensorflow/lite/delegates/flex:portable_images_lib"),
    ],
    alwayslink = 1,
)

tflite_cc_shared_object(
    name = "flex_delegate",
    srcs = [
    	"delegate.cc",
    ],
    linkopts = select({
        "//tensorflow:ios": [
            "-Wl,-exported_symbols_list,$(location //tensorflow/lite/c:exported_symbols.lds)",
        ],
        "//tensorflow:macos": [
            "-Wl,-exported_symbols_list,$(location //tensorflow/lite/c:exported_symbols.lds)",
        ],
        "//tensorflow:windows": [],
        "//conditions:default": [
            "-z defs",
            "-Wl,--version-script,$(location //tensorflow/lite/c:version_script.lds)",
        ],
    }),
    includes = [
        ".",
    ],
    per_os_targets = True,
    deps = [
        "//tensorflow/lite/c:exported_symbols.lds",
        "//tensorflow/lite/c:version_script.lds",
    	clean_dep("//tensorflow/lite/delegates/flex:delegate_data"),
        clean_dep("//tensorflow/lite/delegates/flex:delegate_only_runtime"),
        clean_dep("//tensorflow/lite/delegates/utils:simple_delegate"),
    ] + select({
        clean_dep("//tensorflow:android"): [
            "flex_ops",
        ],
        clean_dep("//tensorflow:ios"): [
            "flex_ops",
        ],
        "//conditions:default": [
            # clean_dep("//tensorflow/core:portable_tensorflow_lib"),
            clean_dep("//tensorflow/core:tensorflow"),
            clean_dep("//tensorflow/lite/c:common"),
        ],
    })
)
