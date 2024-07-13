class AddTukangServisModel {
    AddTukangServisModel({
        required this.id,
        required this.name,
        required this.phone,
    });

    final int? id;
    final String? name;
    final String? phone;

    factory AddTukangServisModel.fromJson(Map<String, dynamic> json){ 
        return AddTukangServisModel(
            id: json["id"],
            name: json["name"],
            phone: json["phone"],
        );
    }

}
