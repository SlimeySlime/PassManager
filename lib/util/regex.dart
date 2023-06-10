String getFromBracket(String text) {
  RegExp exp = RegExp(r'U[^)]+');
  String icoHex = exp.firstMatch(text)![0]!;
  return icoHex;
}
