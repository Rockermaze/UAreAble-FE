class GAlphabet {
  final String alphabet;
  int tries;
  bool isLearned;

  GAlphabet({
    required this.alphabet,
    this.tries = 0,
    this.isLearned = false,
  });
}
