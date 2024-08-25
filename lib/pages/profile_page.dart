import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  String? _userName;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    Map<String, dynamic>? userData = await _authService.getUserData();

    if (userData != null && mounted) {
      setState(() {
        _userName = userData['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi! $_userName"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Image(
                image: AssetImage("assets/images/person.png"),
              ),
            ),
            Text(_userName ?? 'Loading...',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text(_authService.getCurrentUser()?.email ?? 'No email'),
          ],
        ),
      ),
    );
  }
}
