import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_string_constants.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/services/http_calls.dart';

class ImageUploaderHome extends StatefulWidget {
  const ImageUploaderHome({super.key});

  @override
  State<ImageUploaderHome> createState() => _ImageUploaderHomeState();
}

class _ImageUploaderHomeState extends State<ImageUploaderHome> {
  bool isSelected = false;
  bool isLoading = false;
  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Uploader'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected && selectedFile != null)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        margin: const EdgeInsets.all(10),

                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              const Text('Click to re-upload file'),
                              const SizedBox(height: 10),
                              Image.memory(
                                selectedFile!.bytes!,
                                height: 700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isLoading ? null : uploadFile,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Upload to Server'),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text('No image selected'),
                    ),
                    ElevatedButton(
                      onPressed: pickFiles,
                      child: const Text('Pick Image'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        debugPrint('no files picked');
        return;
      }

      setState(() {
        selectedFile = result.files.first;
        isSelected = true;
      });
    } catch (e) {
      debugPrint('File picker error: $e');
      await Helper.toast('Error selecting file: $e');
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile == null || selectedFile!.bytes == null) {
      await Helper.toast('No file selected');
      return;
    }

    setState(() => isLoading = true);

    final response = await HttpCalls.postForImage(
      ApiConstants.fakeImageUploadPath,
      fileBytes: selectedFile!.bytes,
      fileName: selectedFile!.name,
    );

    setState(() => isLoading = false);

    if (response.responseData != null) {
      await Helper.snackBar(context, 'Upload successful');
    } else {
      await Helper.toast('Upload failed: ${response.statusData}');
    }
  }
}
