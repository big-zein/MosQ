import 'package:email_validator/email_validator.dart';

class Validator {
  String? error;
  bool isDone = false;
  final String attributeName;
  final String? value;

  Validator({
    required this.attributeName,
    required this.value,
  });


  String? getError() {
    return error;
  }

  // Stop on first error occurence
  void _setDone(String error) {

    isDone = true;
    this.error = error;
  }

  // Validations
  void required() {
    if (!isDone) {
      if (value == null || value!.isEmpty) {
        _setDone('$attributeName cannot be empty');
      }
    }
  }
  void email() {
    if (!isDone && value != null && value!.isNotEmpty) {
      if (!EmailValidator.validate(value.toString())) {
        _setDone('$attributeName is not a valid email');
      }
    }
  }
  void minLength(int length) {
    if (!isDone && value != null && value!.isNotEmpty) {
      if (value!.length < length) {
        _setDone('$attributeName cannot be less than $length characters');
      }
    }
  }
  void maxLength(int length) {
    if (!isDone && value != null && value!.isNotEmpty) {
      if (value!.length > length) {
        _setDone('$attributeName cannot be more than $length characters');
      }
    }
  }
  void integer() {
    if (!isDone && value != null && value!.isNotEmpty) {
      try {
        int.parse(value.toString());
      } catch(e) {
        _setDone('$attributeName must be an integer');
      }
    }
  }
  void min(int min) {
    if (!isDone && value != null && value!.isNotEmpty) {
      try {
        var num = double.parse(value.toString());
        if (num < min) {
          _setDone('$attributeName must be at least $min');
        }
      } catch(e) {}
    }
  }
  void max(int max) {
    if (!isDone && value != null && value!.isNotEmpty) {
      try {
        var num = double.parse(value.toString());
        if (num > max) {
          _setDone('$attributeName may not be greater than $max');
        }
      } catch(e) {}
    }
  }
}