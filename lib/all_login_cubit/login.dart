
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/all_login_cubit/login_cubit/login_cubit.dart';
import 'package:shop/all_login_cubit/login_cubit/login_states.dart';
import 'package:shop/network/local/cashhelper.dart';
import 'package:shop/all_register_screen/register.dart';
import 'package:shop/shared/components.dart';

import '../homescreen/homescreen.dart';

class LoginScreen extends StatelessWidget {
var emailController =TextEditingController();
var passwordController =TextEditingController();
var formKey =GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
    create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state){
          if(state is LoginSucssesState){
          if(state.loginModel.status ){
            CashHelper.SaveData(key: 'token',
                value: state.loginModel.data!.token
            ).then((value) {
              token=state.loginModel.data!.token;
              print('save token');
              NavAndFinish(context, HomeLayOut());
              ShowToust(
                  Text: state.loginModel.message,
                  state: ToustStates.SUCSESS);
            });

          }
          else{
            ShowToust(Text: state.loginModel.message, state: ToustStates.ERROR);

          }
          }
        },
        builder: (context, state){
          return Scaffold(
            appBar:  AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const  Text('LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const  Text('Login Now To Browse Our Hot Offers  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onTap: (){},
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your email';
                            }
                          },
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email,
                              ),
                              labelText: 'Email',
                              border:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText:  LoginCubit.get(context).isPasswordShow,

                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).UserLogin(
                                email: emailController.text,
                                 password: passwordController.text);
                                  }
                            },
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your password';
                            }
                          },
                          keyboardType: TextInputType.text,
                          controller: passwordController,

                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),

                              suffixIcon:IconButton(
                                  icon: LoginCubit.get(context).suffix,
                                  onPressed: () {
                                    LoginCubit.get(context).ChangePaswordVisibility();
                                    },
                              ),
                              labelText: 'Password',
                              border:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                         condition: state is! LoginLodingState,
                          builder: (context)=>Container(
                            width: double.infinity,

                            color: DefaultColor,
                            child: MaterialButton(onPressed: (){
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).UserLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                              child: const Text('LOGIN',
                                style: TextStyle(
                                  color: Colors.white,

                                ),
                              ),

                            ),
                          ),
                          fallback: (context)=>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                NavTo(context,  RegisterScreen());
                              },
                              child: const Text('REGISTER'),
                            )
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
