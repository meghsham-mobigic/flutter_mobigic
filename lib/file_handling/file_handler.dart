import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_app_file/open_app_file.dart';

class FilePickerAppRoot extends StatefulWidget {
  const FilePickerAppRoot({super.key});

  @override
  State<StatefulWidget> createState() => _FilePickerAppRoot();
}

class _FilePickerAppRoot extends State<FilePickerAppRoot> {
  List<PlatformFile> filesList = [];
  bool hideFilesList = true;
  bool filePicked = false;

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        filesList = result.files;
      });
      showFilesList(filesList);
    }
  }

  void showFilesList(List<PlatformFile> fileList) {
    setState(() {
      hideFilesList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload in Flutter'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Choose a file',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: pickFiles,
                      icon: const Icon(Icons.file_upload),
                      label: const Text('Upload Files'),
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
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, file) {
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
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
                                const SizedBox(height: 5),
                                Text(
                                  'Path: ${filesList[file].path}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Size: ${(filesList[file].size / 1024).toStringAsFixed(2)} KB',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        final String? filePath =
                                            filesList[file].path;
                                        if (filePath != null) {
                                          await OpenAppFile.open(filePath);
                                        }
                                      },
                                      icon: const Icon(Icons.open_in_new),
                                      label: const Text('Open File'),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () async {},
                                      icon: const Icon(Icons.open_in_new),
                                      label: const Text('Upload File'),
                                    ),
                                  ],
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
      ),
    );
  }
}
