import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:test/test.dart';
import '../../mocks/mock_thrones.dart';

void main() {
  test('Test cards', () async {
    final thrones = MockThrones();
    final List<ThronesCard> cards = await thrones.getCards();
    expect(cards.length, 9);
    expect(cards[0].name, 'The Red Viper');
    expect(cards[1].name, 'Tears of Lys');
    expect(cards[2].name, 'Tywin Lannister');
    expect(cards[3].name, 'The Queen of Thorns');
    expect(cards[4].name, 'Balon Greyjoy');
    expect(cards[5].name, 'Daenerys Targaryen');
    expect(cards[6].name, 'Robert Baratheon');
    expect(cards[7].name, 'Eddard Stark');
    expect(cards[8].name, 'The Wall');
  });

  test('Test packs', () async {
    final thrones = MockThrones();
    final List<ThronesPack> packs = await thrones.getPacks();
    expect(packs.length, 6);
    expect(packs[0].name, 'Core Set');
    expect(packs[1].name, 'Taking the Black');
    expect(packs[2].name, 'The Road to Winterfell');
    expect(packs[3].name, 'The King\'s Peace');
    expect(packs[4].name, 'No Middle Ground');
    expect(packs[5].name, 'Wolves of the North');
  });
  test('Test packs', () async {
    final thrones = MockThrones();
    final List<ThronesPack> packs = await thrones.getPacks();
    expect(packs.length, 6);
    expect(packs[0].name, 'Core Set');
    expect(packs[1].name, 'Taking the Black');
    expect(packs[2].name, 'The Road to Winterfell');
    expect(packs[3].name, 'The King\'s Peace');
    expect(packs[4].name, 'No Middle Ground');
    expect(packs[5].name, 'Wolves of the North');
  });
}
