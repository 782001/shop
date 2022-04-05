class CategoriesModel{
  late bool status;
  late CategoriesDataModel data ;
  CategoriesModel.FromJson(Map<String,dynamic>json){
    status=json['status'];
    data=CategoriesDataModel.FromJson(json['data']);
  }
}
class CategoriesDataModel{
  late int current_page;
  List<DataModel>data1=[];
  CategoriesDataModel.FromJson(Map<String,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data1.add(DataModel.FromJson(element));
    });
  }
}
class DataModel{
  late int id;
  late String name;
  late String image;
  DataModel.FromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}