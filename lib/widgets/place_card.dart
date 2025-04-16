import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String name;
  final String category;
  final String address;
  final String? imageUrl;

  final String benefitTitle;
  final String benefitSub;
  final String restriction;
  final String restrictionSub;

  final String statusText;
  final Color statusColor;

  final String expireDate;

  const PlaceCard({
    super.key,
    required this.name,
    required this.category,
    required this.address,
    required this.benefitTitle,
    required this.benefitSub,
    required this.restriction,
    required this.restrictionSub,
    required this.statusText,
    required this.statusColor,
    required this.expireDate,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 왼쪽 정보
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 10, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageUrl != null
                      ? Image.network(imageUrl!, height: 100, width: double.infinity, fit: BoxFit.cover)
                      : Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // 오른쪽 혜택 정보
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Text(
                    expireDate,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.verified, color: Color(0xFFB00020), size: 16),
                          SizedBox(width: 4),
                          Text(
                            '광운대점 한정',
                            style: TextStyle(
                              color: Color(0xFFB00020),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        benefitTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        benefitSub,
                        style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 6),
                      Text(
                        restriction,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        restrictionSub,
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
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
