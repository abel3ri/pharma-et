import 'package:pharma_et/utils/Constants.dart';

class FormValidator {
  static String? emailOrPhoneValidator(String? value) {
    if (value!.isEmpty) return "Please provide phone or email";
    if (!(emailRegex.hasMatch(value) || phoneRegex.hasMatch(value)))
      return "Please provide a valid phone or email";
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please provide a phone number';
    }
    if (!phoneRegex.hasMatch(value))
      return "Please enter valid phone number (+251XXXXXXXXX)";
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) return "Please provide a password";
    if (value.length < 8) return "Password must be at least 8 chars long";
    return null;
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) return "Please provide a name";
    if (!nameRegex.hasMatch(value)) return "Please provide a valid name";
    return null;
  }
}
