import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu Lateral',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: const Text('Menu inicial'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.done,
              color: Colors.green[800],
            ),
            title: const Text('Concluídas'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.close,
              color: Colors.red[700],
            ),
            title: const Text('Excluídas'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
