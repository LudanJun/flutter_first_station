import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear; // 清除
  final VoidCallback? onBack; // 返回
  final VoidCallback? onRevocation; // 撤销
  const PaperAppBar(
      {super.key, required this.onClear, this.onBack, this.onRevocation});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackUpButtons(
        onBack: onBack,
        onRevocation: onRevocation,
      ),
      leadingWidth: 100,
      title: Text('画板绘制'),
      actions: [
        IconButton(
            splashRadius: 20,
            onPressed: onClear,
            icon: Icon(CupertinoIcons.delete, size: 20))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BackUpButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const BackUpButtons({
    Key? key,
    required this.onBack,
    required this.onRevocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const BoxConstraints cts = BoxConstraints(minHeight: 32, minWidth: 32);
    Color backColor = onBack == null ? Colors.grey : Colors.black;
    Color revocationColor = onRevocation == null ? Colors.grey : Colors.black;
    return Center(
      child: Wrap(
        children: [
          Transform.scale(
            scaleX: -1,
            child: IconButton(
              splashRadius: 20,
              constraints: cts,
              onPressed: onBack,
              icon: Icon(Icons.next_plan_outlined, color: backColor),
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: onRevocation,
            constraints: cts,
            icon: Icon(Icons.next_plan_outlined, color: revocationColor),
          )
        ],
      ),
    );
  }
}
