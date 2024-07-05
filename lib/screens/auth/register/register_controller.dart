import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weatherapp/screens/auth/register/register_model.dart';

class RegisterController {
  RegisterModel model;

  bool isValidEmail=false;



  RegisterController(this.model);

  void updateFirstName(String firstname) {
    model.firstname = firstname;
  }

  void updateLastName(String lastname) {
    model.lastname = lastname;
  }

  void updateEmail(String email) {
    model.email = email;
  }

  void updateGender(String gender) {
    model.gender = gender;
  }

  void updatePassword(String password) {
    model.password = password;
  }

  void updateReenterpassword(String reenterpassword) {
    model.reenterpassword = reenterpassword;
  }

  void updateImage(File imageFile) {
    model.image = imageFile;
  }








  Future<void> saveRegistrationData() async {
    final box = GetStorage();

    // Save registration data to get_storage
    await box.write('firstname', model.firstname);
    await box.write('lastname', model.lastname);
    await box.write('email', model.email);
    await box.write('gender', model.gender);
    await box.write('password', model.password);
    await box.write('reenterpassword', model.reenterpassword);

    final image = model.image;
    if (image != null) {
      await box.write('imagePath', image.path);
    }

    // Print a message indicating data has been saved
    print('Registration data saved successfully!');
  }
}