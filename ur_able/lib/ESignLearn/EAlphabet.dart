class EAlphabet {
  final String alphabet;
  final String imagePath;
  int tries;
  bool isLearned;

  EAlphabet({
    required this.alphabet,
    required this.imagePath,
    this.tries = 0,
    this.isLearned = false,
  });
}
