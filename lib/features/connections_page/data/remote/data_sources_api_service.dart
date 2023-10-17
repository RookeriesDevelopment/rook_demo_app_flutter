import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:rook_demo_flutter/common/extension/response_extensions.dart';

import 'dto/data_source_dto.dart';

/// Helper class to send health data requests.
class DataSourcesApiService {
  final Client _client = Client();

  final String _baseUrl =
      kDebugMode ? 'api.rook-connect.review' : 'api.rook-connect.com';

  final String _apiVersion = '/api/v1/';

  Future<List<DataSourceDto>> getDataSources(
      String clientUUID, String userID) async {
    final uri = Uri.https(
      _baseUrl,
      '${_apiVersion}client_uuid/$clientUUID/user_id/$userID/configuration',
    );

    final response = await _client.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      final dataSources = decoded['data_sources'] as List<dynamic>;

      return dataSources.map((json) => DataSourceDto.fromJson(json)).toList();
    } else {
      throw Exception(response.printError());
    }
  }
}
