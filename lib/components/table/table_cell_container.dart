import 'package:flutter/cupertino.dart';

class TableCellContainer extends StatelessWidget {
  const TableCellContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(5.0), child: child);
  }
}
