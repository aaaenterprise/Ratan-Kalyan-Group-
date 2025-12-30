import 'package:get/get.dart';

class CustomValidation {
  static String? basicValidation({
    required String value,
    required String fieldName,
  }) {
    if (value == "") {
      return "$fieldName is required";
    } else if (value.length < 3) {
      return "$fieldName should be 3 ";
    }
    return null;
  }

  static String? descriptionValidation({
    required String value,
    required String fieldName,
  }) {
    if (value == "") {
      return "$fieldName is required";
    } else if (value.length < 10) {
      return "$fieldName length should be 10";
    }
    return null;
  }

  static String? validateName({required String name}) {
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!GetUtils.isEmail(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  static phoneValidator({required String phone}) {
    if (!isPhoneNumber(phone)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 10) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static validateMpin({required String name}) {
    if (name.isEmpty) {
      return 'Password can\'t be empty';
    } else if (name.length < 6) {
      return 'Enter a Password with length at least 6';
    }
  }
}
