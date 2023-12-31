# fcar

- **F** Flutter
- **C** Clean
- **A** Architecture
- **R** Riverpod

## App Name

By default, when a flutter app gets installed, the app name on the launcher is your Flutter project name.
To change that to your desired application name on Android need to change AndroidManifest.xml,
and for iOS needs to change Info.plist respectively.
We may want to update the app name for web & desktop as well.

Here is [rename_app package](https://pub.dev/packages/rename_app) that makes life easy. Instead of updating the app name in the respective files,
just run the command.

Here is the command to change the app name for the all platforms:
`flutter pub run rename_app:main all="App Name"`

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Target Platforms

- mobile: Android & iOS

## Target OS version

- Android: 21 - 30
- iOS: 12.1

## Riverpod

service & repository -> controller -> view & widget

https://docs-v2.riverpod.dev/docs/getting_started

## Generate Objectbox Database

### A

1. flutter clean
2. flutter pub get

### B

1. flutter pub run build_runner build --delete-conflicting-outputs
2. flutter packages pub run build_runner build --delete-conflicting-outputs

To generate Objectbox database do:
**A** then **B1** or **B2**

- It will generate `objectbox.g.dart` that `objectbox.g.dart` has some errors in the file.
- To resolve the issue, add `// ignore_for_file: camel_case_types, depend_on_referenced_packages, avoid_classes_with_only_static_members` to top of the file.

https://docs.objectbox.io/

https://sync.objectbox.io/sync-client

[Resolving Meta Model Conflicts](https://docs.objectbox.io/advanced/meta-model-ids-and-uids#resolving-meta-model-conflicts)

[DbSchemaException: incoming ID does not match existing UID](https://docs.objectbox.io/troubleshooting#dbschemaexception-incoming-id-does-not-match-existing-uid)

## Usefull Tools `vscode`

- Live Share
- GitLenze
- ESLint
- Dart Data Class Generator

## Usefull CLI

- flutter screenshot: It will take screenshot and save it in the root

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

## How to run

- **Development**:

```plaintext
flutter run --flavor dev -t lib/main_dev.dart --dart-define=ENVDEFINE_AMPLITUDE_API_KEY=theValue
```

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
