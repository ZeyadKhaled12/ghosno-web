class GFunValid {
  static bool isValidEgyptianPhone(String phone) {
    return RegExp(r'^01[0125][0-9]{8}$').hasMatch(phone);
  }

  static bool isValidEmail(String email) {
    // Standard robust regex for email validation
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }
}
