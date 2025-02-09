import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kaji.dart';

class ApiService {
  // バックエンドサーバーのベース URL
  // ※ エミュレーターや実機の場合、localhost の指定は注意が必要です。
  static const String baseUrl = 'http://localhost:3000/api';

  // 登録されている「kaji」一覧を取得する
  static Future<List<Kaji>> fetchKajis() async {
    final response = await http.get(Uri.parse('$baseUrl/kajis'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Kaji.fromJson(json)).toList();
    } else {
      throw Exception('家事一覧の取得に失敗しました: ${response.statusCode}');
    }
  }

  // 新規の「kaji」を登録する
  static Future<Kaji> createKaji(String title, String content, int points) async {
    final response = await http.post(
      Uri.parse('$baseUrl/kajis'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'content': content,
        'points': points,
      }),
    );
    if (response.statusCode == 201) {
      return Kaji.fromJson(json.decode(response.body));
    } else {
      throw Exception('家事登録に失敗しました: ${response.statusCode}');
    }
  }
}