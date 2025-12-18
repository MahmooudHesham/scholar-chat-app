import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snackBar.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/cubits/signup_cubit/signup_cubit.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'SignUpScreen';

  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SignupSuccess) {
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
          isLoading = false;
        } else if (state is SignupFailure) {
          showSnackBar(context, state.errMsg);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: Colors.amber,
          ),
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 100),

                    Image.asset('assets/images/scholar.png', height: 100),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),

                    const Row(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormfield(
                      hintText: 'Email',
                      onChange: (data) {
                        email = data;
                      },
                    ),

                    const SizedBox(height: 10),

                    CustomTextFormfield(
                      obsecureText: true,
                      hintText: 'Password',
                      onChange: (data) {
                        password = data;
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomButton(
                      text: 'Sign Up',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignupCubit>(
                            context,
                          ).signUpUser(email: email!, password: password!);
                        } else {}
                      },
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "already have an account ?",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "  Sign in",
                            style: TextStyle(color: Color(0xffC7EDE6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> signUpUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
