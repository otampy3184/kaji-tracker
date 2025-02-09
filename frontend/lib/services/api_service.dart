import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kaji.dart';
import '../models/user.dart';
import '../models/kaji_record.dart';

class ApiService {
  // ※ iOS シミュレータの場合は localhost でOKですが、実機時はIPアドレスに変更してください
  static const String baseUrl = 'http://localhost:3000/api';

  // 家事データ
  static Future<List<Kaji>> fetchKajis() async {
    final response = await http.get(Uri.parse('$baseUrl/kajis'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Kaji.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch kajis: ${response.statusCode}');
    }
  }

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
      throw Exception('Failed to create kaji: ${response.statusCode}');
    }
  }

  // ユーザーデータ
  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  }

  static Future<User> createUser(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  // 家事レコードデータ
  static Future<List<KajiRecord>> fetchKajiRecords() async {
    final response = await http.get(Uri.parse('$baseUrl/kaji_records'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => KajiRecord.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch kaji records: ${response.statusCode}');
    }
  }

  static Future<KajiRecord> createKajiRecord(int userId, int kajiId, DateTime performedDate) async {
    final response = await http.post(
      Uri.parse('$baseUrl/kaji_records'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': userId,
        'kaji_id': kajiId,
        'performed_date': performedDate.toIso8601String(),
      }),
    );
    if (response.statusCode == 201) {
      return KajiRecord.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create kaji record: ${response.statusCode}');
    }
  }
}