class User {
  final int id;
  final String name;
  final String nickName;
  User({required this.id, required this.name, required this.nickName});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['user_id'], name: map['user_name'], nickName: map['nick_name']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nickName': nickName
    };
  }
}