class LoginModel{
  late bool status;
   late String message;
   userData? data;
  LoginModel.FromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
    // data = userData.FromJson(json['data']);
    data = json['data']!=null?userData.FromJson(json['data']):null;
  }

}
class userData{
   dynamic  id;
   String? name;
   String? phone;
   String? email;
   String? image;
   int? points;
   int? credit;
   String? token;
  userData.FromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }

}




class UserDataModel {
  bool? status;
  String? message;
  Data? data;



  UserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;



  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }


}
