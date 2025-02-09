import 'package:flutter/material.dart';
import '../services/api_service.dart';

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
  String? _selectedPoints;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitKaji() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newKaji = await ApiService.createKaji(
          _titleController.text,
          _contentController.text,
          int.parse(_selectedPoints!),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('「${newKaji.title}」を登録しました')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('家事登録エラー: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('家事登録')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: '家事のタイトル'),
                validator: (value) => value == null || value.isEmpty ? 'タイトルを入力してください' : null,
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: '家事の内容'),
                validator: (value) => value == null || value.isEmpty ? '内容を入力してください' : null,
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
                onChanged: (value) => setState(() => _selectedPoints = value),
                validator: (value) => value == null || value.isEmpty ? 'ポイントを選択してください' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submitKaji, child: const Text('登録')),
            ],
          ),
        ),
      ),
    );
  }
}