import 'package:flutter/material.dart';
import 'package:passmanager/animation/folderscreen_navigate.dart';
import 'package:passmanager/domain/folder_provider.dart';
// import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/folder_list.dart';
import 'package:passmanager/screen/modal/add_folder_modal.dart';
import 'package:passmanager/screen/pass_screen.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FolderProvider()),
      ],
      child: MaterialApp(
        title: 'PassManager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(title: 'PassManager'),
        routes: {
          PassScreen.routeName: (context) => const PassScreen(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case PassScreen.routeName:
              print('onGenerateRoute, switch to PassScreen.routeName');
              return folderScreenAnimation();
            default:
              return null;
          }
        },
      ),
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
      body: FolderList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => const Dialog(
            child: AddFolderModal(),
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
      return const PassScreen();
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
