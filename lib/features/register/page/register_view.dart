import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/snak_bar_service.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/login/page/login_view.dart';

import '../../../core/widgets/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = "register";

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var formKey = GlobalKey<FormState>();

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    // var vm = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_background.png'),
          fit: BoxFit.cover,
        ),
        color: Color(0xFFDFECDB),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Create Account",
            style: theme.textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mediaQuery.height * .17,
                  ),
                  Text(
                    "Full Name",
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: fullNameController,
                    hint: "Enter your Full Name",
                    keyboardType: TextInputType.name,
                    hintColor: Colors.grey,
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null; // Returns null means validation is passed
                    },
                    suffixWidget: Icon(
                      Icons.person,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "E-mail",
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hint: "Enter your email address",
                    keyboardType: TextInputType.emailAddress,
                    hintColor: Colors.grey,
                    suffixWidget: Icon(
                      Icons.email,
                      color: Colors.grey.shade700,
                    ),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "You must enter your e-mail";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Invalid E-mail";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password",
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hint: "Enter your password",
                    hintColor: Colors.grey,
                    isPassword: true,
                    maxLines: 1,
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      // Define the password validation regex pattern
                      String pattern =
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                      RegExp regex = RegExp(pattern);
                      // Check for minimum length
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      // Check for at least one uppercase letter
                      if (!regex.hasMatch(value)) {
                        return 'Password must have at least one uppercase letter';
                      }
                      // Check for at least one lowercase letter
                      if (!regex.hasMatch(value)) {
                        return 'Password must have at least one lowercase letter';
                      }
                      // Check for at least one digit
                      if (!regex.hasMatch(value)) {
                        return 'Password must have at least one number';
                      }
                      // Check for at least one special character
                      if (!regex.hasMatch(value)) {
                        return 'Password must have at least one special character (@!%*?&)';
                      } else {
                        return null; // Returns null means validation is passed
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Confirm Password",
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hint: "Enter your confirm password",
                    hintColor: Colors.grey,
                    isPassword: true,
                    maxLines: 1,
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      // Define the password validation regex pattern
                      if (value != passwordController.text) {
                        return "Password Not Matched";
                      }
                      return null; // Returns null means validation is passed
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print("Validation Done");
                        Navigator.pushReplacementNamed(
                            context, LayoutView.routeName);
                        FirebaseUtils()
                            .createUserAccount(
                          emailController.text,
                          passwordController.text,
                        )
                            .then((value) {
                          if (value == true) {
                            EasyLoading.dismiss();
                            SnackBarService.showSuccessMessage(
                                "Account Successfully Created");
                            if (mounted) {
                              // Add this check before navigating
                              Navigator.pushNamedAndRemoveUntil(context,
                                  LoginView.routeName, (route) => false);
                            }
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
