import 'package:flutter/material.dart';
import '/models/user.dart';
import '/services/api_service.dart';
import '/services/user_service.dart';
import '/widgets/user_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> futureUsers;
  final UserService userService;
  HomeScreenState() : userService = UserService(apiService: ApiService());

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    try {
      return await userService.fetchUsers();
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load users'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            return UserList(users: snapshot.data!, userService: userService);
          }
        },
      ),
    );
  }
}
