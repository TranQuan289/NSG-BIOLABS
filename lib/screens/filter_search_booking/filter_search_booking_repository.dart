import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/sites/sites_service.dart';
import 'package:domain/models/sites/filter_model.dart';

import '../../utilities/rest_api_client/api_client.dart';

class FilterSearchBookingRepository {
  FilterSearchBookingRepository(this.restAPIClient);
  final RestAPIClient restAPIClient;
  Future<ObjectResponse<FilterModel>> getFilter() async {
    return SitesService(restAPIClient).getFilter();
  }
}
