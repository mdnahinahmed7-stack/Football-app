class StreamLink {
  final String quality;
  final String language;
  final String url;

  StreamLink({required this.quality, required this.language, required this.url});

  factory StreamLink.fromJson(Map<String, dynamic> json) {
    return StreamLink(
      quality: json['quality'] ?? '',
      language: json['language'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class Team {
  final String name;
  final String logo;

  Team({required this.name, required this.logo});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(name: json['name'] ?? '', logo: json['logo'] ?? '');
  }
}

class MatchModel {
  final String id;
  final String league;
  final String status;
  final int minute;
  final Team homeTeam;
  final Team awayTeam;
  final int homeScore;
  final int awayScore;
  final DateTime startTime;
  final List<StreamLink> streams;

  MatchModel({
    required this.id,
    required this.league,
    required this.status,
    required this.minute,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.startTime,
    required this.streams,
  });

  bool get isLive => status == 'LIVE';

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'],
      league: json['league'] ?? '',
      status: json['status'] ?? 'UPCOMING',
      minute: json['minute'] ?? 0,
      homeTeam: Team.fromJson(json['homeTeam']),
      awayTeam: Team.fromJson(json['awayTeam']),
      homeScore: json['homeScore'] ?? 0,
      awayScore: json['awayScore'] ?? 0,
      startTime: DateTime.tryParse(json['startTime'] ?? '') ?? DateTime.now(),
      streams: (json['streams'] as List<dynamic>? ?? [])
          .map((s) => StreamLink.fromJson(s))
          .toList(),
    );
  }
}
