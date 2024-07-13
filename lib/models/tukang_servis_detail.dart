class TukangServisDetail {
    TukangServisDetail({
        required this.message,
        required this.data,
    });

    final String? message;
    final Data? data;

    factory TukangServisDetail.fromJson(Map<String, dynamic> json){ 
        return TukangServisDetail(
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.phone,
        required this.photo,
    });

    final int? id;
    final String? name;
    final String? phone;
    final dynamic photo;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            name: json["name"],
            phone: json["phone"],
            photo: json["photo"],
        );
    }

}
