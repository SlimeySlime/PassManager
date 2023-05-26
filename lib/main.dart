import 'package:flutter/material.dart';
// import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/folder_list.dart';
import 'package:passmanager/screen/modal/add_folder_modal.dart';

void main() {
  // 네이티브 코드 사용시, 이벤트 호출로 위젯 바인딩 보장
  // -> 비동기적 이벤트 사용시 바인딩 보장
  WidgetsFlutterBinding.ensureInitialized();
  // PassFolderProvider();
  runApp(const PassManagerApp());
}

class PassManagerApp extends StatelessWidget {
  const PassManagerApp({super.key});

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
          builder: (context) {
            return AddFolderModal();
          },
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
