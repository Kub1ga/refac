class AllOrderModels {
    AllOrderModels({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Datum> data;

    factory AllOrderModels.fromJson(Map<String, dynamic> json){ 
        return AllOrderModels(
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
        required this.nameService,
        required this.price,
        required this.name,
        required this.username,
        required this.email,
        required this.phone,
        required this.address,
        required this.description,
    });

    final int? id;
    final String? nameService;
    final int? price;
    final String? name;
    final String? username;
    final String? email;
    final String? phone;
    final String? address;
    final String? description;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            nameService: json["name_service"],
            price: json["price"],
            name: json["name"],
            username: json["username"],
            email: json["email"],
            phone: json["phone"],
            address: json["address"],
            description: json["description"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_service": nameService,
        "price": price,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
        "description": description,
    };

}
