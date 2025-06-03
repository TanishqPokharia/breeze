import 'package:breeze/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.age,
    required super.gender,
    required super.email,
    required super.phone,
    required super.username,
    required super.birthDate,
    required super.image,
    required super.height,
    required super.weight,
  });

  // Creates a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      birthDate: json['birthDate'],
      image: json['image'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  // Converts UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'email': email,
      'phone': phone,
      'username': username,
      'birthDate': birthDate,
      'image': image,
      'height': height,
      'weight': weight,
    };
  }

  // Creates a copy of UserModel with specified fields replaced
  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    String? username,
    String? birthDate,
    String? image,
    num? height,
    num? weight,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      birthDate: birthDate ?? this.birthDate,
      image: image ?? this.image,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.gender == gender &&
        other.email == email &&
        other.phone == phone &&
        other.username == username &&
        other.birthDate == birthDate &&
        other.image == image &&
        other.height == height &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        username.hashCode ^
        birthDate.hashCode ^
        image.hashCode ^
        height.hashCode ^
        weight.hashCode;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, age: $age, gender: $gender, email: $email, phone: $phone, username: $username, birthDate: $birthDate, image: $image, height: $height, weight: $weight)';
  }
}
