# fcar

- **F** Flutter
- **C** Clean
- **A** Architecture
- **R** Riverpod

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## App Name

By default, when a flutter app gets installed, the app name on the launcher is your Flutter project name.
To change that to your desired application name on Android need to change AndroidManifest.xml,
and for iOS needs to change Info.plist respectively.
We may want to update the app name for web & desktop as well.

Here is [rename_app package](https://pub.dev/packages/rename_app) that makes life easy. Instead of updating the app name in the respective files,
just run the command.

Here is the command to change the app name for the all platforms:
`flutter pub run rename_app:main all="App Name"`

## Target Platforms

- mobile:` Android` & `iOS`

## Target OS version

- Android: `24` - `33`
- iOS: `12.1`

## Enironment (env)

- **dev**: development (debug)
- **uat**: QA
- **prod**: production (Play Store)

## Riverpod

Learn the [Riverpod](https://riverpod.dev/).

## Generate Objectbox Database

Run the `build_runner` to generate `objectbox.g.dart`. You may need to do `flutter clean` & `flutter pub get` before run the `build_runner`. Do one of the following:

- `flutter pub run build_runner build --delete-conflicting-outputs`
- `flutter packages pub run build_runner build --delete-conflicting-outputs`

Generated databsae `objectbox.g.dart` might contains errors regardless of your **lints** in the `analysis_options.yaml`.

#### References
- [objectbox](https://docs.objectbox.io/)
- [sync objectbox](https://sync.objectbox.io/sync-client)

#### Update the existing database carefully
- [Resolving Meta Model Conflicts](https://docs.objectbox.io/advanced/meta-model-ids-and-uids#resolving-meta-model-conflicts)
- [DbSchemaException: incoming ID does not match existing UID](https://docs.objectbox.io/troubleshooting#dbschemaexception-incoming-id-does-not-match-existing-uid)


## Usefull Tools `vscode`

- Live Share
- GitLenze
- ESLint
- Dart Data Class Generator

## Usefull Links

- [Material Design](m3.material.io)
- [App Icon Generator](icon.kitchen)
- [Online Photoshop](https://www.photopea.com/)
- [File Convertor](freeconvert.com) You can convert Image and Doc.
- [Background Remover](https://www.photoroom.com/tools/background-remover) Remove background of a image very quick
- [Remove Background](remove.bg)
- [Implement iOS Splashscreen](https://medium.com/swlh/native-splash-screen-in-flutter-using-lottie-121ce2b9b0a4)
- [Badges package](https://pub.dev/packages/badges) Use the **badges.Badge** widget instead of the **Badge** widget. The same for all the classes from this package.
- [Compatibility Matrix `Java` `Gradle` `Kotlin`](https://docs.gradle.org/current/userguide/compatibility.html)

## Usefull CLI

- Take screenshot. It will take screenshot and save it in the root
  - flutter screenshot

- The size analysis tool is invoked by passing the --analyze-size flag when building. It will generate a *-code-size-analysis_*.json file for more detailed analysis in DevTools. You may need to set `--target-platform` for example `--target-platform=android-arm64`

  - flutter build apk -t lib/main_dev.dart --flavor=dev --analyze-size
  - flutter build appbundle lib/main_dev.dart --flavor=dev --analyze-size
  - flutter build ios lib/main_dev.dart --flavor=dev --analyze-size
  - flutter build linux lib/main_dev.dart --flavor=dev --analyze-size
  - flutter build macos lib/main_dev.dart --flavor=dev --analyze-size
  - flutter build windows lib/main_dev.dart --flavor=dev --analyze-size

- Deeper analysis in DevTools. Select Open app size tool and uploading the *-code-size-analysis_*.json file.
  - `flutter pub global run devtools`

- Activate a flutter package
  - `flutter pub global activate devtools`


## How to run
#### Run app [in `dev` environment]
- `flutter run -t lib/main_dev.dart --flavor=dev --dart-define=ENVDEFINE_API_KEY=theValue`
#### Run app in debug mode [in `dev` environment] (Picks up debug signing config)
- `flutter run -t lib/main_dev.dart --debug --flavor=dev --dart-define=ENVDEFINE_API_KEY=theValue`
#### Run app in release mode [in `dev` environment] (Picks up release signing config)
- `flutter run -t lib/main_dev.dart --release --flavor=dev --dart-define=ENVDEFINE_API_KEY=theValue`

## How to build
#### Create appBundle for Android platform. Runs in release mode by default. [in `dev` environment]
- `flutter build appbundle -t lib/main_dev.dart --flavor=dev --split-debug-info --dart-define=ENVDEFINE_API_KEY=theValue`
#### Create APK for dev flavor. Runs in release mode by default. [in `dev` environment]
- `flutter build apk -t lib/main_dev.dart --flavor=dev --split-debug-info --dart-define=ENVDEFINE_API_KEY=theValue`

## Coding

Future.microtask(() => HERE);
WidgetsBinding.instance.addPostFrameCallback((\_) => HERE);

use
final val = StateProvider<bool>((ref) => false);

## Socket.io

If the socket connection is failing, then you might have to add the following property to your `AndroidManifest.xml` file application tag:

```
<application
     .....
     android:usesCleartextTraffic="true">
```
