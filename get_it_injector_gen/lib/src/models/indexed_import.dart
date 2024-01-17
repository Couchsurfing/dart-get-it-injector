class IndexedImport {
  const IndexedImport({
    required this.import,
    required this.index,
  });

  final String import;
  final int index;

  String get namespace => 'i$index';
}
