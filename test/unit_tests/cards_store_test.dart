import 'dart:convert';
import 'dart:io';
import 'package:little_birds/core/cards_store.dart';
import 'package:little_birds/model/slot.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:test/test.dart';

void main() {
  group('Cards Store', () {
    CardsStore cardsStore;

    setUpAll(() async {
      final file = new File('test/jsons/cards.json');
      final List<dynamic> jsonMap = json.decode(await file.readAsString());
      final List<ThronesCard> cards =
          jsonMap.map((item) => ThronesCard.fromJson(item)).toList();
      cardsStore = CardsStore(cards: cards);
    });

    test('Test get cards alphabetically', () {
      final cards = cardsStore.getCardsAlphabetically();
      expect(cards.length, 11);
      expect(cards[0].name, 'Balon Greyjoy');
      expect(cards[1].name, 'Daenerys Targaryen');
      expect(cards[2].name, 'Eddard Stark');
      expect(cards[3].name, 'Robert Baratheon');
      expect(cards[4].name, 'Tears of Lys');
      expect(cards[5].name, 'The Queen of Thorns');
      expect(cards[6].name, 'The Red Viper');
      expect(cards[7].name, 'The Red Wedding');
      expect(cards[8].name, 'The Wall');
      expect(cards[9].name, 'Tywin Lannister');
      expect(cards[10].name, 'Walder Frey');
    });

    test('Test get cards with pack code', () {
      final cards = cardsStore.getCardsWithPackCode('TRW');
      expect(cards.length, 2);
      expect(cards[0].name, 'The Red Wedding');
      expect(cards[1].name, 'Walder Frey');
    });

    test('Test get cards with query', () {
      final cards = cardsStore.getCardsWithQuery('tar');
      expect(cards.length, 2);
      expect(cards[0].name, 'Daenerys Targaryen');
      expect(cards[1].name, 'Eddard Stark');
    });

    test('Test get cards with codes', () {
      final List<Slot> slots = [
        Slot(code: '01044', quantity: 3),
        Slot(code: '01137', quantity: 2),
        Slot(code: '01186', quantity: 1),
      ];
      final cardsQuantity = cardsStore.getCardsQuantityFromSlots(slots);
      expect(cardsQuantity.length, 3);
      expect(cardsQuantity[0].card.name, 'Tears of Lys');
      expect(cardsQuantity[0].quantity, 3);
      expect(cardsQuantity[1].card.name, 'The Wall');
      expect(cardsQuantity[1].quantity, 2);
      expect(cardsQuantity[2].card.name, 'The Queen of Thorns');
      expect(cardsQuantity[2].quantity, 1);
    });
  });
}
