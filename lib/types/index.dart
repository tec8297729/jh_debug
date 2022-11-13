import 'package:flutter/material.dart';

enum LogType { debug, print }

/// 搜索状态
enum SearchStatus { show, hide }

class CustomTabItem {
  // tab标题
  String title;
  // 展示的组件
  Widget widget;

  CustomTabItem({required this.title, required this.widget});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['widget'] = widget;
    return data;
  }
}
