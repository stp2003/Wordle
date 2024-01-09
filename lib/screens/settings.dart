import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/controllers/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: _isSwitched,
            onChanged: (value) {
              setState(() {
                _isSwitched = value;
              });
              Provider.of<ThemeProvider>(context, listen: false).setTheme(
                turnOn: _isSwitched,
              );
            },
          ),
        ],
      ),
    );
  }
}
