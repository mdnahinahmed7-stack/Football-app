import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/match_provider.dart';
import '../widgets/match_card.dart';
import 'match_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MatchProvider>().loadMatches();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Football Scores'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Live'),
            Tab(text: 'Upcoming'),
            Tab(text: 'Finished'),
          ],
        ),
      ),
      body: Consumer<MatchProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }
          return RefreshIndicator(
            onRefresh: provider.loadMatches,
            child: TabBarView(
              controller: _tabController,
              children: [
                _matchList(provider.live),
                _matchList(provider.upcoming),
                _matchList(provider.finished),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _matchList(List matches) {
    if (matches.isEmpty) {
      return const Center(child: Text('No matches'));
    }
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return MatchCard(
          match: match,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MatchDetailScreen(matchId: match.id)),
            );
          },
        );
      },
    );
  }
}
