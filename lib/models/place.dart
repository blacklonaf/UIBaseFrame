class Place {
  final String name;
  final String category;
  final String address;
  final String? imageUrl;
  final String benefitTitle;
  final String benefitSub;
  final String restriction;
  final String restrictionSub;
  final bool isOpen;
  final String expireDate;
  final double latitude;
  final double longitude;

  Place({
    required this.name,
    required this.category,
    required this.address,
    this.imageUrl,
    required this.benefitTitle,
    required this.benefitSub,
    required this.restriction,
    required this.restrictionSub,
    required this.isOpen,
    required this.expireDate,
    required this.latitude,
    required this.longitude,
  });
}
