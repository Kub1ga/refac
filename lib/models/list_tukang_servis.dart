class ListTukangServis {
    ListTukangServis({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Datum> data;

    factory ListTukangServis.fromJson(Map<String, dynamic> json){ 
        return ListTukangServis(
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.phone,
        required this.photo,
    });

    final int? id;
    final String? name;
    final String? phone;
    final dynamic photo;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            name: json["name"],
            phone: json["phone"],
            photo: json["photo"],
        );
    }

}
