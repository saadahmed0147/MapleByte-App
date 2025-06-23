import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Component/round_button.dart';
import 'package:maple_byte/Component/round_textfield.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Utils/utils.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  bool _loading = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  void onLogin() {
    setState(() {
      _loading = true;
    });
    _firebaseAuth
        .signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString(),
        )
        .then((value) {
          setState(() {
            _loading = false;
          });
          Utils.flushBarErrorMessage('Login Successfully', context);
          Utils.flushBarErrorMessage(value.user!.email.toString(), context);
          Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
        })
        .onError((error, stackTrace) {
          setState(() {
            _loading = false;
          });
          Utils.flushBarErrorMessage(error.toString(), context);
        });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,

        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(),
                child: SizedBox(
                  height: mq.height * 0.4,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/login.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: AppColors.darkBlueColor,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            RoundTextField(
                              label: 'Email',
                              hint: 'Email Address',
                              inputType: TextInputType.emailAddress,
                              // prefixIcon: Icons.email,
                              textEditingController: emailController,
                              validatorValue: 'Please Enter Email',
                              focusNode: emailFocusNode,
                              onFieldSubmitted: (value) {
                                Utils.fieldFocusNode(
                                  context,
                                  emailFocusNode,
                                  passFocusNode,
                                );
                              },
                            ),
                            RoundTextField(
                              label: 'Password',
                              hint: 'Password',
                              inputType: TextInputType.name,
                              // prefixIcon: Icons.lock,
                              textEditingController: passwordController,
                              isPasswordField: true,
                              validatorValue: 'Please Enter Password',
                              focusNode: passFocusNode,
                              onFieldSubmitted: (value) {
                                onLogin();
                              },
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.forgetpassScreen,
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: AppColors.lightBlueColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundButton(
                          loading: _loading,
                          title: 'Login',
                          fontSize: 15,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              onLogin();
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Not a member?",
                            style: TextStyle(color: AppColors.greyColor),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: Colors.transparent,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.signupScreen,
                              );
                            },
                            child: const Text(
                              'Register now',
                              style: TextStyle(color: AppColors.lightBlueColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
