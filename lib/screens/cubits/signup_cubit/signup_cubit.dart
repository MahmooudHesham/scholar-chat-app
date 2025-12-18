import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

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
