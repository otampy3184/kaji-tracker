import 'package:flutter/material.dart';
import '../models/kaji.dart';
import '../services/api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Kaji>> futureKajis;

  @override
  void initState() {
    super.initState();
    // 初回読み込み時にバックエンドから家事一覧を取得
    futureKajis = ApiService.fetchKajis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('家事トラッカー'),
      ),
      body: FutureBuilder<List<Kaji>>(
        future: futureKajis,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final kajis = snapshot.data!;
            if (kajis.isEmpty) {
              return const Center(child: Text('登録された家事はありません'));
            }
            return ListView.builder(
              itemCount: kajis.length,
              itemBuilder: (context, index) {
                final kaji = kajis[index];
                return ListTile(
                  title: Text(kaji.title),
                  subtitle: Text(kaji.content),
                  trailing: Text('${kaji.points} pt'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      // FloatingActionButton で新規家事登録を試す例
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          try {
            // ここではダミーデータで新規家事を登録する例
            final newKaji = await ApiService.createKaji('新しい家事', '家事の内容', 5);
            // 登録後、一覧を再取得して表示を更新
            setState(() {
              futureKajis = ApiService.fetchKajis();
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('「${newKaji.title}」を登録しました')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('家事登録エラー: $e')),
            );
          }
        },
      ),
    );
  }
}