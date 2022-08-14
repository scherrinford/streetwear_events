import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;
  final String photoUrl;
  final String email;

  const User({
    required this.uid,
    required this.name,
    required this.photoUrl,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      email: json['email'] as String
    );
  }

  @override
  List<Object> get props => [
    uid,
    name,
    photoUrl,
    email,
  ];
}