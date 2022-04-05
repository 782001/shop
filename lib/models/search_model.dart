

class SearchModel {
  bool? status;
  String? message;
  Data? data;



  SearchModel.Fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =  Data.Fromjson(json['data']) ;
  }


}

class Data {
   int? currentPage;
  List<Data2> data2=[];
   String? firstPageUrl;
   int? from;
   int? lastPage;
    String? lastPageUrl;
   Null? nextPageUrl;
   String? path;
  int? perPage;
  Null? prevPageUrl;
   int? to;
   int ?total;



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
  late  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late  String image;
  late  String name;
  late  String description;



  Data2.Fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}