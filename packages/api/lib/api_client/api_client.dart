import 'package:api/api.dart';

abstract class APIClient {
  Future<APIResponse> execute({required APIRequest request});
}
