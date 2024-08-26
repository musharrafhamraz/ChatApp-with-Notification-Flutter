import 'package:chat_app/components/custom_drawer.dart';
import 'package:chat_app/components/custom_usertile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat_services/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var appBarHeight = AppBar().preferredSize.height;
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beep"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          PopupMenuButton(
            offset: Offset(0.0, appBarHeight),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            itemBuilder: (context) => [
              _buildPopupMenuItem(
                title: 'Profile',
                iconData: Icons.person,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ],
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Handle errors
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Show loading indicator while waiting for data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Please Wait.."),
            ],
          );
        }

        // Display the list of users
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    String currentUserEmail = _authService.getCurrentUser()!.email!;
    String currentUserId = _authService.getCurrentUser()!.uid;

    if (userData["email"] != currentUserEmail) {
      String otherUserId = userData['uid'];
      return FutureBuilder<String>(
        future: _chatService.getLastMessage(currentUserId, otherUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Loading..."),
              ],
            );
          }

          String lastMessage = snapshot.data ?? "No messages yet";

          return UserTile(
            text: userData['name'],
            lastMessage: lastMessage,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    recieverEmail: userData["name"],
                    recieverID: userData['uid'],
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      return Container();
    }
  }

  PopupMenuItem _buildPopupMenuItem(
      {required String title,
      required IconData iconData,
      required void Function() onTap}) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        children: [
          Icon(iconData, color: Colors.black),
          const SizedBox(width: 16), // Adds space between icon and text
          Text(title),
        ],
      ),
    );
  }
}
