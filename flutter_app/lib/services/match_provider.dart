import 'package:flutter/foundation.dart';
import '../models/match_model.dart';
import 'api_service.dart';

class MatchProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<MatchModel> _matches = [];
  bool _loading = false;
  String? _error;

  List<MatchModel> get matches => _matches;
  bool get loading => _loading;
  String? get error => _error;

  List<MatchModel> get live => _matches.where((m) => m.status == 'LIVE').toList();
  List<MatchModel> get upcoming => _matches.where((m) => m.status == 'UPCOMING').toList();
  List
