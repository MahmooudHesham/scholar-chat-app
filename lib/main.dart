import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/screens/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_chat/screens/cubits/signup_cubit/signup_cubit.dart';
import 'package:scholar_chat/screens/login_screen.dart';
import 'package:scholar_chat/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Noto Sans Arabic'),
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          ChatScreen.id: (context) => ChatScreen(),
        },
        initialRoute: LoginScreen.id,
      ),
    );
  }
}
