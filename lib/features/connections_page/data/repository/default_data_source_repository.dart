import 'package:rook_demo_flutter/features/connections_page/data/mapper/data_source_mappers.dart';
import 'package:rook_demo_flutter/features/connections_page/data/remote/data_sources_api_service.dart';
import 'package:rook_demo_flutter/features/connections_page/domain/model/data_source.dart';
import 'package:rook_demo_flutter/secrets.dart';

class DefaultDataSourceRepository {
  final DataSourcesApiService dataSourcesApiService = DataSourcesApiService();

  Future<List<DataSource>> getDataSources(
    String clientUUID,
    String userID,
  ) async {
    final response = await dataSourcesApiService.getDataSources(
      clientUUID,
      userID,
    );

    return response.map((element) => element.toDomain()).toList();
  }
}
