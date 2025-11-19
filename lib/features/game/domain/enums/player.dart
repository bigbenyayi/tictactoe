enum Player {
  x,
  o,
  none;

  bool get isX => this == .x;

  bool get isO => this == .o;

  bool get isNone => this == .none;
}
