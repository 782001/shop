

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/catogery/category.dart';
import 'package:shop/cubit/states.dart';
import 'package:shop/favoriets/favorites_screen.dart';
import 'package:shop/models/add_favorites_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/login_model.dart';

import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/products/product.dart';
import 'package:shop/settings/settings.dart';
import 'package:shop/shared/components.dart';

import '../end_points/end_point.dart';
import '../models/category_model.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(InitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);
int currentIndex=0;
List<Widget>screens=[
  const Product_Screen(),
  category_screen(),
  favoriets_screen(),
  Settings_screen()
];
void changeBottomNAv(int index){
  currentIndex=index;
  emit(changeBottomNAvState());
    }

    Map<int,bool>favoriets={};
HomeModel? homeModel;
void GetHomeDAta(){
  emit(HomeDataLoadingState());
DioHelper.getData(
    url: HOME,
  token: token
).then((value) {
  homeModel=HomeModel.fromJson(value.data);
  // print(homeModel!.data.products[0].image);
homeModel!.data.products.forEach((element) {
  favoriets.addAll({
    element.id: element.inFavorites
  });
});
print(favoriets);
  emit(HomeDataSucssesState());
}).catchError((error){
  print(error.toString());
  emit(HomeDataErrorState());
});
}

  CategoriesModel? CategoryModel;
void GetHomeCategories(){

DioHelper.getData(
    url: Categories,

).then((value) {
  CategoryModel=CategoriesModel.FromJson(value.data);
  print(CategoryModel!.data.data1);

  emit(HomeCategoryDataSucssesState());
}).catchError((error){
  print(error.toString());
  emit(HomeCategoryDataErrorState());
});
}



FavModel? favModel;
  void ChangeFavIcon(int ProductId){
    favoriets[ProductId] = !favoriets[ProductId]!;
emit(ChangeFavoritesIconColorState());
    DioHelper.Postdata(
      url: FAVORITES,
      data: {
        'product_id':ProductId,
      },
      token: token,

    ).then((value) {
      favModel=FavModel.fromJson(value.data);
      print(value.data);
      if(!favModel!.status){
        favoriets[ProductId] = !favoriets[ProductId]!;
      }else{
        GetHomeFavorite();
      }
      emit(ChangeFavoritesIconColorSucssesState(favModel!));
    }).catchError((error){
      favoriets[ProductId] = !favoriets[ProductId]!;
      print(error.toString());
      emit(ChangeFavoritesIconColorErrorState());
    });
  }


  FavoritesModel? favoritesModel;
  void GetHomeFavorite(){
    emit(HomeFavoritesDataLoadingState());

    DioHelper.getData(
      url: FAVORITES,
     token:  token
    ).then((value) {
      favoritesModel=FavoritesModel.Fromjson(value.data);
      print(favoritesModel!.data!.data2);

      emit(HomeFavoritesDataSucssesState());
    }).catchError((error){
      print(error.toString());
      emit(HomeFavoritesDataErrorState());
    });
  }



  UserDataModel? userModel;
  void GetUserData(){
    emit(GetProfileDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      userModel = UserDataModel.fromJson(value.data);
      emit(GetProfileDataSucssesState());
    }).catchError((onError){
      emit(GetProfileDataErrorState());
      print('Error Here When Get User Data ===>===>===>===>===> ${onError.toString()}');
    });

  }


  void UpdateUserData({
    required String name,
    required String email,
    required String phone,
}){
    emit(UpdateProfileDataLoadingState());
    DioHelper.putdata(
      url: UPDATEPROFILE,
      token:token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = UserDataModel.fromJson(value.data);
      emit(UpdateProfileDataSucssesState());
    }).catchError((onError){
      emit(UpdateProfileDataErrorState());
      print('Error Here When Update User Data ===>===>===>===>===> ${onError.toString()}');
    });

  }

}


