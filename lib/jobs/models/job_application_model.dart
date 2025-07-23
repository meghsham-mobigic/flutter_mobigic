class JobApplicationModel {
  String fullName;
  String email;
  String phone;
  String? linkedIn;
  String gender;
  String jobRole;
  List<String> skills;

  JobApplicationModel({
    required this.fullName,
    required this.email,
    required this.phone,
    this.linkedIn,
    required this.gender,
    required this.jobRole,
    required this.skills,
  });
} 