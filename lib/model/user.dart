class User {
  final int id;
  final String name;
  final String nickName;
  String? deptName;
  // final String date;
  User({required this.id, required this.name, required this.nickName});

  factory User.fromMap(Map<String, dynamic> map) {
    var user = User(id: map['user_id'], name: map['user_name'], nickName: map['nick_name']);
    user.deptName = map['dept_name'];
    return user;
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nickName': nickName,
      'deptName' : deptName
    };
  }
}