import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:weatherapp/screens/auth/register/register_controller.dart';
import 'package:weatherapp/screens/auth/register/register_model.dart';

import '../login/login_view.dart';

const List<String> genderlist = <String>[
  'Male', 'Female', 'Others'
];

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  late File? image;
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _reenterpassword = TextEditingController();
  late RegisterController _controller;
  String? selectedGender;
  bool isValidate=false;

  @override
  void initState() {
    super.initState();
    _controller = RegisterController(RegisterModel(
      firstname: '',
      lastname: '',
      email: '',
      password: '',
      reenterpassword: '',
      gender: '',
    ));
    image = null; // Initialize image here
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Register"),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 5),
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                      ),
                      child: ClipOval(
                        child: image == null
                            ? Image.network(
                          'https://picsum.photos/200',
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        )
                            : Image.file(
                          image!,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: _pickImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Enter your first name',
                  border: OutlineInputBorder(),
                ),
                controller: _firstname,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Enter your last name',
                  border: OutlineInputBorder(),
                ),
                controller: _lastname,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                  ),
                  child: Center(
                    child: DropdownButtonFormField<String>(
                      items: genderlist.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text(
                        'Select Gender',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                      validator: (value) => value == null ? 'Please select a gender' : null,
                      isExpanded: true,
                      iconSize: 30,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 40),
              IntlPhoneField(
                controller: _phonenumber,
                decoration: const InputDecoration(
                  hintText: 'Enter Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.number.isEmpty) {
                    return 'Please enter your Mobile Number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  errorText: null,
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  hintText: 'Enter Email address',
                ),
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  // Regular expression for validating an Email
                  bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value);
                  if (!emailValid) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: 'Enter Password',
                ),
                controller: _password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Re-Enter Password",
                  hintText: 'Enter Password',
                ),
                controller: _reenterpassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Text("Already have an account? Please"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginView()),
                      );
                    },
                    child: const Text("login"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Debug prints
                  if (_formKey.currentState!.validate()) {
                  print("Data before navigation:");
                  print("First Name: ${_controller.model.firstname}");
                  print("Last Name: ${_controller.model.lastname}");
                  print("Email: ${_controller.model.email}");
                  print("Gender: ${_controller.model.gender}");
                  print("Password: ${_controller.model.password}");
                  print("Re-enter Password: ${_controller.model.reenterpassword}");
                  print("Image Path: ${_controller.model.image?.path}");
                  _controller.updateFirstName(_firstname.text);
                  _controller.updateLastName(_lastname.text);
                  _controller.updateEmail(_email.text);
                  _controller.updateGender(selectedGender ?? '');
                  _controller.updatePassword(_password.text);
                  _controller.updateReenterpassword(_reenterpassword.text);
                  _controller.updateImage(image!); // Ensure image is not null here
                  _controller.saveRegistrationData();
          
          
          
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ProfileView()),
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Processing Data')),
              );
              }
          
                  // );
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path); // Update image when picked
      });
    }
  }


}