List<String> generateDoubleDigits() {
  List<String> numbers = [];
  for (int i = 0; i < 100; i++) {
    String doubleDigit = i.toString().padLeft(2, '0');
    numbers.add(doubleDigit);
  }
  return numbers;
}
