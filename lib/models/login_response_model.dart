class LoginResponseModel {
  String? message;
  String? username;

  LoginResponseModel({this.message, this.username});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['username'] = this.username;
    return data;
  }
}
