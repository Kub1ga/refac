class ListServiceModel {
    ListServiceModel({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Datum> data;

    factory ListServiceModel.fromJson(Map<String, dynamic> json){ 
        return ListServiceModel(
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.idCategory,
        required this.nameService,
        required this.price,
    });

    final int? id;
    final int? idCategory;
    final String? nameService;
    final num? price;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            idCategory: json["id_category"],
            nameService: json["name_service"],
            price: json["price"],
        );
    }

}
