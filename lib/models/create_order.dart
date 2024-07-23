class CreateOrderModel {
    CreateOrderModel({
        required this.message,
        required this.data,
    });

    final String? message;
    final Data? data;

    factory CreateOrderModel.fromJson(Map<String, dynamic> json){ 
        return CreateOrderModel(
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.id,
        required this.idCategoryService,
        required this.idUsers,
    });

    final int? id;
    final int? idCategoryService;
    final int? idUsers;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            idCategoryService: json["id_category_service"],
            idUsers: json["id_users"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_category_service": idCategoryService,
        "id_users": idUsers,
    };

}
