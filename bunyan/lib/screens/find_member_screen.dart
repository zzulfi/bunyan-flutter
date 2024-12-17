import 'package:flutter/material.dart';
import 'package:bunyan/services/graphql_service.dart';
import 'package:bunyan/graphql/mutation/find_member_by_phone.dart';

class FindMemberScreen extends StatefulWidget {
  const FindMemberScreen({super.key});

  @override
  State<FindMemberScreen> createState() => _FindMemberScreenState();
}

class _FindMemberScreenState extends State<FindMemberScreen> {
  final GraphQLService _graphqlService = GraphQLService(baseUrl: 'https://fmjb82nl-8000.inc1.devtunnels.ms/graphql');
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;
  String? _memberName;
  String? _errorMessage;

  Future<void> _checkPhoneNumber() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a phone number.';
        _memberName = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _memberName = null;
    });

    try {
      final data = await _graphqlService.postRequest(
        query: findMemberByPhone,
        variables: {'phone': phone},
      );

      if (data['findMemberByPhone'] != null) {
        setState(() {
          _memberName = data['findMemberByPhone']['name'];
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = 'No member found with this phone number.';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Member by Phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Phone Number:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _checkPhoneNumber,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Check'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (_memberName != null)
              Text(
                'Member Name: $_memberName',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
