import 'package:shop/models/add_favorites_model.dart';
import 'package:shop/models/login_model.dart';

abstract class ShopStates{}
 class InitialState extends ShopStates{}
 class changeBottomNAvState extends ShopStates{}


 class HomeDataLoadingState extends ShopStates{}
 class HomeDataSucssesState extends ShopStates{}
 class HomeDataErrorState extends ShopStates{}


 class HomeCategoryDataSucssesState extends ShopStates{}
 class HomeCategoryDataErrorState extends ShopStates{}


 class HomeFavoritesDataSucssesState extends ShopStates{}
 class HomeFavoritesDataErrorState extends ShopStates{}
 class HomeFavoritesDataLoadingState extends ShopStates{}

class ChangeFavoritesIconColorState extends ShopStates{}
class ChangeFavoritesIconColorSucssesState extends ShopStates{
 final FavModel model;

  ChangeFavoritesIconColorSucssesState(this.model);
}
 class ChangeFavoritesIconColorErrorState extends ShopStates{}


class GetProfileDataSucssesState extends ShopStates{}
class GetProfileDataErrorState extends ShopStates{}
class GetProfileDataLoadingState extends ShopStates{}
class UpdateProfileDataSucssesState extends ShopStates{}
class UpdateProfileDataErrorState extends ShopStates{}
class UpdateProfileDataLoadingState extends ShopStates{}