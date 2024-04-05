import 'package:flutter/material.dart';
// import 'package:linkup/auth/auth_service.dart';
import 'package:linkup/components/my_drawer.dart';
import 'package:linkup/pages/chat_page.dart';
import 'package:linkup/services/auth/auth_service.dart';
import 'package:linkup/services/chat/chat_service.dart';

import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current user (logged in user)
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError){
            return const Text("Error");
          }

          // loading..
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          // return list view
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
          );
        },
    );
  }
  // build individual list tile for user
  Widget _buildUserListItem(Map<String,dynamic> userData, BuildContext context){
    // return all users except current user
      if (userData["email"] != _authService.getCurrentUser()!.email ){
        return UserTile(
          text: userData["email"],
          onTap: (){
            // tap on user and go to chat page
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverEmail: userData["email"],
                    receiverID: userData['uid'],
                  ),
                )
            );
          },
        );
      } else {
        return Container();
      }
}
}