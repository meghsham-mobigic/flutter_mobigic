import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class ReadWriteAppRoot extends StatefulWidget {
  const ReadWriteAppRoot({super.key});

  @override
  State<ReadWriteAppRoot> createState() => _ReadWriteAppRootState();
}

class _ReadWriteAppRootState extends State<ReadWriteAppRoot> {
  final TextEditingController _noteController = TextEditingController();
  late final Directory directory;
  late final File file;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  Future<void> _loadNote() async {
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/notes.txt');
    if (await file.exists() == false) {
      await file.writeAsString('');
    }

    String content = await file.readAsString();
    setState(() {
      _noteController.text = content;
    });
  }

  Future<void> saveAndCommit() async {
    await file.writeAsString(_noteController.text);
    await Helper.toast('note saved');
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
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveAndCommit,
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
