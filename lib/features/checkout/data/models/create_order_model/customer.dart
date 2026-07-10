import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String email;
  final String phone;
  final String? firstName;
  final String lastName;

  const Customer(
      {required this.email,
      required this.phone,
      this.firstName,
      required this.lastName});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      email: json['email'] as String,
      phone: json['phone'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {
      'email': email,
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
    };
    body.removeWhere((key, value) => value == null);
    return body;
  }

  @override
  List<Object?> get props => [email, phone, firstName, lastName];
}
