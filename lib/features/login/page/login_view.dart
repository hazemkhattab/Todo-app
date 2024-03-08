import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/snak_bar_service.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/register/page/register_view.dart';

import '../../../core/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "login";

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Login",
            style: theme.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
            ),
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
                    "Welcome Back!",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Email",
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
                        return "You must enter your email address";
                      }
                      return null;
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
                      if (value == null || value.trim().isEmpty) {
                        return "You must enter your password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(
                            context, LayoutView.routeName);
                        FirebaseUtils()
                            .loginInUserAccount(
                          emailController.text,
                          passwordController.text,
                        )
                            .then((value) {
                          if (value == true) {
                            EasyLoading.dismiss();
                            SnackBarService.showSuccessMessage(
                                "Successfully logged in !");
                            Navigator.pushReplacementNamed(
                                context, LayoutView.routeName);
                          }
                          if (value == false) {
                            EasyLoading.dismiss();
                            SnackBarService.showErrorMessage(
                                "Invalid Username or Password");
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
                          "Login",
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
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text("OR", style: theme.textTheme.bodyLarge),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RegisterView.routeName,
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: Text(
                            "Create new account!",
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
