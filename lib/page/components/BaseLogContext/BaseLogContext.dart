import 'package:flutter/material.dart';

/// 基础层
class BaseLogContext extends StatefulWidget {
  const BaseLogContext({Key key, @required this.child, this.headerChild})
      : super(key: key);

  /// 子组件
  final List<Widget> child;

  final Widget headerChild;

  @override
  _BaseLogContextState createState() => _BaseLogContextState();
}

class _BaseLogContextState extends State<BaseLogContext>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(keepScrollOffset: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: EdgeInsets.only(top: 43),
                child: Column(children: widget.child),
              ),
            ),
            // 头部组件
            if (widget.headerChild != null) widget.headerChild,
          ],
        ),
      ),
    );
  }
}
