import 'package:flutter/material.dart';

import 'constants.dart';
import 'alertdialog.dart';

class PredicateItem {
  final ListTile tile;
  final TextEditingController keyController;
  final TextEditingController valueController;

  PredicateItem(this.tile, this.keyController, this.valueController);
}

class PredicateList extends StatefulWidget {
  @override
  _PredicateListState createState() => _PredicateListState();
}

class _PredicateListState extends State<PredicateList> {
  // Storing all the text fields for each row.
  final _pairs = Map<int, PredicateItem>();
  // Stores the keys for each row to make sure there aren't any duplicates.
  final _keys = Set<String>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text('Quirk Node Inserter'),
      ),
      body: _buildPredicateList(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Add'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.clear_all),
              title: Text('Clear All')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rotate_right),
            title: Text('Execute'),
          ),
        ],
        onTap: _onBottomNavTap,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blueGrey[800],
      ),
    );
  }

  void _onBottomNavTap(int index) async {
    switch(index) {
      case 0:
        _addPredicateKeyPair();
        break;
      case 1:
        final ConfirmAction action = await asyncConfirmDialog(context,
            'Reset key values?', 'This will delete all existing key values.');
        if (action == ConfirmAction.ACCEPT) {
          setState(() {
            _pairs.clear();
          });
        }
        break;
      case 2:
        final ConfirmAction action = await asyncConfirmDialog(context,
            'Execute transaction?', 'This will execute the node insertion.');
        if (action == ConfirmAction.ACCEPT) {
          setState(() {
            _pairs.clear();
          });
        }
        break;
    }
  }

  Widget _buildPredicateList() {
    // Create a List of ListTiles so then we can display them in Flutter.
    final newPairs = <ListTile>[];
    // Loop through the map of pairs and fill the list with its values.
    _pairs.forEach((key, val) {
      newPairs.add(val.tile);
    });

    return Column(
      children: <Widget>[
        ListTile(
          title: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintMaxLines: 1,
              hintText: 'Name',
            ),
          ),
        ),
        Divider(),
        ListView(
          shrinkWrap: true,
          children: newPairs,
        ),
      ],
    );
  }

  void _addPredicateKeyPair() {
    setState(() {
      final keyController = TextEditingController();
      final valueController = TextEditingController();

      int localIndex = 0;
      // Ensure that this key doesn't already exist in the map.
      while (_pairs.containsKey(localIndex)) {
        localIndex++;
      }

      final item = ListTile(
        trailing: IconButton(
          onPressed: () =>_removePredicateKeyPair(localIndex),
          icon: Icon(Icons.clear),
        ),
        title: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: keyController,
                decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  hintMaxLines: 1,
                  hintText: 'Key',
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: valueController,
                decoration: InputDecoration(
                  icon: Icon(Icons.attach_file),
                  hintMaxLines: 1,
                  hintText: 'Value',
                ),
              ),
            ),
          ],
        ),
      );

      // Add a predicate item to the map containing the controllers for
      // each text field and the ListTile itself.
      _pairs[localIndex] = PredicateItem(item, keyController, valueController);
    });
  }

  void _removePredicateKeyPair(int index) {
    setState(() {
      _pairs.remove(index);
    });
  }
}