import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/bloc/matches/match_bloc.dart';
import 'package:sports_app/models/active_matches.dart';
import 'package:sports_app/models/category.dart';
import 'package:sports_app/components/curved_navigation_bar.dart';
import 'package:sports_app/models/tournament.dart';
import 'package:sports_app/pages/account_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/pages/group_page.dart';

import '../bloc/tournament/tournament_bloc.dart';
import '../components/custom_app_bar.dart';
import '../components/match_card.dart';
import '../components/snackbar.dart';
import '../components/tournament_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MatchBloc _matchBloc = MatchBloc();
  final TournamentBloc _tournamentBloc = TournamentBloc();
  // String? userId;
  String selectedPage = '';
  int _selectedIndex = 0;

  // int _sportIndex = 0;

  @override
  void initState() {
    // _loadUserId;
    super.initState();
    _getCategories();

    // Trigger the API calls only if the state is initial
    if (_matchBloc.state is MatchInitial) {
      _matchBloc.add(const GetMatchList());
    }
    if (_tournamentBloc.state is TournamentInitial) {
      _tournamentBloc.add(const GetTournaments());
    }
  }

  // Future<void> _loadUserId() async {
  //   const storage = FlutterSecureStorage();
  //   String? id = await storage.read(key: 'user_id');
  //   setState(() {
  //     userId = id;
  //   });
  //   print(userId);
  // }
  
  List<Category> categories = [];

  void _getCategories() {
    categories = Category.getCategories();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    

    // Navigate to AccountPage when account_circle is tapped
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccountPage()),
      );
    }
  }

  // void _onTabtapped(int index) {
  //   setState(() {
  //     _sportIndex = index;
  //   });

  //   if (index == 1) {}
  // }

  void logout() {
    print("logout");
    Navigator.pushNamed(context, '/auth');
  }
  

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return SafeArea(
      child: Scaffold(
       appBar: const CustomAppBar(title: 'PTW'),
        drawer: _drawer(),
        body: Container(
          color: const Color.fromARGB(255, 163, 182, 192),
          child: Column(
            children: [
              _tabBar(),
              const SizedBox(
                height: 15.0,
              ),
              _matches(),
              const Divider(
                height: 10.0,
                color: Colors.black,
                endIndent: 10.0,
                indent: 10.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              _tournamentDs()
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBarWidget(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  Expanded _tournamentDs() {
    return Expanded(
      child: BlocBuilder<TournamentBloc, TournamentState>(
        builder: (context, state) {
          if (state is TournamentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TournamentLoaded) {
            return ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Ongoing Tournaments',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                ...state.activeTournaments.map((tournament) => BuildTCard(
                      TLogoUrl: 'image',
                      TName: tournament.name ?? '',
                      start_date: tournament.startDate,
                      end_date: tournament.endDate,
                      points: tournament.userDetails.userPoints,
                    )),
                const SizedBox(
                  height: 15.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Upcoming Tournaments',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                ...state.upcomingTournaments.map((tournament) => BuildTCard(
                      TLogoUrl: 'image',
                      TName: tournament.name ?? '',
                      start_date: tournament.startDate,
                      end_date: tournament.endDate,
                      points: tournament.userDetails.userPoints,
                    )),
              ],
            );
          } else if (state is TournamentError) {
            return Center(child: Text(state.message!));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  DefaultTabController _tabBar() {
    return DefaultTabController(
      length: categories.length,
      child: Container(
        color: Colors.white,
        child: TabBar(
          // onTap: _onTabtapped,
          labelPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          indicatorSize: TabBarIndicatorSize
              .tab, // Set the indicator size to match the label width
          indicatorColor: const Color.fromARGB(255, 0, 154, 100),
          labelColor: const Color.fromARGB(255, 0, 154, 100),
          tabs: categories.map((category) {
            return Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category.icon,
                    size: 26.0,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Drawer _drawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      elevation: 20.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 63, 88, 101),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.profile_circled,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 70.0,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Paramaguru",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          "guru@example.com",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: logout,
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 208, 255, 0),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            onTap: () {
              setState(() {
                selectedPage = 'Messages';
                Navigator.of(context).pop();
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.games),
            title: const Text('Tournaments'),
            onTap: () {
              setState(() {
                selectedPage = 'Profile';
                Navigator.of(context).pop();
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Groups'),
             onTap: () {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GroupPage()),
      );
    });
  },
          ),
        ],
      ),
    );
  }

  Column _matches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            'Matches',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        _buildListMatch(),
      ],
    );
  }

  Widget _buildListMatch() {
    return BlocProvider(
      create: (_) => _matchBloc,
      child: BlocListener<MatchBloc, MatchState>(
        listener: (context, state) {
          if (state is MatchError) {
            showSnackbar(context, state.message!);
          }
        },
        child: BlocBuilder<MatchBloc, MatchState>(
          builder: (context, state) {
            if (state is MatchInitial) {
              return _buildLoading();
            } else if (state is MatchLoading) {
              return _buildLoading();
            } else if (state is MatchLoaded) {
              return _buildCard(context, state.matchModel);
            } else if (state is MatchError) {
              return const Center(
                  child: Text('Error loading matches')); // Show error message
            } else {
              return Container(); // Handle unexpected states
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildCard(BuildContext context, ActiveMatches model) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.data!.length,
        itemBuilder: (context, index) {
          final match = model.data![index];
          return Center(
            child: SizedBox(
              width: 320, // Set a fixed width for the BuildCard
              child: BuildCard(
                sportName: match.sportId ?? '',
                tournament: match.tournament ?? '',
                team1: match.matchDetails?.shortNameTeam1 ?? "",
                team2: match.matchDetails?.shortNameTeam2 ?? "",
                team1LogoUrl: match.matchDetails?.team1_logo,
                team2LogoUrl: match.matchDetails?.team2_logo,
                matchDate: "${match.startTime} | ${match.startDate}",
                venue: match.venue ?? "",
              ),
            ),
          );
        },
      ),
    );
  }

}
