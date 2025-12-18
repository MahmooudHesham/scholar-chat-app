import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/helper/show_snackBar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

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
}
