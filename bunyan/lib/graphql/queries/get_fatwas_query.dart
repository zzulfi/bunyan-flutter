const String getFatwas = r'''
query Fatwas($filters: JSON, $limit: Int, $offset: Int, $orderBy: JSON, $relationsToFilter: JSON) {
  fatwas(filters: $filters, limit: $limit, offset: $offset, orderBy: $orderBy, relationsToFilter: $relationsToFilter) {
    id
    question
    answer
    askedAt
  }
}
''';
