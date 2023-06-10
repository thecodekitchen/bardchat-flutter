# bardchat

A cross-platform front end for using the currently unofficial Bard API locally on your devices.
This app is currently built to be run on the same local device which runs the [bardchat-python](https://github.com/thecodekitchen/bardchat-python) backend.
Soon, I will be providing Terraform scripts for various cloud deployment strategies which would theoretically enable a working mobile build by targeting the endpoint for your cloud deployment in 
main.dart and running
```
flutter build android
```
or
```
flutter build ios
```
