class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  // JSONからUserオブジェクトを生成するファクトリコンストラクタ
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is String ? int.parse(json['id']) : json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  // UserオブジェクトをJSONに変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
