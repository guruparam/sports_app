import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  final terms = const [
    'Coins ➜ Units to spend for playing matches.',
    'Points ➜ Units indicating your earnings by playing the matches. The rankings will be decided based on the points.',
  ];

  final rules = const [
    {
      'content': 'Each user will be allotted with 5000 coins for each tournament.',
    },
    {
      'content': 'Matches scheduled for the next 3 days are considered active matches. You can start playing any active matches.',
    },
    {
      'content': 'To play an active match, you have to:',
      'subContent': [
        'Predict the winner.',
        'Select coins (Allowed per match: 100 to 1000).',
        'If your tournament coins are less than 1000, your coins value becomes the maximum. Eg: Assume a user has 500 tournament coins, the user will be allowed to select between 100 and 500.',
      ],
    },
    {
      'content': 'Each match will have 3 optional questions. Each correct prediction will earn you an extra 500 points per question.',
    },
    {
      'content': 'If both mandatory and optional questions are correct, the user will get 2000 extra points.',
    },
    {
      'content': 'For playing daily, you will earn 100 extra coins.',
    },
    {
      'content': 'Group points are calculated based on the average points of the total users in the group.',
    },
    {
      'content': 'If the match is cancelled, the user will get their bidding amount returned.',
    },
    {
      'content': 'If the match is a tie for the main question (i.e., which team will win), you will not get the bidding amount back. However, if your answers to the sub-questions are correct, you will still earn the points.',
    },
    {
      'content': 'Coins:',
      'subContent': [
        'Users receive 5000 coins when they join a tournament.',
        'If a user plays daily, they will earn 100 coins.',
        'Whenever a user plays a match, the bidding amount will be deducted from their coins before the match.',
        'If a user wins a match, they will get the bidding amount as coins. Eg:Coins = coins + selected points.',
      ],
    },
    {
      'content': 'Points:',
      'subContent': [
        'If a user bids for x points and wins the match, the bidding amount will be added to their points. Eg:Points = points + selected points.',
        'If the user loses the match, the bidding amount will be deducted from their points. Eg:Points = points - selected points.',
        'If a user misses a match, 200 points will be deducted from their points. Eg:Points = points - 200.',
        'If all answers are correct, 2000 points will be added as a bonus.',
        'Every correct answer for the sub-question will earn 500 points each.',
      ],
    },
  ];

  Widget renderTerms(List<String> termsData) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 16.0),
      itemCount: termsData.length,
      itemBuilder: (context, index) {
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          title: Text(
            '${index + 1}. ${termsData[index]}',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        );
      },
    );
  }

  Widget renderRules(List<Map<String, dynamic>> rules) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 16.0),
      itemCount: rules.length,
      itemBuilder: (context, index) {
        final rule = rules[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              title: Text(
                '${index + 1}. ${rule['content']}',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            if (rule['subContent'] != null)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: renderSubContent(rule['subContent']),
              ),
          ],
        );
      },
    );
  }

  Widget renderSubContent(List<String> subContent) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 16.0),
      itemCount: subContent.length,
      itemBuilder: (context, index) {
        final alphabet = String.fromCharCode(97 + index); // a, b, c, ...
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          title: Text(
            '$alphabet. ${subContent[index]}',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tournament Rules'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Terms:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              renderTerms(terms),
              const SizedBox(height: 16.0),
              const Text(
                'Rules:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              renderRules(rules),
            ],
          ),
        ),
      ),
    );
  }
}
