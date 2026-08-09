import 'package:flutter/material.dart';
import '../models/match_model.dart';
import '../services/api_service.dart';
import 'stream_player_screen.dart';

class MatchDetailScreen extends StatefulWidget {
  final String matchId;
  const MatchDetailScreen({super.key, required this.matchId});

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  final ApiService _api = ApiService();
  MatchModel? _match;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final match = await _api.fetchMatchDetail(widget.matchId);
    setState(() {
      _match = match;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final match = _match!;
    return Scaffold(
      appBar: AppBar(title: Text(match.league)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Icon(Icons.shield, size: 48),
                Text(match.homeTeam.name),
              ]),
              Text('${match.homeScore} - ${match.awayScore}',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Column(children: [
                Icon(Icons.shield, size: 48),
                Text(match.awayTeam.name),
              ]),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Streaming Links', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (match.streams.isEmpty)
            const Text('No stream available for this match yet.')
          else
            ...match.streams.map((s) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.play_circle_fill, color: Colors.red),
                    title: Text('${s.quality} • ${s.language}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StreamPlayerScreen(streamUrl: s.url, title: match.homeTeam.name + ' vs ' + match.awayTeam.name),
                        ),
                      );
                    },
                  ),
                )),
        ],
      ),
    );
  }
}
