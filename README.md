## My Digital Wallet

### Required dependency
    
    1. Android Studio 
        (https://developer.android.com/studio)
    2. Xcode (latest version) 
    3. CocoaPods 
        (https://guides.cocoapods.org/using/getting-started.html)
    4. Flutter SDK (latest version) 
        (https://flutter-ko.dev/development/tools/sdk/releases)
    

### Validate flutter SDK

`flutter doctor` is a helpful tool for ensuring that your Flutter development environment is set up correctly and that you can start building apps without any issues. It performs diagnostic checks on your Flutter installation and environment to ensure everything is set up correctly for development.

Run `flutter doctor` command in your main terminal.

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.22.2, on macOS 14.5 23F79 darwin-arm64 (Rosetta),
    locale en-IN)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 15.4)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2023.3)
[✓] VS Code (version 1.91.1)
[✓] Connected device (3 available)
[✓] Network resources

• No issues found!
```

### Ready to get started

Once all the required dependencies has been installed, then it will be ready to setup the project.

For the setup, 1st step would be clean the junk data from the project directory.
In this project, already have a shell script file (`clean_all.sh`) to clean the junk data.

open your main terminal and move to project directory using `cd` command.

Example:
```
cd /Users/XYZ/Documents/Projects/
```

Now, have to run `clean_all.sh`
Example:
```
sh clean_all.sh:
```

2nd step would be to get internal dependencies which are used in this project (`pubspec.yaml`).

As there are multiple of module created to divide the functionality and earch model has `pubspec.yaml`. To don't have to run each `pubspec.yaml` for multiple module, this project already have a shell script `pub_get_all.sh`.

Now, have to run `pub_get_all.sh`
Example: (Assuming you are already in the root directory of the project in the terminal)
```
sh pub_get_all.sh:
```

Now ready to run app on simulator or real device.

### Run app on simulator/device

There are two type of flavour used for the developmenmt and production.

```
    1. dev
    2. prod
```

by using that flavour can be able to run the app

Example: (Assuming you are already in the root directory of the project in the terminal)
```
flutter run --flavor dev
```

### Important

For the content, in this project used the CMS to store all data.
CMS can be operated usign base url

Here is setps to update `Base URL` of CMS

To update base URL, got to `main/assets/configuration/network_configuration_dev.json` or `network_configuration_prod.json`
and update the value of `defaultBaseURL` 
```
{
  "baseUrlMap": {
    "defaultBaseURL": "........."
  }
}
```


# dif-hackathon-24-wallet
# dif-hackathon-24-wallet
