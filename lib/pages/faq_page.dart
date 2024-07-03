import 'package:flutter/material.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  _FAQsPageState createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  String? expandedPanel;
  String searchQuery = '';

  final List<Map<String, dynamic>> faqs = [
     {
      'question': 'How to join a tournament?',
      'answer':
          "To join a tournament, navigate to the tournaments section on the platform. In the homepage, click on 'Join' for the desired tournament. Alternatively, you can access tournaments by clicking on the menu icon (displayed as ≡) on the top left. Then, select the tournament and click on 'Join' to participate.",
      'screenshot': ['assets/FAQs/joinTournament.png', 'assets/FAQs/joinTournament1.png'],
    },
    {
      'question': 'How to play a match?',
      'answer': 'After joining a tournament, locate the scheduled match in your tournament dashboard...',
      'screenshot': ['assets/FAQs/playMatch.png'],
    },
    {
      'question': 'How to check the points of a match?',
      'answer': 'To check the points of a match, go to your tournament dashboard...',
      'screenshot': ['assets/FAQs/matchPoint.png'],
    },
    {
      'question': 'How to check the breakdown of the points in a match?',
      'answer': "To view the breakdown of points in a match, go to the tournament section of the platform and click on 'Schedule'. In the points column, you will see the points for respective matches. Click on 'Points' to check the breakdown of the points.",
      'screenshot': ['assets/FAQs/breakdownPoints.png'],
    },
    {
      'question': 'How to check the user ranking?',
      'answer': "To check the user ranking, go to the tournament section of the platform and click on 'top users'.",
      'screenshot': ['assets/FAQs/userRanking.png'],
    },
    {
      'question': 'How to create a group?',
      'answer': "To create a group, go to the 'Manage Groups' section of the platform, click on the 'plus' icon at the bottom right, add a group name, and then click on 'Submit'.",
      'screenshot': ['assets/FAQs/createGroup1.png', 'assets/FAQs/createGroup.png'],
    },
    {
      'question': 'How to add members to a group?',
      'answer': "After creating a group, click on view then click on 'menu' icon (displayed as ≡), then click on Group members, then you can add members to your group.",
      'screenshot': ['assets/FAQs/addGroupMembers1.png', 'assets/FAQs/addGroupMembers2.png', 'assets/FAQs/addGroupMembers.png'],
    },
    {
      'question': 'How to join a tournament as a group?',
      'answer': "To join a tournament as a group, go to 'Manage Groups', click on 'View', then click on the 'Menu' icon (displayed as ≡), open 'Active Tournament', and join the respective tournaments.",
      'screenshot': ['assets/FAQs/groupTournament.png'],
    },
    {
      'question': 'How to check the group ranking?',
      'answer': "To check the group ranking, click on respective Tournament click on 'Top Groups'.",
      'screenshot': ['assets/FAQs/groupRanking.png'],
    },
    {
      'question': 'How to check the points of my groups?',
      'answer': "To check the points of your groups, go to dashboard click on respective Tournament click on 'My Groups'.",
      'screenshot': ['assets/FAQs/myGroupPoints.png'],
    },
    {
      'question': 'How to check the points of my group members?',
      'answer': 'To check the points of your group members, go to the dashboard, click on the respective "Tournament", click on "My Groups", then click on "View" on any of your groups to see the group members points.',
      'screenshot': ['assets/FAQs/membersPoints.png'],
    },
  ];

  void handleAccordionChange(String panel) {
    setState(() {
      expandedPanel = expandedPanel == panel ? null : panel;
    });
  }

  void handleSearchChange(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  List<Map<String, dynamic>> get filteredFaqs {
    return faqs.where((faq) {
      return faq['question'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration:const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: handleSearchChange,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFaqs.length,
                itemBuilder: (context, index) {
                  final faq = filteredFaqs[index];
                  return ExpansionPanelList(
                    elevation: 1,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (int item, bool isExpanded) {
                      handleAccordionChange(faq['question']);
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(faq['question'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          );
                        },
                        body: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(faq['answer']),
                              const SizedBox(height: 10),
                              if (faq['screenshot'] != null)
                                Wrap(
                                  spacing: 10,
                                  children: List.generate(faq['screenshot'].length, (screenshotIndex) {
                                    return Badge(
                                      badgeContent: Text('${screenshotIndex + 1}', style: const TextStyle(color: Colors.white)),
                                      child: Image.asset(
                                        faq['screenshot'][screenshotIndex],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                                ),
                            ],
                          ),
                        ),
                        isExpanded: expandedPanel == faq['question'],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final Widget badgeContent;
  final Widget child;

  const Badge({
    required this.badgeContent,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -5,
          right: -5,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.red,
            child: Center(
              child: badgeContent,
            ),
          ),
        ),
      ],
    );
  }
}
