import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class ReadWriteAppRoot extends StatefulWidget {
  const ReadWriteAppRoot({super.key});

  @override
  State<ReadWriteAppRoot> createState() => _ReadWriteAppRootState();
}

class _ReadWriteAppRootState extends State<ReadWriteAppRoot> {
  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSavedNote();
  }

  //read
  Future<void> getSavedNote() async {
    Directory directory = await getApplicationDocumentsDirectory(); // folder
    File file = File('${directory.path}/aniket.txt'); // file

    if (!await file.exists()) {
      await file.writeAsString('');
    }

    _noteController.text = await file.readAsString();
  }

  //write
  Future<void> saveAndCommit() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/aniket.txt');
    await file.writeAsString(_noteController.text);

    await Fluttertoast.showToast(
      msg: 'note saved',
      backgroundColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read and Write App')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _noteController,
                maxLines: 30,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.notes_rounded,
                    weight: 20,
                  ),
                  labelText: 'Notes',
                  hintText: 'Edit and Commit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  // focusedBorder: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveAndCommit,

                //appply theme config colors
                //style: ButtonStyle(
                //   backgroundColor: ThemeConfig.darkTheme
                // ),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.green,
                  elevation: 5,
                ),
                child: const Text('Commit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Reduce repetative code