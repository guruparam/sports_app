import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatefulWidget {
  final String sportName;
  final String tournament;
  final String team1;
  final String team2;
  final String? team1LogoUrl;
  final String? team2LogoUrl;
  final String matchDate;
  final String venue;

  const BuildCard({
    super.key,
    required this.sportName,
    required this.tournament,
    required this.team1,
    required this.team2,
    this.team1LogoUrl,
    this.team2LogoUrl,
    required this.matchDate,
    required this.venue,
  });

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.tournament,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    // color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTeamInfo(widget.team1, widget.team1LogoUrl),
                const Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                _buildTeamInfo(widget.team2, widget.team2LogoUrl),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Schedule: ${widget.matchDate}',
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      widget.venue,
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

Widget _buildTeamInfo(String teamName, String? logoUrl) {
    return Row(
      children: [
        logoUrl != null && logoUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: logoUrl,
                width: 50,
                height: 28,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 50,
                  height: 28,
                  color: const Color.fromARGB(255, 137, 134, 134),
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 50,
                  height: 28,
                  color: const Color.fromARGB(255, 137, 134, 134),
                  child: Icon(Icons.error, color: Colors.white),
                ),
              )
            : Container(
                width: 50,
                height: 28,
                color: const Color.fromARGB(255, 137, 134, 134),
                child: Icon(Icons.image_not_supported, color: Colors.white),
              ),
        const SizedBox(width: 10),
        Text(
          teamName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
