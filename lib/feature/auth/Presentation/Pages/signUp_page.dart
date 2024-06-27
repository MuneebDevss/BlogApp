
import 'package:blog_app_vs/Core/Theme/Palatte.dart';
import 'package:blog_app_vs/Core/Utils/snack_bar.dart';
import 'package:blog_app_vs/Core/Widgets/loading.dart';
import 'package:blog_app_vs/feature/auth/Presentation/Widgets/AuthWidgets.dart';
import 'package:blog_app_vs/feature/auth/Presentation/bloc/auth_bloc.dart';
import 'package:blog_app_vs/feature/blog/Presentaion/Pages/Blogs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final name= TextEditingController();
  final email= TextEditingController();
  final password= TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:BlocConsumer<AuthBloc,AuthState>(
          listener:(context,state)
          {
            if(state is AuthFailure)
            {
              showSnackBar(context, state.message);
            }
            if(state is AuthSuccess)
            {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context)=>const Blogs()),
                      (route) => false);
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

                    const Text("Sign Up.",style: TextStyle(color: AppPallete.White,fontSize: 45,fontWeight: FontWeight.w800),),

                    const SizedBox(height: 40,),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          AuthField(hintText: "Name",controllers: name,),
                          const SizedBox(height: 20,),
                          AuthField(hintText: "Email",controllers: email),
                          const SizedBox(height: 20,),
                          AuthField(hintText: "Password",controllers: password,isObsecure:true),
                          const SizedBox(height: 20,),
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
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthSignUp(
                                      name: name.text.trim(),
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(395, 50),
                                backgroundColor: AppPallete.transparentColor,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: AppPallete.White,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:RichText(text: TextSpan(
                                  text: "Already have an account? ",
                                  style: Theme.of(context).textTheme.titleMedium,
                                  children: [
                                    TextSpan(
                                      text: "Sign In",
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color:AppPallete.gradient2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]
                              ))
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              );
              }
      ),
    ),
    );
  }
}
