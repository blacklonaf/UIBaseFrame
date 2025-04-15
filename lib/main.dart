import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController topTabController;
  late TabController bottomTabController;

  final List<String> topTabs = ['총학생회', '인융대', '전정대', '공대'];
  final List<String> bottomTabs = ['음식점', '주점', '기타'];

  int topIndex = 0;
  int bottomIndex = 0;

  @override
  void initState() {
    super.initState();
    topTabController = TabController(length: topTabs.length, vsync: this);
    bottomTabController = TabController(length: bottomTabs.length, vsync: this);

    // 리스너에 탭 이동 후 완전히 반영되었을 때 index 수동 반영
    topTabController.addListener(() {
      if (topTabController.indexIsChanging == false &&
          topIndex != topTabController.index) {
        setState(() {
          topIndex = topTabController.index;
        });
      }
    });

    bottomTabController.addListener(() {
      if (bottomTabController.indexIsChanging == false &&
          bottomIndex != bottomTabController.index) {
        setState(() {
          bottomIndex = bottomTabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    topTabController.dispose();
    bottomTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 6,
            child: Container(
              width: double.infinity,
              color: Colors.blue,
              child: const Center(child: Text("MapWidget1")),
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              children: [
                TabBar(
                  controller: topTabController,
                  indicatorWeight: 3,
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: topTabs.map((e) => Tab(text: e)).toList(),
                ),
                TabBar(
                  controller: bottomTabController,
                  indicatorWeight: 3,
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: bottomTabs.map((e) => Tab(text: e)).toList(),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '${topTabs[topIndex]} - ${bottomTabs[bottomIndex]} 반응형 리스트',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
