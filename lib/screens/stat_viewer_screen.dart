import 'dart:convert';

import 'package:betviewapp/backend/api_calls.dart';
import 'package:betviewapp/colors.dart';
import 'package:betviewapp/models/player.dart';
import 'package:betviewapp/models/stats/player_stats.dart';

import 'package:betviewapp/strings.dart';
import 'package:betviewapp/widgets/app_bar_action.dart';
import 'package:betviewapp/widgets/custom_appbar.dart';
import 'package:betviewapp/widgets/input_field.dart';

import 'package:flutter/material.dart';

class StatViewer extends StatefulWidget {
  const StatViewer({super.key});

  @override
  State<StatViewer> createState() => _StatViewerState();
}

class _StatViewerState extends State<StatViewer> {
  final _formKey = GlobalKey<FormState>();
  String lastName = '';
  List<Player> players = [];
  late PlayerStats playerStats;
  bool showPlayers = false;
  bool searching = false;
  bool showStats = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(buildSearchBar: buildSearchForm()),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              showPlayers
                  ? searching
                      ? const CircularProgressIndicator(
                          color: mainAppColor,
                        )
                      : !showStats
                          ? buildPlayerList()
                          : buildPlayerStat(players[selectedIndex].id)
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchForm() {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width < 500 ? 100 : 250,
            child: InputField(
              label: MediaQuery.of(context).size.width > 500
                  ? Row(children: const [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(tSearchPlayer),
                      )
                    ])
                  : const SizedBox.shrink(),
              onSaved: (String? value) {
                lastName = value!;
              },
            ),
          ),
          SizedBox(
              height: 45,
              width: 45,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: AppBarAction(
                  iconData: Icons.search_rounded,
                  onPressed: () {
                    _formKey.currentState?.save();
                    setState(() {
                      searching = true;
                      showPlayers = true;
                      showStats = false;
                    });
                    BackendApi.getPlayersByLastName(lastName).then((value) {
                      players = (json.decode(value.body) as List)
                          .map((e) => Player.fromJson(e))
                          .toList();

                      setState(() {
                        searching = false;
                        if (players.length == 1) {
                          showStats = true;
                        }
                      });
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget buildPlayerStat(String id) {
    return FutureBuilder(
        future: BackendApi.getPlayerStats(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final jsonData = json.decode(snapshot.data!.body);
            List<String> rebs = (json.decode(jsonData['Rebounds']) as List)
                .map(((e) => e.toString()))
                .toList();
            List<String> asts = (json.decode(jsonData['Assists']) as List)
                .map(((e) => e.toString()))
                .toList();
            List<String> pts = (json.decode(jsonData['Points']) as List)
                .map(((e) => e.toString()))
                .toList();

            playerStats =
                PlayerStats(rebounds: rebs, assists: asts, points: pts);
            return Wrap(children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: greyShadow,
                        spreadRadius: 2.0,
                        blurRadius: 7,
                        offset: Offset(3, 3)),
                  ],
                ),
                child: MediaQuery.of(context).size.width < 1000
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildStatColumn('REBOUNDS', rebs),
                          buildStatColumn('ASSISTS', asts),
                          buildStatColumn('POINTS', pts),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: buildStatColumn('REBOUNDS', rebs),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: buildStatColumn('ASSISTS', asts),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: buildStatColumn('POINTS', pts),
                          ),
                        ],
                      ),
              ),
            ]);
          } else {
            return const CircularProgressIndicator(color: mainAppColor);
          }
        });
  }

  Widget buildStatColumn(String columnName, List<String> stats) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            columnName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: mainAppColor),
          ),
        ),
        SizedBox(
          height: 300,
          width: 40,
          child: ListView(
            children: stats
                .map((e) => Text(
                      e,
                      style: const TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w500),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildPlayerList() {
    return SingleChildScrollView(
      child: SizedBox(
        width: 400,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: ListView.builder(
            itemBuilder: (_, index) => TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                    showStats = true;
                  });
                },
                child: Text(
                  players[index].name,
                  style: const TextStyle(
                      color: mainAppColor, fontWeight: FontWeight.bold),
                )),
            itemCount: players.length,
          ),
        ),
      ),
    );
  }
}
