import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/end_points/end_point.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/network/remote/dio_helper.dart';
import '../../models/login_model.dart';
import 'login_states.dart';
 class LoginCubit extends Cubit<LoginStates>{
   LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
   LoginModel? loginModel;
void UserLogin({
  required String email,
  required String password,
}){
  emit(LoginLodingState());
  DioHelper.Postdata(
      url: LOGIN,
      data: {
        "email":email,
        "password":password
      }
  ).then((value) {
    print(value.data);
    loginModel= LoginModel.FromJson(value.data);
    emit(LoginSucssesState(loginModel!));
      }
      )
      .catchError((error){
     emit(LoginErrorState( error));
     print(error.message());
  })
  ;
}


 Icon suffix= Icon(Icons.remove_red_eye) ;
 bool isPasswordShow=true;

void ChangePaswordVisibility(){
  isPasswordShow=!isPasswordShow;
  suffix=isPasswordShow? Icon(Icons.remove_red_eye): Icon(Icons.visibility_off);
  emit(LoginChangePaswordVisibilityState());

}

}