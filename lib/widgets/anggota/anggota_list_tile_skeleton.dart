import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/widgets/text_label.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnggotaListTileSkeleton extends StatelessWidget {
  final int? itemCount;
  const AnggotaListTileSkeleton({super.key, this.itemCount = 1});

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
            leading: Icon(Icons.account_circle, size: 40),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item number 1 as',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  'Item number 1',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 5),
              ],
            ),
            style: ListTileStyle.list,
            trailing: Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}
