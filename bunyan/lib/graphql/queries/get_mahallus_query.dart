const String getMahallus = r'''
query Mahallus($filters: JSON, $limit: Int, $offset: Int, $orderBy: JSON, $relationsToFilter: JSON) {
  mahallus(filters: $filters, limit: $limit, offset: $offset, orderBy: $orderBy, relationsToFilter: $relationsToFilter) {
    id
    regNo
    name
    place
  }
}
''';
