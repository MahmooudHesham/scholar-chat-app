import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(LoginFailure(errMsg: e.code));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errMsg: 'Something went wrong'));
    }
  }

  Future<void> signUpUser({
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailure(errMsg: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(
          SignupFailure(errMsg: 'The account already exists for that email.'),
        );
      }
    } on Exception catch (e) {
      emit(SignupFailure(errMsg: "There was an error, Please try again later"));
    }
  }
}
