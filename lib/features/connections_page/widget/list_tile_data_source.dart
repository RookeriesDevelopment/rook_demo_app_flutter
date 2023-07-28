import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/features/connections_page/domain/model/data_source.dart';

class ListTileDataSource extends StatelessWidget {
  final DataSource dataSource;
  final Function(String) onClick;

  const ListTileDataSource({
    Key? key,
    required this.dataSource,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(dataSource.thumbnail),
      title: Text(dataSource.name),
      subtitle: Text(dataSource.description),
      trailing: FilledButton(
        onPressed: dataSource.isConnected
            ? null
            : () => onClick(dataSource.connectionUrl!),
        child: dataSource.isConnected
            ? const Text('Connected')
            : const Text('Connect'),
      ),
    );
  }
}
