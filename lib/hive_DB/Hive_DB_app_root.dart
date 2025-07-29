import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class HiveDBAppRoot extends StatefulWidget {
  const HiveDBAppRoot({super.key});

  @override
  State<HiveDBAppRoot> createState() => _HiveDBAppRootState();
}

class _HiveDBAppRootState extends State<HiveDBAppRoot> {
  late Box<String> _studentsData;
  String readAllStudent = '';

  String? selectedAction;

  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _studentsData = Hive.box<String>(
      'HiveBox',
    );
  }

  void clearData() {
    rollNoController.clear();
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive DB CRUD App')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                children: [
                  _operataionButton(
                    selectedLabel: 'Create',
                  ),

                  _operataionButton(
                    selectedLabel: 'Read',
                  ),

                  _operataionButton(
                    selectedLabel: 'Update',
                  ),

                  _operataionButton(
                    selectedLabel: 'Delete',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (selectedAction == 'Create') _buildCreateForm(),
              if (selectedAction == 'Read') _buildReadForm(),
              if (selectedAction == 'Update') _buildUpdateForm(),
              if (selectedAction == 'Delete') _buildDeleteForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateForm() {
    return _formContainer(
      children: [
        _rollNoField(),
        const SizedBox(height: 15),
        _nameField(),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            final roll = int.tryParse(rollNoController.text);
            final name = nameController.text.trim();
            if (roll != null && name.isNotEmpty) {
              createStudent(roll, name);
            }
          },
          child: const Text('Create Student'),
        ),
      ],
    );
  }

  void createStudent(int rollNo, String name) {
    _studentsData.put(rollNo, name);
    Fluttertoast.showToast(msg: 'Student Added Successfully');
  }

  Widget _buildReadForm() {
    return _formContainer(
      children: [
        _rollNoField(),
        const SizedBox(height: 15),
        TextField(
          controller: nameController,
          enabled: false,
          decoration: const InputDecoration(
            labelText: 'Student Name (read only)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            final roll = int.tryParse(rollNoController.text);
            if (roll != null) readStudent(roll);
            _displayAllStudentName();
          },
          child: const Text('Read Student'),
        ),
        const SizedBox(height: 15),
        // Text(readAllStudent),
        _displayAllStudentName(),
      ],
    );
  }

  Widget _displayAllStudentName() {
    return Card(
      child: Text(readAllStudent),
    );
  }

  void readStudent(int rollNo) {
    final result = _studentsData.get(rollNo);
    if (result != null) {
      nameController.text = result;
    } else {
      nameController.text = '';
      Fluttertoast.showToast(msg: 'Student not found');
    }
  }

  void readAllStudentStringGenerator() {
    readAllStudent = 'All students are ${_studentsData.values}';
  }

  Widget _buildUpdateForm() {
    return _formContainer(
      children: [
        _rollNoField(),
        const SizedBox(height: 15),
        _nameField(label: 'Updated Name'),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            final roll = int.tryParse(rollNoController.text);
            final name = nameController.text.trim();
            if (roll != null && name.isNotEmpty) {
              updateStudent(roll, name);
            }
          },
          child: const Text('Update Student'),
        ),
      ],
    );
  }

  void updateStudent(int rollNo, String name) {
    if (_studentsData.containsKey(rollNo)) {
      _studentsData.put(rollNo, name);
      Fluttertoast.showToast(msg: 'Student Updated Successfully');
    } else {
      Fluttertoast.showToast(msg: 'Student not found');
    }
  }

  Widget _buildDeleteForm() {
    return _formContainer(
      children: [
        _rollNoField(),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            final roll = int.tryParse(rollNoController.text);
            if (roll != null) {
              deleteStudent(roll);
            }
          },
          child: const Text('Delete Student'),
        ),
      ],
    );
  }

  void deleteStudent(int rollNo) {
    if (_studentsData.containsKey(rollNo)) {
      _studentsData.delete(rollNo);
      Fluttertoast.showToast(msg: 'Student Deleted Successfully');
    } else {
      Fluttertoast.showToast(msg: 'Student not found');
    }
  }

  Widget _formContainer({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _rollNoField() {
    return TextField(
      controller: rollNoController,
      decoration: const InputDecoration(
        labelText: 'Student Roll No',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _nameField({String label = 'Name'}) {
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _operataionButton({required String selectedLabel}) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          readAllStudentStringGenerator();
          selectedAction = selectedLabel;
          clearData();
        });
      },
      child: Text(selectedLabel),
    );
  }

  @override
  void dispose() {
    rollNoController.dispose();
    nameController.dispose();
    Hive.close();
    super.dispose();
  }
}
