import 'package:equatable/equatable.dart';

class DataSourceDto extends Equatable {
  final String name;
  final String description;
  final String image;
  final bool connected;
  final String? authorizationUrl;

  const DataSourceDto({
    required this.name,
    required this.description,
    required this.image,
    required this.connected,
    required this.authorizationUrl,
  });

  factory DataSourceDto.fromJson(Map json) {
    return DataSourceDto(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      connected: json['connected'] as bool,
      authorizationUrl: json['authorization_url'],
    );
  }

  DataSourceDto copyWith({
    String? name,
    String? description,
    String? image,
    bool? connected,
    String? authorizationUrl,
  }) {
    return DataSourceDto(
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      connected: connected ?? this.connected,
      authorizationUrl: authorizationUrl ?? this.authorizationUrl,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        image,
        connected,
        authorizationUrl,
      ];
}
