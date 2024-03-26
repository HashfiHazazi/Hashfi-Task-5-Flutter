// ignore_for_file: avoid_print, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task5_application/src/features/login/application/services/login_service.dart';
import 'package:task5_application/src/features/login/presentation/states/bloc/login_bloc.dart';
import 'package:task5_application/src/features/login/presentation/widgets/toast_content.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text controller for text field
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Show Error toast if text field empty
  late FToast fToast;
  @override
  void initState() {
    fToast = FToast();
    super.initState();
    fToast.init(context);
  }

  bool isVisibilityPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'My APPS',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                width: double.infinity,
                height: 400,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
                child: Image.asset('assets/images/login_image1.png'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(horizontal: 19),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
                child: TextField(
                  cursorHeight: 16,
                  controller: _emailController,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary),
                    label: const Text('email'),
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(horizontal: 19),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
                child: TextField(
                  cursorHeight: 16,
                  controller: _passwordController,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    label: const Text('password'),
                    floatingLabelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary),
                    suffixIcon: IconButton(
                      onPressed: () {
                        (!isVisibilityPassword)
                            ? isVisibilityPassword = true
                            : isVisibilityPassword = false;
                        setState(() {});
                      },
                      icon: Icon(
                        (isVisibilityPassword == true)
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  obscureText: (!isVisibilityPassword) ? false : true,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 19),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 0.25,
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  onPressed: () async {
                    if (_emailController.text == '' &&
                        _emailController.text.isEmpty) {
                      fToast.showToast(
                        child: const ToastContent(toastMessage: 'Email'),
                        gravity: ToastGravity.CENTER,
                        toastDuration: const Duration(seconds: 2),
                      );
                    } else if (_passwordController.text == '' &&
                        _passwordController.text.isEmpty) {
                      fToast.showToast(
                        child: const ToastContent(toastMessage: 'Password'),
                        gravity: ToastGravity.CENTER,
                        toastDuration: const Duration(seconds: 2),
                      );
                    }
                    //TODO implement login service using bloc/cubit
                    final loginApi = await LoginService().fetchLogin(
                        _emailController.text, _passwordController.text);

                    if (context.mounted) {
                      //Use Login Bloc State to show login circular progress & navigate to article page
                      LoginBloc loginBloc =
                          LoginBloc(loginStatus: loginApi, context: context)
                            ..add(LoadLogin());
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            BlocBuilder<LoginBloc, LoginState>(
                          bloc: loginBloc,
                          builder: (context, state) {
                            if (state is LoginSuccess) {
                              return SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.asset(
                                        'assets/images/loading_annimation.gif'),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                              );
                            }
                          },
                        ),
                      );
                    }
                    setState(() {});
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
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
