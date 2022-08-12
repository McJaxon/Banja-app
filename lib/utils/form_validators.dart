//  DISABILITY INFORMATION MANAGEMENT SYSTEM - DMIS
//
//  Created by Ronnie Zad.
//  2021, Centric Solutions-UG. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

class FieldValidator {
  FieldValidator._();
  static String? validateEmail(String? value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value!.trim()) && value.isNotEmpty) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.length < 6) {
      return 'Enter at least 6 characters';
    } else if (value.isEmpty) {
      return 'Fill in Password please';
    } else {
      return null;
    }
  }

  static String? validateTIN(String value) {
    if (value.length < 10) {
      return 'Enter a correct TIN';
    } else if (value.isEmpty) {
      return 'Fill in please here';
    } else {
      return null;
    }
  }

  static String? validateLoanAmount(String? value, min, max) {
    Pattern pattern = r"^[0-9]";
    var amount = value!.replaceAll(RegExp(r'[^0-9]'), '');

    RegExp regex = RegExp(pattern.toString());
    if (int.parse(amount) > max) {
      return 'Value is too much';
    } else if (int.parse(amount) < min) {
      return 'Value is less';
    } else if (amount.isEmpty) {
      return 'Fill in a valid phone';
    } else {
      return null;
    }
  }

  static String? validatePhone(String? value) {
    Pattern pattern = r"^[0-9]";

    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value!)) {
      return 'Enter a correct phone number';
    } else if (value.length < 9) {
      return 'Enter a complete phone number';
    } else if (value.isEmpty) {
      return 'Fill in a valid phone';
    } else {
      return null;
    }
  }

  static String? validatePhone2(String? value) {
    Pattern pattern = r"^[0-9]";

    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value!) && value.isNotEmpty) {
      return 'Enter a correct phone number';
    } else if (value.length < 10 && value.isNotEmpty) {
      return 'Enter a complete phone number';
    }
    return null;
  }

  static String? validateNIN(String? value) {
    if (value != null) {
      if ((value.startsWith('F', 1) || value.startsWith('M', 1))) {
        return 'Enter a valid NIN, starting with \'CM......\' or \'CF......\'';
      } else if (value.length < 14 && value.isNotEmpty) {
        return 'Enter a complete NIN, it is 14 characters long';
      } else {
        return null;
      }
    } else {
      return 'Fill NIN';
    }
  }

  static String? validateDescription(String value) {
    if (value.isEmpty) {
      return 'Enter a description';
    } else {
      return null;
    }
  }

  static String? validateField(String? value) {
    if (value!.isEmpty) {
      return 'Enter this field';
    } else {
      return null;
    }
  }
}
