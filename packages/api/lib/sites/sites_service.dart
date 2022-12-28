import 'package:api/api.dart';
import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/sites/sites_request.dart';
import 'package:domain/models/sites/filter_model.dart';

class SitesService {
  SitesService(this.restApiClient);

  final APIClient restApiClient;

  Future<ObjectResponse<FilterModel>> getFilter() async {
    final request = SitesRequest.getFilter();
    final response = await restApiClient.execute(request: request);
    final object = FilterModel.fromJson(response.data);
    return ObjectResponse(object: object);
  }
}
