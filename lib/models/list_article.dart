class ListArticleModel {
    ListArticleModel({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Datum> data;

    factory ListArticleModel.fromJson(Map<String, dynamic> json){ 
        return ListArticleModel(
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
        required this.title,
        required this.content,
        required this.picture,
    });

    final int? id;
    final String? title;
    final String? content;
    final String? picture;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            title: json["title"],
            content: json["content"],
            picture: json["picture"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "picture": picture,
    };

}
