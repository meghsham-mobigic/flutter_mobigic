import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_string_constants.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/http_methods/services/http_calls.dart';
import 'package:flutter_mobigic/locator.dart';

class FileUploaderHome extends StatefulWidget {
  const FileUploaderHome({super.key});

  @override
  State<FileUploaderHome> createState() => _FileUploaderHomeState();
}

class _FileUploaderHomeState extends State<FileUploaderHome> {
  bool isSelected = false;
  bool isLoading = false;
  PlatformFile? selectedFile;
  final DataService service = locator.get<DataService>();

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
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        await Helper.snackBar(context, 'No Files picked');
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

    ResponseDTO response = await HttpCalls.multipartFileUploader(
      ApiConstants.fakeImageUploadPath,
      fileBytes: selectedFile!.bytes,
      fileName: selectedFile!.name,
    );

    setState(() => isLoading = false);

    if (response.responseData != null) {
      await Helper.snackBar(context, 'Upload successful');
      if (response.responseData.toString().isNotEmpty) {
        backToUpload();
      }
    } else {
      await Helper.snackBar(context, 'Upload failed: ${response.error}');
      backToUpload();
    }
  }

  void backToUpload() {
    setState(() {
      isSelected = false;
    });
  }
}
