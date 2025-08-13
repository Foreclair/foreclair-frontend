class TextUtils {
  /// Première lettre capitalisée.
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Première lettre de chaque mot capitalisée.
  static String capitalizeEachWord(String text) {
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  static bool isNullOrEmpty(String? text) {
    return text == null || text.isEmpty;
  }
}
