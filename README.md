# fl_pin_code

[![pub package](https://img.shields.io/badge/build-success-green)](https://pub.dev/packages/fl_pin_code)
[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD--3--Clause-orange)](https://opensource.org/licenses/BSD-3-Clause)
![Dart language](https://img.shields.io/badge/Dart-100%25-blue)

# fl_pin_code

fl_pin_code helps to display Pin codes for Flutter applications.

## Feature 👇👇
* obscure support
* ...

## Installing 🔧
Install the latest version from [pub](https://pub.dartlang.org/packages/fl_pin_code).

# Installing
## Use this package as a library
### 1. Depend on it
Add this to your package's pubspec.yaml file:
```
dependencies:
  fl_pin_code: ^0.0.8
```
### 2. Install it
You can install packages from the command line:
with Flutter:
```
$ flutter packages get
```
Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.

### 3. Import it
Now in your Dart code, you can use:
```
import 'package:fl_pin_code/fl_pin_code.dart';
```

### Usage
```
            PinCode(
                    numberOfFields: 5,
                    fieldWidth: 40.0,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    fieldStyle: PinCodeStyle.box),

            PinCode(
                  keyboardType: TextInputType.number,
                  isObscure: true,
                  numberOfFields: 5,
                  fieldWidth: 40.0,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  fieldStyle: PinCodeStyle.box,
                  onCompleted: (text) {
                    setState(() {
                      hash.pinHash = text;
                    });
                  },
            ),
```
