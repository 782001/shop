import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/all_register_screen/register_cubit/register_states.dart';
import 'package:shop/end_points/end_point.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/network/remote/dio_helper.dart';

import '../../models/login_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);



  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,

  }){
    emit(RegisterLoadingState());
    DioHelper.Postdata(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.FromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }


  Icon suffix= Icon(Icons.remove_red_eye) ;
  bool isPasswordShow=true;

  void ChangeRegisterPaswordVisibility(){
    isPasswordShow=!isPasswordShow;
    suffix=isPasswordShow? Icon(Icons.remove_red_eye): Icon(Icons.visibility_off);
    emit(RegisterChangePasswordVisibilityState());

  }

}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop/all_register_screen/register_cubit/register_states.dart';
//
// import '../../end_points/end_point.dart';
// import '../../models/login_model.dart';
// import '../../network/remote/dio_helper.dart';
//
//
// class RegisterCubit extends Cubit<RegisterStates>{
//   RegisterCubit() : super(RegisterInitialState());
//
//   static RegisterCubit get(context) => BlocProvider.of(context);
//
//   LoginModel? loginModel;
//
//   void userRegister({
//     required String name,
//     required String email,
//     required String password,
//     required String phone,
//   }){
//     emit(RegisterLoadingState());
//     DioHelper.Postdata(
//       url: REGISTER,
//       data: {
//         'name': name,
//         'email': email,
//         'password': password,
//         'phone': phone,
//       },
//     ).then((value) {
//       print(value.data);
//       loginModel = LoginModel.FromJson(value.data);
//       emit(RegisterSuccessState(loginModel!));
//     }).catchError((error){
//       emit(RegisterErrorState(error.toString()));
//     });
//   }
//
//   IconData suffix = Icons.visibility;
//   bool isPassword = false;
//   void changePasswordVisibility(){
//     isPassword = !isPassword;
//     suffix = isPassword ? Icons.visibility : Icons.visibility_off;
//     emit(RegisterChangePasswordVisibilityState());
//   }
//
//
//   IconData confirmSuffix = Icons.visibility;
//   bool isConfirmPassword = false;
//   void changeConfirmPasswordVisibility(){
//     isConfirmPassword = !isConfirmPassword;
//     confirmSuffix = isConfirmPassword ? Icons.visibility : Icons.visibility_off;
//     emit(RegisterChangePasswordVisibilityState());
//   }
//
//
//
//   bool emailValid= false;
//   bool legalEmail(String email){
//     return emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
//   }
// }