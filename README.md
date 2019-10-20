# flutter_study
本项目用于调研最新的flutter技术和最优的实践方式。

## 项目启动
### 启动IOS 模拟器
flutter emulators --launch apple_ios_simulator

### 启动项目
flutter run

#### 生成model
  执行脚本: flutter packages pub run build_runner build --delete-conflicting-outputs

## 打android包
### 1.配置app名称和图标
在.android/app/src/main/res下添加图标，在.android/app/src/main/AndroidManifest.xml下配置名称和图标路径

### 2.生成keystore,配置jks文件
执行脚本：keytool -genkey -v -keystore {生成的文件，例如：~/key.jks} -keyalg RSA -keysize 2048 -validity 10000 -alias {别名,例如:kpl-key}
### 3.开启混淆
app下新建proguard-rules.pro文件，官网写法会造成打包中断，
```
-ignorewarnings


-keep class * {


    public private *;


}
```
.android下新建key.properties配置文件
```
storePassword=123456
keyPassword=123456
keyAlias=vipkey
storeFile=vip-key.jks
```
build.gradle文件配置
```
release {
            signingConfig signingConfigs.release
            minifyEnabled true
            useProguard true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
```
配置后build.gradle，
```
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

android {
    compileSdkVersion 28

    lintOptions {
        disable 'InvalidPackage'
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.flutter_kpl_vip"
        minSdkVersion 16
        targetSdkVersion 28
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        } }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            useProguard true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.2'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'
}

```
### 4. 配置

配webview && net
```
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```
android 9以上版本h5打不开兼容
```
在res下新建xml/network_security_config.xml：

<?xml version="1.0" encoding="utf-8"?>

<network-security-config>
        <base-config cleartextTrafficPermitted="true" />
</network-security-config>

然后在manifest里面引入:
android:networkSecurityConfig='@xml/network_security_config'
```
### 5.打包
执行代码 ：flutter build apk
