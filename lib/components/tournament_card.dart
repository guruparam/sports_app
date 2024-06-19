import 'package:flutter/material.dart';

class BuildTCard extends StatefulWidget {
  final String TName;
  final String start_date;
  final String? TLogoUrl;
  final String end_date;
  final int? points;

  const BuildTCard({
    super.key,
    required this.TName,
    required this.start_date,
    required this.end_date,
    required this.TLogoUrl,
    this.points,
  });

  @override
  State<BuildTCard> createState() => _BuildTCardState();
}

class _BuildTCardState extends State<BuildTCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 170,
                child: Container(
                  child: Image.asset(
                    'assets/images/t20_2024.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.TName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(
                      'Start date: ${widget.start_date} | End date: ${widget.end_date}',
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Your points: ${widget.points}',
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
