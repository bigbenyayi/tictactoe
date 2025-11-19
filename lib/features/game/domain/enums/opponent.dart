enum Opponent {
  friend,
  bot;

  bool get isBot => this == .bot;

  bool get isFriend => this == .friend;
}
