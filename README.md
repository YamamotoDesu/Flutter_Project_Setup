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
  String getBaseUrl(Flavor flavor) {
    return switch (flavor) {
      Flavor.dev => ".dev.env",
      Flavor.uat => ".uat.env",
      Flavor.qa => ".qa.env",
      Flavor.prod => ".prod.env",
    };
  }

  String? getApiKey() {
    return dotenv.env['API_KEY'];
  }
}
```
