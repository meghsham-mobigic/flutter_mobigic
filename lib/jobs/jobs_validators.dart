bool validateRequiredFields({
  required String fullName,
  required String email,
  required String phone,
  required String? gender,
  required String? jobRole,
  required Map<String, bool> skills,
}) {
  if (fullName.trim().isEmpty ||
      email.trim().isEmpty ||
      phone.trim().isEmpty ||
      gender == null ||
      jobRole == null ||
      !skills.containsValue(true)) {
    return false;
  }
  return true;
}
