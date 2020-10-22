import 'package:flutter/material.dart';
import 'package:jh_debug/constants/index.dart';
import 'package:jh_debug/types/index.dart';
import 'package:jh_debug/utils/logData_utls.dart';

// 搜索高亮log列表组件
class SearchItem extends StatelessWidget {
  const SearchItem({
    Key key,
    @required this.text,
    @required this.type,
  }) : super(key: key);
  final String text;
  final LogType type;

  @override
  Widget build(BuildContext context) {
    final sKey = logDataUtls.getSearchKey(type);
    List<TextSpan> textSpanList = [];

    RegExp reg = new RegExp(
      r"(" + sKey + ")",
      multiLine: true,
      caseSensitive: false,
    );
    // print('内容$text');
    text.splitMapJoin(reg, onMatch: (m) {
      textSpanList.add(TextSpan(
        text: m.group(0),
        style: textHighlightedStyle,
      ));
      return m.group(0);
    }, onNonMatch: (n) {
      textSpanList.add(TextSpan(text: n));
      return n;
    });
    return RichText(
      text: TextSpan(
        style: textDefalutStyle,
        children: textSpanList,
      ),
    );
  }
}
