import 'dart:io';

class RegisterModel {
  String firstname;
  String lastname;
  String email;
  String password;
  String reenterpassword;
  String gender;
  File? image;
  DateTime? dob;

  RegisterModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.reenterpassword,
    required this.gender,
    this.dob,
    this.image,
  });
}