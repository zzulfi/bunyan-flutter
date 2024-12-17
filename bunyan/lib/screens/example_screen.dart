import 'package:flutter/material.dart';
import 'package:bunyan/services/graphql_service.dart';
import 'package:bunyan/graphql/queries/example_query.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final GraphQLService _graphqlService = GraphQLService(
      baseUrl: 'https://fmjb82nl-8000.inc1.devtunnels.ms/graphql');
  bool isLoading = false;
  String? errorMessage;
  List<dynamic>? data;

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await _graphqlService.postRequest(
        query: getExampleDataQuery,
      );
      print(result['districts']); // Log the districts
      setState(() {
        data =
            result['districts'] as List<dynamic>; // Assign the list to `data`
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GraphQL Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: fetchData,
              child: const Text('Fetch Data'),
            ),
            if (isLoading) const CircularProgressIndicator(),
            if (errorMessage != null) Text('Error: $errorMessage'),
            if (data != null)
              Expanded(
                child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final district = data![index];
                    return ListTile(
                      title: Text('Name: ${district['name']}'),
                      subtitle: Text('ID: ${district['id']}'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
