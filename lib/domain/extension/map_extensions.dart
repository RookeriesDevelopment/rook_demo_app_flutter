extension MapExtensions on Map {
  List<T> mapToList<T, K, V>(T Function(MapEntry<K, V>) transform) {
    final List<T> list = [];

    forEach((key, value) {
      list.add(transform(MapEntry(key, value)));
    });

    return list;
  }
}
