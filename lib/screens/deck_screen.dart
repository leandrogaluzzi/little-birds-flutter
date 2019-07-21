import 'package:flutter/material.dart';
import 'package:little_birds/view_models/deck_screen_view_model.dart';
import 'package:little_birds/widgets/deck_header.dart';
import 'package:little_birds/widgets/deck_section_header.dart';

class DeckScreen extends StatelessWidget {
  DeckScreen({
    Key key,
    @required this.viewModel,
  })  : assert(viewModel != null),
        super(key: key);

  final DeckScreenViewModel viewModel;

  Widget _header(){
    return DeckHeader();
  }

  Widget _sectionHeader() {
    return DeckSectionHeader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _header(),
          _sectionHeader(),
        ],
      ),
    );
  }
}
