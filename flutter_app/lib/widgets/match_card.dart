import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/match_model.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;
  final VoidCallback onTap;

  const MatchCard({super.key, required this.match, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(match.league,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Spacer(),
                  _StatusBadge(status: match.status, minute: match.minute),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _teamColumn(match.homeTeam.logo, match.homeTeam.name),
                  Expanded(
                    child: Center(
                      child: Text(
                        match.status == 'UPCOMING'
                            ? 'VS'
                            : '${match.homeScore} - ${match.awayScore}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _teamColumn(match.awayTeam.logo, match.awayTeam.name),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamColumn(String logo, String name) {
    return Expanded(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: logo,
            width: 40,
            height: 40,
            errorWidget: (c, u, e) => const Icon(Icons.shield, size: 40),
          ),
          const SizedBox(height: 4),
          Text(name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final int minute;
  const _StatusBadge({required this.status, required this.minute});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    switch (status) {
      case 'LIVE':
        color = Colors.red;
        label = "LIVE
