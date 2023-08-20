# [ecom_app](https://github.com/rddewan/flutter-project-setup)

## 1. Github Workflow Srategy
```
git checkout -b qa 
git checkout -b uat 
git checkout -b dev 
git checkout -b main //prod
```
![image](https://github.com/YamamotoDesu/ecom_app/assets/47273077/71318fa2-d889-4baf-99fd-a46d2609d13e)

## 2. Flutter version management
https://fvm.app/
```
brew tap leoafarias/fvm
brew install fvm
fvm install {{version}}
fvm global {{version}}
fvm use {{version}}
```

.vscode/settings.json
```json
{
    "dart.flutterSdkPath": ".fvm/flutter_sdk",
    // Remove .fvm files from search
    "search.exclude": {
        "**/.fvm": true
    },
    // Remove from file watching
    "files.watcherExclude": {
        "**/.fvm": true
    }
}
```

.gitignore
```
.fvm/flutter_sdk
```

pubspec.yaml
```yaml
flavorizr:
  ide: "vscode"
  app:
    android:
      flavorDimensions: "flavor"

  flavors:
    dev:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".development\""
          versionNameSuffix: "\"Dev\""
          signingConfig: signingConfigs.dev
      ios:
        bundleId: "kyo.desu.ecom_app.dev"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    qa:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".qa\""
          versionNameSuffix: "\"QA\""
          signingConfig: signingConfigs.qa
      ios:
        bundleId: "kyo.desu.ecom_app.qa"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    uat:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".uat\""
          versionNameSuffix: "\"UAT\""
          signingConfig: signingConfigs.uat
      ios:
        bundleId: "kyo.desu.ecom_app.uat"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    prod:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          signingConfig: signingConfigs.prod
      ios:
        bundleId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        buildSettings:
```

## 3. Flutter Flavor Setup

pubspec.yaml
```yaml

dev_dependencies:
  flutter_test:
    sdk: flutter
  # https://pub.dev/packages/flutter_flavorizr
  flutter_flavorizr: ^2.2.1


flavorizr:
  ide: "vscode"
  app:
    android:
      flavorDimensions: "flavor"

  flavors:
    dev:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".development\""
          versionNameSuffix: "\"Dev\""
          signingConfig: signingConfigs.dev
      ios:
        bundleId: "kyo.desu.ecom_app.dev"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    qa:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".qa\""
          versionNameSuffix: "\"QA\""
          signingConfig: signingConfigs.qa
      ios:
        bundleId: "kyo.desu.ecom_app.qa"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    uat:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".uat\""
          versionNameSuffix: "\"UAT\""
          signingConfig: signingConfigs.uat
      ios:
        bundleId: "kyo.desu.ecom_app.uat"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    prod:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          signingConfig: signingConfigs.prod
      ios:
        bundleId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        buildSettings:
```

Command
```
flutter pub run flutter_flavorizr
```

## 4. Code Signing
Android Flavor and Code Signing
```
keytool -genkeypair -alias <エイリアス名> -keyalg <鍵ペアのアルゴリズム> -keysize <鍵のサイズ> -sigalg <署名アルゴリズム> -dname <識別名> -validity <有効日数> -storetype <キーストアのタイプ> -keystore <キーストアのファイル名> -storepass <キーストアのパスワード>
```

android/keystore/key.properties
```properties
dev.keyAlias=dev
dev.keyPassword=1234
dev.storeFile=../keytore/test.jks
dev.storePassword=1234

qa.keyAlias=dev
qa.keyPassword=1234
qa.storeFile=../keytore/test.jks
qa.storePassword=1234

uat.keyAlias=dev
uat.keyPassword=1234
uat.storeFile=../keytore/test.jks
uat.storePassword=1234

prod.keyAlias=dev
prod.keyPassword=1234
prod.storeFile=../keytore/test.jks
prod.storePassword=1234
```

android/app/build.gradle
```gradle
def keyProperties = new Properties()
def keyPropertiesFile = rootProject.file('key.properties')
if (keyPropertiesFile.exists()) {
    keyPropertiesFile.withReader('UTF-8') { reader ->
        keyProperties.load(reader)
    }
}


android {
        signingConfigs {
        debug {
            keyAlias keyProperties['dev.keyAlias']
            keyPassword keyProperties['dev.keyPassword']
            storeFile keyProperties['dev.storeFile'] ? file(keyProperties['dev.storeFile']) : null
            storePassword keyProperties['dev.storePassword']   
        }
        qa {
            keyAlias keyProperties['qa.keyAlias']
            keyPassword keyProperties['qa.keyPassword']
            storeFile keyProperties['qa.storeFile'] ? file(keyProperties['qa.storeFile']) : null
            storePassword keyProperties['qa.storePassword']   
        }
        uat {
            keyAlias keyProperties['uat.keyAlias']
            keyPassword keyProperties['uat.keyPassword']
            storeFile keyProperties['uat.storeFile'] ? file(keyProperties['uat.storeFile']) : null
            storePassword keyProperties['uat.storePassword']   
        }
        release {
            keyAlias keyProperties['prod.keyAlias']
            keyPassword keyProperties['prod.keyPassword']
            storeFile keyProperties['prod.storeFile'] ? file(keyProperties['prod.storeFile']) : null
            storePassword keyProperties['prod.storePassword']   
        }
    }
```

<img width="285" alt="image" src="https://github.com/YamamotoDesu/flutter_project_setup/assets/47273077/027fda3d-fec1-4c83-b4eb-ebe719d773b4">

<img width="467" alt="image" src="https://github.com/YamamotoDesu/flutter_project_setup/assets/47273077/34e43261-b1b4-4464-9698-2fb5f58ca1e6">

## 5. Configure Environment
pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter

  # https://pub.dev/packages/flutter_dotenv
  flutter_dotenv: ^5.1.0

flutter:


  assets:
    - .dev.env
    - .qa.env
    - .uat.env
    - .prod.env
```

gitignore
```
*.env
```

.dev.env
```env
BASE_URL=api.dev.yamamoto.desu
API_KEY=1234567
```

lib/core/flavor/flavor.dart
```dart
enum Flavor {
  dev,
  qa,
  uat,
  prod,
}
```

lib/core/env/env_reader.dart
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ecom_app/core/flavor/flavor.dart';

class EnvReader {
  String getEnvFileName(Flavor flavor) {
    return ".${flavor.name}.env";
  }
}
```

lib/main_dev.dart
```dart

Future<void> main() async {
  mainApp(Flavor.dev);
}

```

## 6. Flutter Riverpod Configuration

lib/core/env/env_reader.dart
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../flavor/flavor.dart';

final envReaderProvider = Provider<EnvReader>((ref) {
  return EnvReader();
});
```

lib/main.dart
```dart
FutureOr<void> mainApp(Flavor flavor) async {
  // An object that stores the state of the providers and allows overriding the behavior of a specific provider.
  final container = ProviderContainer();

  final envReader = container.read(envReaderProvider);
  final envFile = envReader.getEnvFileName(flavor);
  await dotenv.load(fileName: envFile);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainWidget(),
    ),
  );
}
```

## 7. Flutter Lint

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  plugins:
    #- dart_code_metrics
  exclude:
    - "**/**.g.dart"
    - "lib/**.g.dart"
    - "**/**.freezed.dart"
    - "lib/**.freezed.dart"
    - "lib/i18n/*"
    - "build/**"
    - "lib/generated/**"

  language:
    #strict-casts: true
    #strict-inference: true
    #strict-raw-types: true

errors:
  todo: ignore
  always_use_package_imports: error
  avoid_print: warning
  annotate_overrides: warning
  avoid_renaming_method_parameters: warning
  avoid_return_types_on_setters: warning
  avoid_returning_null_for_void: error
  avoid_unnecessary_containers: warning
  camel_case_types: error
  flutter_style_todos: warning
  invalid_annotation_target: ignore
  always_declare_return_types: warning
  unused_import: error
  require_trailing_commas: info
  sort_child_properties_last: warning
  no_leading_underscores_for_local_identifiers: info

linter:
  rules:
    always_use_package_imports: true
    avoid_print: true
    annotate_overrides: true
    avoid_renaming_method_parameters: true
    avoid_return_types_on_setters: true
    avoid_returning_null_for_void: true
    avoid_unnecessary_containers: true
    camel_case_types: true
    flutter_style_todos: true
    always_declare_return_types: true
    require_trailing_commas: true
    sort_child_properties_last: true
    library_private_types_in_public_api: false
    no_leading_underscores_for_local_identifiers: false
```

