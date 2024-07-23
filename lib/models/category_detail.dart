class CategoryDetailModel {
    CategoryDetailModel({
        required this.message,
        required this.data,
    });

    final String? message;
    final Data? data;

    factory CategoryDetailModel.fromJson(Map<String, dynamic> json){ 
        return CategoryDetailModel(
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.id,
        required this.idCategory,
        required this.nameService,
        required this.price,
    });

    final int? id;
    final int? idCategory;
    final String? nameService;
    final num? price;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            idCategory: json["id_category"],
            nameService: json["name_service"],
            price: json["price"],
        );
    }

}
