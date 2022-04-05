class FavModel{
  late bool status;
  late String message;
  FavModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}