import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TransactionHistoryListTileSkeleton extends StatelessWidget {
  final int? itemCount;
  const TransactionHistoryListTileSkeleton({super.key, this.itemCount = 1});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: true,
          child: ListTile(
            leading: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
            ),
            title: Text("Koreksi penarikan"),
            subtitle: Text(
              "12 April 2024",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            trailing: Text(
              "-Rp.1.000.000",
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
