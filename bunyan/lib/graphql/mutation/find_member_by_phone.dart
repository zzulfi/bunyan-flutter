const String findMemberByPhone = r'''
mutation FindMemberByPhone($phone: String!) {
  findMemberByPhone(phone: $phone) {
    id
    name
  }
}
''';