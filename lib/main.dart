import 'package:flutter/material.dart';
import 'admin_settings_page.dart';

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

class _MainPageState extends State<MainPage> {
  final List<String> topCategories = [
    '총학생회',
    '경영대',
    '공과대',
    '인사대',
    '인융대',
    '자연대',
    '정법대',
    '전정대',
  ];

  final List<String> bottomFilters = ['음식점', '주점', '기타'];
  final List<String> sortOptions = ['거리순', '장소명순', '최신순'];

  List<String> selectedTopCategories = ['총학생회'];
  List<String> selectedBottomFilters = ['음식점'];
  String selectedSort = '거리순';

  @override
  Widget build(BuildContext context) {
    // 생략된 내용은 그대로 두고 build() 안의 Stack 위젯 부분부터만 변경합니다:

    return Scaffold(
      body: Stack(
        children: [
          const MapWidget(),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.25,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
                  children: [
                    // 상단 카테고리
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: topCategories.map((category) {
                          final isSelected = selectedTopCategories.contains(category);
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(category),
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                              selectedColor: Colors.black,
                              backgroundColor: Colors.grey.shade200,
                              selected: isSelected,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              onSelected: (selected) {
                                setState(() {
                                  if (isSelected && selectedTopCategories.length == 1) return;
                                  isSelected
                                      ? selectedTopCategories.remove(category)
                                      : selectedTopCategories.add(category);
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedSort,
                          onChanged: (value) {
                            setState(() {
                              selectedSort = value!;
                            });
                          },
                          items: sortOptions.map((option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            children: bottomFilters.map((filter) {
                              final isSelected = selectedBottomFilters.contains(filter);
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: ChoiceChip(
                                    label: Center(
                                      child: Text(
                                        filter,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                    selectedColor: Colors.black,
                                    backgroundColor: Colors.grey.shade200,
                                    selected: isSelected,
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    onSelected: (selected) {
                                      setState(() {
                                        if (isSelected &&
                                            selectedBottomFilters.length == 1) return;
                                        isSelected
                                            ? selectedBottomFilters.remove(filter)
                                            : selectedBottomFilters.add(filter);
                                      });
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(
                      10,
                          (index) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(
                            '${selectedTopCategories.join(', ')} / '
                                '${selectedBottomFilters.join(', ')} ${index + 1}번 장소',
                          ),
                          subtitle: Text('정렬: $selectedSort'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  bool isPopupVisible = false;

  void togglePopup() {
    setState(() {
      isPopupVisible = !isPopupVisible;
    });
  }

  void goToAdminSettings() {
    setState(() {
      isPopupVisible = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminSettingsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: const Center(
            child: Text("MapWidget", style: TextStyle(color: Colors.white)),
          ),
        ),
        Positioned(
          top: 32,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: togglePopup,
              ),
              if (isPopupVisible)
                GestureDetector(
                  onTap: goToAdminSettings,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade700,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      '관리자 설정',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
