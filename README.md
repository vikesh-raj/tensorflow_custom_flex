# tensorflow_custom_flex

Build tensorflow with custom flex delegate suitable for albert model using docker

Assuming tensorflow code is present in `tensorflow-docker` folder.

Start a docker shell :

```bash
mkdir docker-home
docker build . -t tflite-builder -f tensorflow-docker/tensorflow/tools/dockerfiles/tflite-android.Dockerfile
docker run -it -u $(id -u):$(id -g) -w /tensorflow \
	-v $PWD/tensorflow-docker:/tensorflow \
	-v $PWD/docker-home:/home \
	-v $PWD/tensorflow_custom_flex:/tensorflow/custom_flex \
	-v $HOME/Android/Sdk:/android/sdk \
	-e HOME=/home \
	-e USER=tfbuilder \
	-e HOST_PERMS="$(id -u):$(id -g)" \
	tflite-builder bash
```

android setup :

```
build --action_env ANDROID_NDK_API_LEVEL="21"
build --action_env ANDROID_BUILD_TOOLS_VERSION="28.0.3"
build --action_env ANDROID_SDK_API_LEVEL="23"
```

