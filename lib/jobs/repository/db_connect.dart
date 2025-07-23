class DatabaseConnection {
  static final DatabaseConnection _instance = DatabaseConnection._internal();
  factory DatabaseConnection() => _instance;
  DatabaseConnection._internal();

  final Map<String, String> _userList = {
    'admin': 'admin',
    'user1': 'user1234',
    'user2': 'user1234',
    'user3': 'user1234',
  };

  bool login(String id, String password) {
    return _userList.containsKey(id) && _userList[id] == password;
  }

  bool register(String id, String password) {
    // 'User already exists!
    if (_userList.containsKey(id)) {
      return false;
    } else {
      _userList[id] = password;
      // User registered successfully!
      return true;
    }
  }

  bool userExists(String id) {
    return _userList.containsKey(id);
  }
}
