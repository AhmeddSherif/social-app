class UserModel {
  String? name;
  String? email;
  String? mobile;
  String? uId;
  bool? isEmailVerified;
  String? password;
  String? image;
  String? cover;
  String? bio;
  bool? userVerified;
  String? address;

  UserModel({
    this.name,
    this.email,
    this.mobile,
    this.uId,
    this.isEmailVerified,
    this.password,
    this.image,
    this.cover,
    this.bio,
    this.userVerified,
    this.address,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    password = json['password'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    userVerified = json['userVerified'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'email': email,
      'mobile': mobile,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'password': password,
      'image': image,
      'cover': cover,
      'bio': bio,
      'userVerified': userVerified,
    };
    return map;
  }
}
