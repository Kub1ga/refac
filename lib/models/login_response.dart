class LoginResponseModel {
    LoginResponseModel({
        required this.token,
        required this.message,
    });

    final String? token;
    final String? message;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json){ 
        return LoginResponseModel(
            token: json["token"],
            message: json["message"],
        );
    }

}
