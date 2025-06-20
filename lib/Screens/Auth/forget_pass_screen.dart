import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Component/round_button.dart';
import 'package:maple_byte/Component/round_textfield.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/Utils/utils.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  bool _loading = false;

  Future<void> _sendResetLink() async {
    setState(() => _loading = true);

    final email = emailController.text.trim();
    final dbRef = FirebaseDatabase.instance.ref().child("users");

    try {
      final snapshot = await dbRef.orderByChild("email").equalTo(email).get();

      if (!snapshot.exists) {
        Utils.flushBarErrorMessage('No user found with this email.', context);
        setState(() => _loading = false);
        return;
      } else {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        Utils.flushBarErrorMessage(
          'Password reset link sent to your email.',
          context,
          success: true,
        );
        // ✅ Clear email field and dismiss keyboard
        emailController.clear();
        FocusScope.of(context).unfocus();
      }
    } catch (e) {
      print(e);
      Utils.flushBarErrorMessage(
        'Something went wrong. Please try again.',
        context,
      );
    }

    setState(() => _loading = false);
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.whiteColor,
      ),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Forgot Password?",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,

                  color: AppColors.darkBlueColor,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 50),
                child: const Text(
                  "Enter your email and we'll send you a link to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      label: "Email Address",
                      hint: "Email",
                      inputType: TextInputType.emailAddress,
                      textEditingController: emailController,
                      validatorValue: "Please enter a valid email",
                      focusNode: emailFocusNode,
                    ),
                    SizedBox(height: 20),
                    RoundButton(
                      title: "Send Reset Link",
                      loading: _loading,

                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          _sendResetLink();
                        }
                      },

                      fontSize: 15,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
