class ServiceCategory {
    ServiceCategory({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Datum> data;

    factory ServiceCategory.fromJson(Map<String, dynamic> json){ 
        return ServiceCategory(
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
    };

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

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_category": idCategory,
        "name_service": nameService,
        "price": price,
    };

}
