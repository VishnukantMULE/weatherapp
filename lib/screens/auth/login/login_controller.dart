

import 'login_model.dart';

class LoginController {
  LoginModel model;

  LoginController(this.model);
  bool validateuser() {
    return model.isValid();
  }

  void updateuserId(String userid) {
    model.userid = userid;
  }

  void updatePassword(String password) {
    model.password = password;
  }
}