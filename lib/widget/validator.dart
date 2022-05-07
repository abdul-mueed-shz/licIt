class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email Can\'t be Empty';
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? validateCnic(String? value) {
    if (value == null || value.isEmpty) return 'Cnic Can\'t be Empty';
    //TO DO
    String pattern = r'^\d{5}(-)?\d{7}(-)?\d{1}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Cnic NO';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return 'PhoneNumber Can\'t be Empty';
    if (value.length != 11) {
      return 'Enter Valid Phone Number';
    }
    //TO DO
    String pattern = r'^[0][0-9]{10}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Phone Number must be of the form 0XXXXXXXXXX';
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name can\'t be empty';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password can\'t be empty';
    if (value.length <= 7) return 'password Minimum length is 8';
    return null;
  }
}
