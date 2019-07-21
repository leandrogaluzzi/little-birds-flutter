import 'package:little_birds/model/type.dart';
import 'package:little_birds/model/thrones_card.dart';

class CardScreenViewModel {
  CardScreenViewModel({
    this.card,
  }) : assert(card != null);

  final ThronesCard card;

  String details() {
    switch (card.cardType()) {
      case Type.plot:
        return '${card.typeName}. Income: ${card.income ?? 0}. Initiative: ${card.initiative ?? 0} Claim: ${card.claim ?? 0}. Reserve: ${card.reserve ?? 0}. Plot deck limit: ${card.deckLimit ?? 0}.';
        break;
      case Type.character:
        return '${card.typeName}. Cost: ${card.cost ?? 0}. STR: ${card.strength ?? 0}';
        break;
      case Type.attachment:
      case Type.location:
      case Type.event:
        return '${card.typeName}. Cost: ${card.cost ?? 0}';
        break;
      default:
        return card.typeName;
        break;
    }
  }

  String pack() {
    String packNumber = '#${card.code.substring(card.code.length - 2)}';
    return '${card.packName} $packNumber';
  }

}
