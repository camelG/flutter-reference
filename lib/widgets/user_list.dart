import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/user_service.dart';

class UserList extends StatefulWidget {
  final List<User> users;
  final UserService userService;

  const UserList({super.key, required this.users, required this.userService});

  @override
  UserListState createState() => UserListState();
}

class UserListState extends State<UserList> {
  late List<User> _users;

  @override
  void initState() {
    super.initState();
    _users = widget.users;
  }

  Future<dynamic> deleteUser(int id) async {
    try {
      final response = await widget.userService.deleteUser(id);
      if (response == true) {
        setState(() {
          _users.removeWhere((user) => user.id == id);
        });
        print('User deleted: $id');
      } else {
        print('Failed to delete user: $id');
      }
      print(response);
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_users[index].name),
          subtitle: Text(_users[index].email),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteUser(_users[index].id),
              ),
            ],
          ),
        );
      },
    );
  }
}
