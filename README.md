Java to Dart JNIgen Translator
This Dart script automates the conversion of Java/Kotlin code (e.g., CameraX API usage) into equivalent Dart JNIgen-compatible code using Google's Gemini AI API.

Features<br>
✅ Fetches a Java snippet (e.g., CameraX take-photo example)<br>
✅ Sends it to the Gemini API for JNIgen-compatible Dart translation<br>
✅ Saves the generated Dart JNIgen code to a file<br>
✅ Runs dart analyze to check for correctness<br>

Installation
1. Clone the Repository
git clone https://github.com/iamharshitkr/Gsoc-Sample.git
cd Gsoc-Sample

2. Install Dependencies
Ensure you have Dart installed. If not, download it from dart.dev.
Install the necessary packages:
dart pub get

3. Set Up Gemini API Key
Replace GEMINI_API in main.dart with your actual Gemini API key. If you don’t have one, get it from Google AI.

Usage
Run the script:
dart generate_dart_camera.dart

This will:<br>
✅ Send a Java snippet to Gemini<br>
✅ Generate JNIgen-compatible Dart code<br>
✅ Save it to generated_dart_code.dart<br>
✅ Analyze the Dart code for errors<br>

Example Output
dart
// Generated Dart JNIgen Code
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:jni/jni.dart';

void main() {
  print("JNIgen Converted Code Executing...");
}

License
This project is open-source under the MIT License.
