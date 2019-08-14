import 'package:little_birds/model/thrones_card.dart';

class CardQuantity {
  CardQuantity({
    this.card,
    this.quantity,
  })  : assert(card != null),
        assert(quantity != null);

  final ThronesCard card;
  final int quantity;
}
