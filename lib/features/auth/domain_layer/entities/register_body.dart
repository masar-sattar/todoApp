class RegisterBody {
  String displayName;
  int years;
  String password;
  String phone;
  String address;
  String level;

  RegisterBody({
    required this.displayName,
    required this.years,
    required this.password,
    required this.phone,
    required this.address,
    required this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "password": password,
      "displayName": displayName,
      "experienceYears": years,
      "address": address,
      "level": level,
    };
  }
}
