import 'package:flutter/material.dart';
import 'package:flutter_mobigic/jobs/components/jobs_gender_selector.dart';
import 'package:flutter_mobigic/jobs/components/jobs_input_field.dart';
import 'package:flutter_mobigic/jobs/components/jobs_job_dropdown.dart';
import 'package:flutter_mobigic/jobs/components/jobs_skill_checkboxes.dart';
import 'package:flutter_mobigic/jobs/components/jobs_submit_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JobApplicationFormScreen extends StatefulWidget {
  const JobApplicationFormScreen({super.key});

  @override
  State<JobApplicationFormScreen> createState() =>
      _JobApplicationFormScreenState();
}

class _JobApplicationFormScreenState extends State<JobApplicationFormScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _linkedInController = TextEditingController();

  String? _gender;
  String? _jobRole;
  Map<String, bool> _skills = {};

  bool _isLoading = false;

  // Define skills for each job role
  final Map<String, List<String>> _roleSkills = {
    'Flutter Developer': ['Flutter', 'Firebase', 'Git', 'REST APIs'],
    'Backend Developer': ['Node.js', 'Dart', 'SQL', 'REST APIs', 'Git'],
    'UI/UX Designer': ['Figma', 'Adobe XD', 'Sketch', 'User Research'],
    'QA Tester': ['Manual Testing', 'Automation', 'Selenium', 'Bug Reporting'],
  };

  void _updateSkillsForRole(String? role) {
    final skills = _roleSkills[role] ?? [];
    setState(() {
      _skills = {for (var skill in skills) skill: false};
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future<void> _submitForm() async {
    if (!validateRequiredFields(
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      gender: _gender,
      jobRole: _jobRole,
      skills: _skills,
    )) {
      _showToast('Please fill all required fields');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application submitted successfully')),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _linkedInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Application Form'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InputField(
                        label: 'Full Name',
                        controller: _fullNameController,
                      ),
                      InputField(
                        label: 'Email Address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      InputField(
                        label: 'Phone Number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      InputField(
                        label: 'LinkedIn Profile',
                        controller: _linkedInController,
                        requiredField: false,
                        keyboardType: TextInputType.url,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GenderSelector(
                  gender: _gender,
                  onChanged: (value) => setState(() => _gender = value),
                ),
                const SizedBox(height: 16),
                JobDropdown(
                  jobRole: _jobRole,
                  onChanged: (value) {
                    setState(() {
                      _jobRole = value;
                    });
                    _updateSkillsForRole(value);
                  },
                ),
                const SizedBox(height: 16),
                if (_jobRole != null)
                  SkillCheckboxes(
                    skills: _skills,
                    onChanged: (skill, checked) =>
                        setState(() => _skills[skill] = checked),
                  ),
                if (_jobRole == null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: const Text(
                      'Select a job role to see relevant skills.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                const SizedBox(height: 32),
                SubmitButton(
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : _submitForm,
                ),
              ],
            ),
          ),
          if (_isLoading)
            const ColoredBox(
              color: Colors.black,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  bool validateRequiredFields({
    required String fullName,
    required String email,
    required String phone,
    required Map<String, bool> skills,
    String? gender,
    String? jobRole,
  }) {
    if (fullName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        gender == null ||
        jobRole == null ||
        skills.isEmpty) {
      return false;
    }
    return true;
  }
}
