import 'package:little_birds/model/thrones_pack.dart';
import 'package:test/test.dart';
import '../../mocks/mock_thrones.dart';

void main() {
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
