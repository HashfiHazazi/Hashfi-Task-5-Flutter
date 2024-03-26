import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task5_application/src/routers/route_names.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final bool loginStatus;
  final BuildContext context;
  LoginBloc({required this.loginStatus, required this.context})
      : super(LoginInitial()) {
    on<LoadLogin>((event, emit) async {
      //If login success show circular progress loading and navigate to article page
      if (loginStatus == true) {
        emit(LoginSuccess());
        await Future.delayed(const Duration(seconds: 3));
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, RouteNames.article);
        }
      } else {
        //If login not success
        await Future.delayed(const Duration(seconds: 0));
        if (context.mounted) {
          Navigator.pop(context);
        }
      }

    });
  }
}
