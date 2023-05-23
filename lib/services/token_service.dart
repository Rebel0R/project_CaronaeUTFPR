import 'dart:math';

class Token {
  static String generateToken() {
    final random = Random();
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    String token = '';
    for (int i = 0; i < 10; i++) {
      int randomIndex = random.nextInt(characters.length);
      token += characters[randomIndex];
    }

    return token;
  }
}
