class CategoryModel {
    CategoryModel({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Datum> data;

    factory CategoryModel.fromJson(Map<String, dynamic> json){ 
        return CategoryModel(
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.categoryName,
        required this.icon,
    });

    final int? id;
    final String? categoryName;
    final String? icon;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            categoryName: json["category_name"],
            icon: json["icon"],
        );
    }

}
