import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PassScreen extends StatelessWidget {
  static const String routeName = '/pass_screen';

  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('폴더'),
      ),
      body: Center(
        child: Text('just passes'),
      ),
    );
  }
}
