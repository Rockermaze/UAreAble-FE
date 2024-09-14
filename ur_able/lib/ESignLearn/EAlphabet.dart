class EAlphabet {
  final String alphabet; // The letter (A-Z)
  final String imagePath; // Path to the image of the sign
  int tries; // Number of tries performed
  bool isLearned; // Indicates if the sign has been learned

  EAlphabet({
    required this.alphabet,
    required this.imagePath,
    this.tries = 0,
    this.isLearned = false,
  });

  // Method to increment tries and check if the sign is learned
  void incrementTries() {
    if (tries < 10) {
      tries++;
      if (tries >= 10) {
        isLearned = true;
      }
    }
  }

  // Method to reset tries
  void resetTries() {
    tries = 0;
    isLearned = false;
  }
}
