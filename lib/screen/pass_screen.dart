import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PassScreen extends StatelessWidget {
  static const String routeName = '/pass_screen';

  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> folderInfo =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('${folderInfo['name']}'),
      ),
      body: Center(
        child: Text('just passes'),
      ),
    );
  }
}
