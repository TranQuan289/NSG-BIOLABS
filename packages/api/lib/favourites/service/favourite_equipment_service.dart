import 'package:api/api.dart';
import 'package:api/favourites/request/favourite_equipment_request.dart';
import 'package:domain/models/models.dart';

import '../../api_client/response_type/response_type.dart';

class FavouriteEquipmentService {
  final APIClient restAPIClient;
  FavouriteEquipmentService({
    required this.restAPIClient,
  });
  Future<ListResponse<EquipmentItem>> getFavouriteEquipmentItems({
    int? page,
    int? perPage,
    required String dataMode,
  }) async {
    final request = FavouriteEquipmentRequest.getFavouriteEquipmentItems(
      page: page,
      perPage: perPage,
      dataMode: dataMode,
    );
    final response = await restAPIClient.execute(request: request);
    final listResponse =
        response.toList().map<FavouriteEquipmentModel>((e) => FavouriteEquipmentModel.fromJson(e)).toList();
    return ListResponse(list: convertToListEquipment(listResponse));
  }

  Future<ObjectResponse<EquipmentItemToggleLike>> toggleLikeFavouriteEquipmentItem({
    required int id,
  }) async {
    final request = FavouriteEquipmentRequest.toggleLikeFavouriteEquipmentItem(id: id);
    final response = await restAPIClient.execute(request: request);
    final objectResponse = EquipmentItemToggleLike.fromJson(response.data);
    return ObjectResponse(object: objectResponse);
  }

  List<EquipmentItem> convertToListEquipment(List<FavouriteEquipmentModel> listEquipment) {
    List<EquipmentItem> result = [];
    for (var i in listEquipment) {
      if (i.orderable != null) {
        result.add(i.orderable!);
      }
    }
    return result;
  }
}
