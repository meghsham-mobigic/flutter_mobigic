import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path/path.dart' as path;

class FilePickerAppRoot extends StatefulWidget {
  const FilePickerAppRoot({super.key});

  @override
  State<StatefulWidget> createState() => _FilePickerAppRoot();
}

class _FilePickerAppRoot extends State<FilePickerAppRoot> {
  List<PlatformFile> filesList = [];
  bool hideFilesList = true;

  Future<void> pickFiles() async {
    var result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        filesList = result.files;
      });
      printDetails(filesList);
    } else {
      print("no files picked");
    }
  }

  void printDetails(List<PlatformFile> fileList) {
    setState(() {
      hideFilesList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Handline in Flutter'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Choose a file',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.purple,
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: pickFiles,
                    icon: const Icon(Icons.file_upload),
                    label: const Text('Upload File'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: hideFilesList
                ? const Text('Select files to show')
                : ListView.builder(
                    itemCount: filesList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, file) {
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'File Name: ${filesList[file].name}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Path: ${filesList[file].path ?? "N/A"}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Size: ${(filesList[file].size / 1024).toStringAsFixed(2)} KB',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final filePath = filesList[file].path;
                                    if (filePath != null) {
                                      print(
                                        'Opening ${filesList[file].name} at $filePath',
                                      );
                                      await OpenAppFile.open(filePath);
                                    }
                                  },
                                  icon: const Icon(Icons.open_in_new),
                                  label: const Text('Open File'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    textStyle: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// class FileDetails extends StatelessWidget {
//   const FileDetails({
//     required this.fileName,
//     required this.fileLocation,
//     required this.fileSize,
//     super.key,
//   });

//   final String fileName;
//   final String fileLocation;
//   final String fileSize;

//   @override
//   Widget build(BuildContext context) {

//   }
// }
