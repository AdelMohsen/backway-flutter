class Country {
  final String code;
  final String dialCode;
  final String name;

  Country({required this.code, required this.dialCode, required this.name});

  String get flagEmoji {
    if (code.length != 2) return '🌐';
    final int firstLetter = code.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = code.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  static Country parse(String code) {
    // Basic implementation for now, expandable
    if (code == 'SA' || code == '+966') {
      return Country(code: 'SA', dialCode: '+966', name: 'Saudi Arabia');
    }
    // Default fallback
    return Country(code: 'SA', dialCode: '+966', name: 'Saudi Arabia');
  }
}
