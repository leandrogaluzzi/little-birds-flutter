class DeckSlot {
  DeckSlot({
    this.code,
    this.quantity,
  })  : assert(code != null),
        assert(quantity != null);

  final String code;
  final int quantity;
}
