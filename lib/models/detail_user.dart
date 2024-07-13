class DetailUserModel {
    DetailUserModel({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
    });

    final int? id;
    final String? name;
    final String? username;
    final String? email;

    factory DetailUserModel.fromJson(Map<String, dynamic> json){ 
        return DetailUserModel(
            id: json["id"],
            name: json["name"],
            username: json["username"],
            email: json["email"],
        );
    }

}
