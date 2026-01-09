// lib/page/json_input_page.dart
import 'package:flutter/material.dart';
import 'package:videoparse/utils/app_utils.dart';

class JsonInputPage extends StatefulWidget {
  const JsonInputPage({super.key});

  @override
  State<JsonInputPage> createState() => _JsonInputPageState();
}

class _JsonInputPageState extends State<JsonInputPage> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _parseAndNavigate() {
    final String jsonString = _controller.text.trim();
    if (jsonString.isEmpty) {
      setState(() {
        _errorText = 'JSON不可为空';
      });
      return;
    }

    try {

      setState(() {
        _errorText = null;
      });

    } catch (e) {
      // 如果JSON解析失败
      setState(() {
        _errorText = 'JSON格式错误或数据结构不匹配: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('输入JSON数据'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null, // 允许多行输入
                expands: true, // 占满可用空间
                decoration: InputDecoration(
                  hintText: '在此处粘贴JSON字符串.',
                  border: const OutlineInputBorder(),
                  errorText: _errorText,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _parseAndNavigate,
              child: const Text('解析并播放'),
            ),
          ],
        ),
      ),
    );
  }
}


