# fcar

A new Flutter project.

Clean Architecture with Riverpod

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

## How to run

- **Development**:

```plaintext
flutter run --flavor dev -t lib/main_dev.dart --dart-define=ENVDEFINE_AMPLITUDE_API_KEY=theValue
```

## Coding

use
final val = StateProvider<bool>((ref) => false);
