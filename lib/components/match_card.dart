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
          Image.network(
          logoUrl!,
          // 'https://img.freepik.com/free-vector/white-abstract-background-design_23-2148825582.jpg?w=996&t=st=1718347476~exp=1718348076~hmac=5fc499b091d5b9ae465d402374f7a353bb9141d2e1e06b4d70561f7c8ffe71e9',
            width: 50,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Container(
                width: 45,
                height: 30,
                color: const Color.fromARGB(255, 137, 134, 134),
                );
              }
            },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Container(
              width: 45,
              height: 30,
              color: const Color.fromARGB(255, 200, 200, 200),
            );
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
