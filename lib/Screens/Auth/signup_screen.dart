import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Component/round_button.dart';
import 'package:maple_byte/Component/round_textfield.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/Utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  void onSignUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      Utils.flushBarErrorMessage("Passwords do not match", context);
      return;
    }

    setState(() => _loading = true);

    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(nameController.text.trim());

        await _dbRef.child("users/${user.uid}").set({
          'uid': user.uid,
          'email': emailController.text.trim(),
          'name': nameController.text.trim(),
        });

        Utils.flushBarErrorMessage('Sign Up Successful', context);
        Navigator.pushNamed(context, RouteNames.progressScreen);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Something went wrong";

      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already registered. Please log in.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is invalid.";
      } else if (e.code == 'weak-password') {
        errorMessage = "The password is too weak.";
      }

      Utils.flushBarErrorMessage(errorMessage, context);
    } catch (e) {
      debugPrint("Other error: $e");
      Utils.flushBarErrorMessage(e.toString(), context);
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkBlueColor,
                    ),
                  ),
                  Text(
                    'Create an account to get started',
                    style: TextStyle(fontSize: 14, color: AppColors.greyColor),
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        RoundTextField(
                          label: 'Name',
                          hint: 'Full Name',
                          inputType: TextInputType.name,
                          prefixIcon: Icons.person,
                          textEditingController: nameController,
                          validatorValue: 'Please Enter Name',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        RoundTextField(
                          label: 'Email',
                          hint: 'Email',
                          inputType: TextInputType.emailAddress,
                          prefixIcon: Icons.email,
                          textEditingController: emailController,
                          validatorValue: 'Please Enter Email',
                          focusNode: emailFocusNode,
                          onFieldSubmitted: (_) {
                            Utils.fieldFocusNode(
                              context,
                              emailFocusNode,
                              passFocusNode,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        RoundTextField(
                          label: 'Create a password',
                          hint: 'Create a password',
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          textEditingController: passwordController,
                          isPasswordField: true,
                          validatorValue: 'Please Enter Password',
                          focusNode: passFocusNode,
                        ),
                        RoundTextField(
                          label: 'Confirm Password',
                          hint: 'Confirm Password',
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock_outline,
                          textEditingController: confirmPasswordController,
                          isPasswordField: true,
                          validatorValue: 'Please Confirm Password',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 10),
                    child: RoundButton(
                      loading: _loading,
                      title: 'Sign Up',
                      fontSize: 15,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          onSignUp();
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: AppColors.greyColor),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.loginScreen);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: AppColors.lightBlueColor),
                        ),
                      ),
                    ],
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
