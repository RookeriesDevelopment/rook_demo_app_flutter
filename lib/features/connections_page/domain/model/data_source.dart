import 'package:equatable/equatable.dart';

class DataSource extends Equatable {
  final String name;
  final String description;
  final String thumbnail;
  final bool connected;
  final String? connectionUrl;

  const DataSource({
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.connected,
    this.connectionUrl,
  });

  bool get isConnected => connected || connectionUrl == null;

  @override
  List<Object?> get props => [
    name,
    description,
    thumbnail,
    connected,
    connectionUrl,
  ];
}
