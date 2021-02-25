/* Copyright 2019 The TensorFlow Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

#ifndef TENSORFLOW_LITE_DELEGATES_FLEX_C_DELEGATE_H_
#define TENSORFLOW_LITE_DELEGATES_FLEX_C_DELEGATE_H_

#include <stdint.h>

#include "tensorflow/lite/c/common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// Creates a new flex delegate instance that need to be destroyed with
// TfLiteFlexDelegateDelete when delegate is no longer used by TFLite.
//
TFL_CAPI_EXPORT TfLiteDelegate* TfLiteFlexDelegateCreate();

// Destroys a delegate created with `TfLiteFlexDelegateCreate` call.
TFL_CAPI_EXPORT void TfLiteFlexDelegateDelete(TfLiteDelegate* delegate);

#ifdef __cplusplus
}
#endif  // __cplusplus

#endif  // TENSORFLOW_LITE_DELEGATES_FLEX_C_DELEGATE_H_
