class AuthManager {
  static const String apiKey = "";
  static const int ok = 0;
  static const int errNoExist = 1;
  static const int errWrongPass = 2;
  static const int errPassMissMatch = 3;
  static const int errUserExist = 4;
  static const int errEmailExist = 5;


  static int login() {
    return ok;
  }

  static int register () {
    return ok;
  }
}