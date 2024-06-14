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
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
        if (logoUrl != null)
          Image.network(
            logoUrl,
            width: 50,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              }
            },
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
