import 'package:flutter/widgets.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/widgets/card_cell/card_cell.dart';

class CardCellViewModel {
  final ThronesCard card;

  CardCellViewModel({
    @required this.card,
  }) : assert(card != null);

  String name() {
    return card.name;
  }

  String iconName() {
    return card.iconName();
  }

  String info() {
    switch (card.cardType()) {
      case CardType.plot:
        return 'Income: ${card.income ?? 0}. Initiative: ${card.initiative ?? 0} Claim: ${card.claim ?? 0}';
        break;
      case CardType.character:
        return 'Cost: ${card.cost ?? 0}. STR: ${card.strength ?? 0}';
        break;
      case CardType.attachment:
      case CardType.location:
      case CardType.event:
        return 'Cost: ${card.cost ?? 0}';
        break;
      default:
        return card.packName;
        break;
    }
  }

  String type() {
    return '${card.typeName} - ${card.packName}';
  }
}
