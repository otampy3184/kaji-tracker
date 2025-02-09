import 'package:flutter/material.dart';
import '../controllers/kaji_controller.dart';
import '../models/kaji.dart';

/// 家事の新規登録画面
class NewKajiView extends StatefulWidget {
  const NewKajiView({super.key});

  @override
  State<NewKajiView> createState() => _NewKajiViewState();
}

class _NewKajiViewState extends State<NewKajiView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _pointsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  void _submitChore() {
    if (_formKey.currentState!.validate()) {
      // 新規家事インスタンスの作成（idは簡易的に生成）
      final newKaji = Kaji(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        content: _contentController.text,
        points: int.parse(_pointsController.text),
      );
      // Controller 経由で家事を登録
      KajiController().addKaji(newKaji);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('家事が登録されました')),
      );
      // フィールドをクリア
      _titleController.clear();
      _contentController.clear();
      _pointsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('家事登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: '家事のタイトル'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'タイトルを入力してください';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: '家事の内容'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '内容を入力してください';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'ポイント'),
                items: const [
                  DropdownMenuItem(value: '1', child: Text('1ポイント')),
                  DropdownMenuItem(value: '2', child: Text('2ポイント')),
                  DropdownMenuItem(value: '3', child: Text('3ポイント')),
                  DropdownMenuItem(value: '5', child: Text('5ポイント')),
                  DropdownMenuItem(value: '8', child: Text('8ポイント')),
                  DropdownMenuItem(value: '13', child: Text('13ポイント')),
                  DropdownMenuItem(value: '21', child: Text('21ポイント')),
                ],
                onChanged: (String? value) {
                  if (value != null) {
                    _pointsController.text = value;
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'ポイントを選択してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitChore,
                child: const Text('登録'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}