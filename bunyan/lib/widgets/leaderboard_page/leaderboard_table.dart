import 'package:flutter/material.dart';

class LeaderboardTable extends StatelessWidget {
  final List<Map<String, dynamic>> rows;

  const LeaderboardTable({
    super.key,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromRGBO(200, 200, 200, 1),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTableHeader(),
          _buildTableContents(rows),
        ],
      ),
    );
  }


  /// Table Header
  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        border: Border.all(
          color: const Color.fromRGBO(200, 200, 200, 1),
          width: 0.5,
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Rank',
              style: TextStyle(
                fontSize: 12,
                 fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Name',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Points',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
               fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Table Contents
  Widget _buildTableContents(List<Map<String, dynamic>> rows) {
    return Column(
      children: rows
          .map((row) => _buildTableRow(
                rank: row['rank'],
                name: row['name'],
                points: row['points'],
                imageUrl: row['imageUrl'],
              ))
          .toList(),
    );
  }

  /// Individual Row
  Widget _buildTableRow({
    required String rank,
    required String name,
    required int points,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(200, 200, 200, 1),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Rank Column
          Expanded(
            flex: 1,
            child: Text(
              rank,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                 fontFamily: 'Inter',
                color: Colors.black,
              ),
            ),
          ),

          // Name Column with Image
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                     fontFamily: 'Inter',
                color: Color.fromRGBO(50, 50, 50, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Points Column
          Expanded(
            flex: 1,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$points',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                       fontFamily: "Inter",
                    ),
                  ),
                  const TextSpan(
                    text: ' pts',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color.fromRGBO(200, 200, 200, 1),
                      fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
