import 'package:blog_app/Core/Theme/Palatte.dart';
import 'package:blog_app/feature/auth/Presentation/Pages/signUp_page.dart';
import 'package:blog_app/feature/auth/Presentation/Widgets/AuthWidgets.dart';
import 'package:blog_app/feature/auth/Presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Utils/snack_bar.dart';
import '../../../../Core/Widgets/loading.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocConsumer<AuthBloc,AuthState>(
        listener:(context,state)
    {
      if(state is AuthFailure)
      {
        showSnackBar(context, state.message);
      }
    },
    builder:(context,state)
    {
    if(state is AuthLoading)
    {
    return const Loader();
    }


    return  Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login.",
              style: TextStyle(
                  color: AppPallete.White,
                  fontSize: 45,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  AuthField(hintText: "Email", controllers: email),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthField(
                      hintText: "Password",
                      controllers: password,
                      isObsecure: true),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppPallete.gradient1,
                        AppPallete.gradient2,
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate())
                        {
                          context.read<AuthBloc>().add(BlocLogin(email: email.text.trim(), password: password.text.trim()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(395, 50),
                        backgroundColor: AppPallete.transparentColor,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: AppPallete.White, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                            text: "Sign Up",
                            style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold,
                                    ),
                          )
                        ])),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
          ),
    );
  }
}
