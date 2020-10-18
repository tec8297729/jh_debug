import 'package:flutter/material.dart';
import '../../jh_debug.dart';

/// 浮层按钮
class StackPosBtn extends StatefulWidget {
  StackPosBtn(
      {this.left, this.rigth, this.top, this.bottom, this.height, this.width});
  final double width;
  final double height;
  final double left;
  final double rigth;
  final double top;
  final double bottom;
  @override
  _StackPosBtnState createState() => _StackPosBtnState();
}

class _StackPosBtnState extends State<StackPosBtn> {
  Offset moveOffset;

  @override
  Widget build(BuildContext context) {
    double handleTop = MediaQuery.of(context).size.height * 0.7;
    if (widget.bottom != null || widget.top != null) {
      handleTop = widget.top ?? null;
    }
    return Positioned(
      top: moveOffset?.dy ?? handleTop,
      right: widget.rigth ?? null,
      left: moveOffset?.dx ?? widget.left ?? null,
      bottom: widget.bottom ?? null,
      child: Semantics(
        label: 'jhdebug_StackPosBtn',
        child: GestureDetector(
          onDoubleTap: () => jhDebug.removeDebugBtn(),
          onTap: () => jhDebug.showLog(),
          child: Opacity(
            opacity: 0.6,
            child: dragWidge(),
          ),
        ),
      ),
    );
  }

  Widget dragWidge() {
    Widget child = Container(
      width: widget.width ?? 45,
      height: widget.height ?? 45,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.bug_report, size: 33),
    );

    return LongPressDraggable(
      feedback: child,
      childWhenDragging: Container(),
      child: child,
      // 拖拽结束后触发，返回当前组件详细参数
      onDragEnd: (DraggableDetails details) {
        setState(() {
          moveOffset = details.offset;
        });
      },
    );
  }
}
