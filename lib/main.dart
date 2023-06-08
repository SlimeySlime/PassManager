import 'package:flutter/material.dart';
// import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/folder_list.dart';
import 'package:passmanager/screen/modal/add_folder_modal.dart';
import 'package:passmanager/screen/pass_screen.dart';

void main() {
  // 네이티브 코드 사용시, 이벤트 호출로 위젯 바인딩 보장
  // -> 비동기적 이벤트 사용시 바인딩 보장
  WidgetsFlutterBinding.ensureInitialized();
  // PassFolderProvider();
  runApp(const PassManagerApp());
}

class PassManagerApp extends StatefulWidget {
  const PassManagerApp({super.key});

  @override
  State<PassManagerApp> createState() => _PassManagerAppState();
}

class _PassManagerAppState extends State<PassManagerApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassManager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'PassManager'),
      routes: {
        PassScreen.routeName: (context) => PassScreen(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FolderList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: const AddFolderModal(),
          ),
        ),
        tooltip: 'Add Folder',
        child: const Icon(Icons.add),
      ), // T
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return PassScreen();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero; // (0.0, 0.0)
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);
      // return child;
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
