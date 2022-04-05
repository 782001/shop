class FavoritesModel {
  bool? status;
  String? message;
  Data? data;



  FavoritesModel.Fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =  Data.Fromjson(json['data']) ;
  }


}

class Data {
  late int currentPage;
  List<Data2> data2=[];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late  String lastPageUrl;
  late Null? nextPageUrl;
 late String path;
  int? perPage;
  Null? prevPageUrl;
  late int to;
  late int total;



  Data.Fromjson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

      json['data'].forEach((element) {
        data2.add( Data2.Fromjson(element));
      });

    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class Data2 {
  int? id;
  Product? product;



  Data2.Fromjson(Map<String, dynamic> json) {
    id = json['id'];
    product =Product.Fromjson(json['product'] );

  }

}

class Product {
late  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
late  String image;
late  String name;
late  String description;



  Product.Fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}