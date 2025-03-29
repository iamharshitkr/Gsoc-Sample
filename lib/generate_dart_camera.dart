import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  const apiKey = "GEMINI_API_KEY"; // Replace with your actual API key
  if (apiKey.isEmpty) {
    print("Error: API key is missing.");
    return;
  }

  const endpoint =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  final javaSnippet = """
  private void takePhoto() {
      ImageCapture.OutputFileOptions outputOptions =
          new ImageCapture.OutputFileOptions.Builder(new File(getOutputDirectory(), "photo.jpg")).build();

      imageCapture.takePicture(outputOptions, ContextCompat.getMainExecutor(this), new ImageCapture.OnImageSavedCallback() {
          @Override
          public void onImageSaved(@NonNull ImageCapture.OutputFileResults output) {
              Log.d(TAG, "Photo saved: " + output.getSavedUri());
          }

          @Override
          public void onError(@NonNull ImageCaptureException exception) {
              Log.e(TAG, "Photo capture failed: " + exception.getMessage());
          }
      });
  }
  """;

  final prompt = """
  Convert the following Java CameraX API code into Dart, using JNIgen for interoperability.
  Ensure the translated Dart code works seamlessly with JNIgen to interact with Android's native CameraX API.
  The output Dart code should:
  - Use JNI bindings for ImageCapture and OutputFileOptions.
  - Implement error handling.
  - Follow Dart FFI best practices.

  Java Code:
  $javaSnippet
  """;

  try {
    final response = await http.post(
      Uri.parse('$endpoint?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final generatedCode =
          jsonResponse['candidates']?[0]?['content']?['parts']?[0]?['text'];

      if (generatedCode == null) {
        print("Error: Unexpected response format.");
        return;
      }

      print("Generated Dart JNIgen Code:\n$generatedCode");

      final file = File("generated_dart_camera.dart");
      await file.writeAsString(generatedCode);
      print("Saved to generated_dart_camera.dart");

      final analyzeResult =
          await Process.run('dart', ['analyze', 'generated_dart_camera.dart']);
      print(
          "Dart Analyzer Output:\n${analyzeResult.stdout}${analyzeResult.stderr}");
    } else {
      print("Failed to generate code. Status: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
