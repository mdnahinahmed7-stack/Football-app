// Demo/fallback data. Replace with live data from a real football data provider
// (e.g. api-football.com) once you add your API key in .env

const matches = [
  {
    id: "m1",
    league: "Premier League",
    status: "LIVE",
    minute: 67,
    homeTeam: { name: "Manchester City", logo: "https://crests.football-data.org/65.png" },
    awayTeam: { name: "Liverpool", logo: "https://crests.football-data.org/64.png" },
    homeScore: 2,
    awayScore: 1,
    startTime: "2026-08-09T15:00:00Z",
    streams: [
      { quality: "HD", language: "English", url: "https://example.com/stream/m1-hd.m3u8" },
      { quality: "SD", language: "Bangla", url: "https://example.com/stream/m1-sd-bn.m3u8" }
    ]
  },
  {
    id: "m2",
    league: "La Liga",
    status: "UPCOMING",
    minute: 0,
    homeTeam: { name: "Real Madrid", logo: "https://crests.football-data.org/86.png" },
    awayTeam: { name: "Barcelona", logo: "https://crests.football-data.org/81.png" },
    homeScore: 0,
    awayScore: 0,
    startTime: "2026-08-09T19:00:00Z",
    streams: []
  },
  {
    id: "m3",
    league: "Bundesliga",
    status: "FINISHED",
    minute: 90,
    homeTeam: { name: "Bayern Munich", logo: "https://crests.football-data.org/5.png" },
    awayTeam: { name: "Dortmund", logo: "https://crests.football-data.org/4.png" },
    homeScore: 3,
    awayScore: 1,
    startTime: "2026-08-09T13:30:00Z",
    streams: []
  }
];

module.exports = { matches };
