import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          // ignore: unused_local_variable
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errMessage: "User not found"));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(errMessage: "Wrong password"));
          } else {
            emit(LoginFailure(errMessage: "Something went wrong"));
          }
        } catch (e) {
          emit(LoginFailure(errMessage: "Something went wrong"));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          // ignore: unused_local_variable
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(errMessage: "Weak password"));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(errMessage: "E-mail already in use"));
          }
        } catch (e) {
          emit(RegisterFailure(errMessage: "There was an error"));
        }
      }
    });
  }
}
