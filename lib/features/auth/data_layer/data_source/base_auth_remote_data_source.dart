import '../../domain_layer/entities/register_body.dart';
import '../models/tokens_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<TokensModel> registerUser({
    required RegisterBody registerBody,
  });
  Future<TokensModel> loginUser({
    required  String phoneNumber,
    required String passWord,
  });
}
