import 'package:domain/models/equipment_items/new_equipment_items_model.dart';
import 'package:domain/models/equipment_items/new_equipment_items_toggle_like_model.dart';

import '../../api_client/api_client.dart';
import '../../api_client/response_type/response_type.dart';
import '../request/equipment_items_request.dart';

class EquipmentService {
  final APIClient restAPIClient;
  EquipmentService({
    required this.restAPIClient,
  });
  Future<ListResponse<EquipmentItem>> getNewBookingEquipmentItems({
    int? page,
    int? perPage,
    List<int>? levels,
    List<int>? sites,
    List<int>? types,
    String? keywords,
  }) async {
    final request = EquipmentRequest.getNewBookingEquipmentItems(
      page: page,
      perPage: perPage,
      levels: levels,
      sites: sites,
      types: types,
      keywords: keywords,
    );
    final response = await restAPIClient.execute(request: request);
    final listResponse =
        response.toList().map<EquipmentItem>((e) => EquipmentItem.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ObjectResponse<EquipmentItemToggleLike>> toggleLikeNewBookingEquipmentItem({
    required int id,
  }) async {
    final request = EquipmentRequest.toggleLikeNewBookingEquipmentItem(id: id);
    final response = await restAPIClient.execute(request: request);
    final objectResponse = EquipmentItemToggleLike.fromJson(response.data);
    return ObjectResponse(object: objectResponse);
  }
}
