class DetailUserModel {
    DetailUserModel({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.phone,
        required this.address,
        required this.createdAt,
    });

    final int? id;
    final String? name;
    final String? username;
    final String? email;
    final dynamic phone;
    final String? address;
    final DateTime? createdAt;

    factory DetailUserModel.fromJson(Map<String, dynamic> json){ 
        return DetailUserModel(
            id: json["id"],
            name: json["name"],
            username: json["username"],
            email: json["email"],
            phone: json["phone"],
            address: json["address"] ?? "",
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
    };

}
