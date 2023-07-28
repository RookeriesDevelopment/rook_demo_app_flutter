import 'package:rook_demo_flutter/features/connections_page/data/remote/dto/data_source_dto.dart';
import 'package:rook_demo_flutter/features/connections_page/domain/model/data_source.dart';

extension Mappers on DataSourceDto {
  DataSource toDomain() {
    return DataSource(
      name: name,
      description: description,
      thumbnail: image,
      connected: connected,
      connectionUrl: authorizationUrl,
    );
  }
}
