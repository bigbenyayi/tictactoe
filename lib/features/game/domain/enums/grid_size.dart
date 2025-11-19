enum GridSize {
  normal,
  large,
  huge;

  int get dimension {
    switch (this) {
      case .normal:
        return 3;
      case .large:
        return 5;
      case .huge:
        return 6;
    }
  }

  int get winLength {
    switch (this) {
      case GridSize.normal:
        return 3;
      case .large: // Fallthrough
      case .huge:
        return 4;
    }
  }
}
