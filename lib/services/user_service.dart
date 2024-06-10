import 'package:my_app/models/user.dart';
import 'api_service.dart';

class UserService {
  final ApiService apiService;

  UserService({required this.apiService});

  Future<List<User>> fetchUsers() async {
    final data = await apiService.get('/users');
    return data.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<User> updateUser(int id, Map<String, dynamic> data) async {
    final response = await apiService.put('/users/$id', data);
    return User.fromJson(response);
  }

  Future<dynamic> deleteUser(int id) async {
    final response = await apiService.delete('/users/$id');
    return response;
  }
}
