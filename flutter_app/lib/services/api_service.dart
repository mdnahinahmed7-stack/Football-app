import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../models/match_model.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:4000';

  io.Socket? _socket;
  final _liveController = StreamController<List<MatchModel>>.broadcast();
  Stream<List<MatchModel>> get liveUpdates => _liveController.stream;

  Future<List<MatchModel>> fetchMatches({String? status}) async {
    final uri = Uri.parse('$baseUrl/api/matches').replace(
      queryParameters: status != null ? {'status': status} : null,
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];
      return data.map((m) => MatchModel.fromJson(m)).toList();
    }
    throw Exception('Failed to load matches (${response.statusCode})');
  }

  Future<MatchModel> fetchMatchDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/matches/$id'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return MatchModel.fromJson(body['data']);
    }
    throw Exception('Failed to load match detail');
  }

  void connectSocket() {
    _socket = io.io(baseUrl, io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build());
    _socket!.connect();

    _socket!.on('matches:update', (data) {
      final list = (data as List).map((m) => MatchModel.fromJson(m)).toList();
      _liveController.add(list);
    });
  }

  void disposeSocket() {
    _socket?.dispose();
    _liveController.close();
  }
}
