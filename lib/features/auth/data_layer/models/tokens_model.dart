import '../../domain_layer/entities/tokens.dart';

class TokensModel extends Tokens {
  TokensModel({
    required super.accesstoken,
    required super.refreshtoken,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) => TokensModel(
        accesstoken: json['access_token'],
        refreshtoken: json['refresh_token'],
      );
}
