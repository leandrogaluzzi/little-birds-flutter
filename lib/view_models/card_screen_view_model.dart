import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/thrones_card.dart';

class CardScreenViewModel {
  CardScreenViewModel({
    this.card,
  }) : assert(card != null);

  final ThronesCard card;

  String getInfoString() {
    switch (card.cardType()) {
      case CardType.plot:
        return '${card.typeName}. Income: ${card.income ?? 0}. Initiative: ${card.initiative ?? 0} Claim: ${card.claim ?? 0}. Reserve: ${card.reserve ?? 0}. Plot deck limit: ${card.deckLimit ?? 0}.';
        break;
      case CardType.character:
        return '${card.typeName}. Cost: ${card.cost ?? 0}. STR: ${card.strength ?? 0}';
        break;
      case CardType.attachment:
      case CardType.location:
      case CardType.event:
        return '${card.typeName}. Cost: ${card.cost ?? 0}';
        break;
      default:
        return card.typeName;
        break;
    }
  }

  String getPackString() {
    return '${card.packName} #${card.code.substring(card.code.length - 2)}';
  }

}
