import 'package:bloc/bloc.dart';

class AuthenticationBlocBloc extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  AuthenticationBlocBloc() : super(AuthenticationBlocInitial()) {
    on<AuthenticationBlocEvent>((event, emit) {

    });
  }
