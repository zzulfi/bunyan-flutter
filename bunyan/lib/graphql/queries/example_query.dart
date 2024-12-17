const String getExampleDataQuery = r'''
query Districts{
  districts {
    id
    name
  }
}
''';

const String createExampleMutation = r'''
mutation CreateExample($name: String!, $description: String!) {
  createExample(name: $name, description: $description) {
    id
    name
    description
  }
}
''';
