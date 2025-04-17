import 'package:flutter/material.dart';
import 'admin_settings_page.dart';
import 'models/place.dart';
import 'dummy_data.dart';
import 'widgets/place_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
  final GlobalKey<_MapWidgetState> _mapKey = GlobalKey<_MapWidgetState>();
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
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(key: _mapKey),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.25,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              final filtered = dummyPlaces.where((place) {
                return selectedTopCategories.any((cat) => place.category.contains(cat)) &&
                    selectedBottomFilters.any((type) => place.category.contains(type));
              }).toList();
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: FilterHeaderDelegate(
                        topCategories: topCategories,
                        bottomFilters: bottomFilters,
                        sortOptions: sortOptions,
                        selectedTopCategories: selectedTopCategories,
                        selectedBottomFilters: selectedBottomFilters,
                        selectedSort: selectedSort,
                        onTopCategoryTap: (category) {
                          setState(() {
                            if (selectedTopCategories.contains(category)) {
                              if (selectedTopCategories.length == 1) return;
                              selectedTopCategories.remove(category);
                            } else {
                              selectedTopCategories.add(category);
                            }
                          });
                        },
                        onBottomFilterTap: (filter) {
                          setState(() {
                            if (selectedBottomFilters.contains(filter)) {
                              if (selectedBottomFilters.length == 1) return;
                              selectedBottomFilters.remove(filter);
                            } else {
                              selectedBottomFilters.add(filter);
                            }
                          });
                        },
                        onSortChange: (value) {
                          setState(() {
                            selectedSort = value!;
                          });
                        },
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final place = filtered[index];
                              return GestureDetector(
                                onTap: () {
                                  _mapKey.currentState?.moveCameraTo(
                                    LatLng(place.latitude, place.longitude),
                                  );
                                },
                                child: PlaceCard(
                                  name: place.name,
                                  category: place.category,
                                  address: place.address,
                                  imageUrl: place.imageUrl,
                                  benefitTitle: place.benefitTitle,
                                  benefitSub: place.benefitSub,
                                  restriction: place.restriction,
                                  restrictionSub: place.restrictionSub,
                                  statusText: place.isOpen ? '영업 중' : '영업 종료',
                                  statusColor: place.isOpen ? Colors.greenAccent : Colors.redAccent,
                                  expireDate: place.expireDate,
                                ),
                              );
                            },
                        childCount: filtered.length,
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
  const MapWidget({super.key}); // ⛔ mapKey 제거

  @override
  State<MapWidget> createState() => _MapWidgetState();
}


class _MapWidgetState extends State<MapWidget> {
  bool isPopupVisible = false;
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(37.623569, 123.061899);

  Set<Marker> get markers => dummyPlaces.map((place) {
    return Marker(
      markerId: MarkerId(place.name),
      position: LatLng(place.latitude, place.longitude),
      infoWindow: InfoWindow(title: place.name),
    );
  }).toSet();

  void moveCameraTo(LatLng target) {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(target, 17),
    );
  }

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
        GoogleMap(
          onMapCreated: (controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 16,
          ),
          markers: markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
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

class FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> topCategories;
  final List<String> bottomFilters;
  final List<String> sortOptions;
  final List<String> selectedTopCategories;
  final List<String> selectedBottomFilters;
  final String selectedSort;
  final void Function(String) onTopCategoryTap;
  final void Function(String) onBottomFilterTap;
  final void Function(String?) onSortChange;

  FilterHeaderDelegate({
    required this.topCategories,
    required this.bottomFilters,
    required this.sortOptions,
    required this.selectedTopCategories,
    required this.selectedBottomFilters,
    required this.selectedSort,
    required this.onTopCategoryTap,
    required this.onBottomFilterTap,
    required this.onSortChange,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    onSelected: (_) => onTopCategoryTap(category),
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
                onChanged: onSortChange,
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
                          onSelected: (_) => onBottomFilterTap(filter),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 130;

  @override
  double get minExtent => 130;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