##  8. Logger
pubspec.yaml
```yaml
  # https://pub.dev/packages/logging
  logging: ^1.2.0
```

lib/common/logger/logger_provider.dart
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final loggerProvider = Provider<SetupLogger>((ref) {
  return SetupLogger();
});

class SetupLogger {

  SetupLogger () {
    _init();
  }

  void _init() {
    if (kDebugMode) {

      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {

        if (record.level == Level.SEVERE) {
          debugPrint('${record.level.name}: ${record.time}: ${record.message}: ${record.error}: ${record.stackTrace}');
        } else if (record.level == Level.INFO) {
           debugPrint('${record.level.name}: ${record.message}');
        } else {
          debugPrint('${record.level.name}: ${record.time}: ${record.message}');
        }
      
      });

    } else {
      Logger.root.level = Level.OFF;
    }
  }
}
}
```

lib/base/base_state.dart
```dart
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
 
  Logger get log => Logger(T.toString());
 
  @override
  void initState() {
    log.info('$T initState');
    super.initState();
  }

  void init() {}

  @override
  void dispose() {
    log.info('$T dispose');
    super.dispose();
  }
}
```

lib/base/base_consumer_state.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

abstract class BaseConsumer<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
 
  Logger get log => Logger(T.toString());
 
  @override
  void initState() {
    log.info('$T initState');
    super.initState();
  }

  @override
  void dispose() {
    log.info('$T dispose');
    super.dispose();
  }
}
```

lib/main_widget.dart
```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
```
