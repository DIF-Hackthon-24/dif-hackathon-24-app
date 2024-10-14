fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
### analyze
```
fastlane analyze
```

### unit_tests
```
fastlane unit_tests
```

### unit_tests_coverage_report
```
fastlane unit_tests_coverage_report
```

### build_android
```
fastlane build_android
```

### build_android_and_upload
```
fastlane build_android_and_upload
```


----

## iOS
### ios custom_lane
```
fastlane ios custom_lane
```
Description of what the lane does
### ios build_iOS
```
fastlane ios build_iOS
```


----

## Android
### android test
```
fastlane android test
```
Runs all the tests
### android beta
```
fastlane android beta
```
Submit a new Beta Build to Crashlytics Beta
### android deploy
```
fastlane android deploy
```
Deploy a new version to the Google Play

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
