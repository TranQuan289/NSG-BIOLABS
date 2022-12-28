import 'package:api/api.dart';

class SitesRequest {
  SitesRequest._();
  static APIRequest getFilter() {
    return APIRequest(method: HTTPMethods.get, path: '/sites/options_filter');
  }
}
