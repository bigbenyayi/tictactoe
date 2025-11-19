enum GameMode {
  normal,
  blitz;

  bool get isNormal => this == .normal;

  bool get isBlitz => this == .blitz;
}
