import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/bloc/tournament/tournament_bloc.dart';
import 'package:sports_app/pages/auth_page.dart';
import 'package:sports_app/pages/home.dart';
import 'bloc/auth/auth_bloc.dart';
import 'package:sports_app/pages/group_page.dart';
import 'bloc/matches/match_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<MatchBloc>(
          create: (context) => MatchBloc()..add(const GetMatchList()),
        ),
        BlocProvider<TournamentBloc>(
          create: (context) => TournamentBloc()..add(const GetTournaments()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SPORTS APP',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEFEFEF),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => const AuthPage(),
          '/home': (context) => const HomePage(),
          '/groups': (context) => const GroupPage(),
        },
      ),
    );
  }
}
