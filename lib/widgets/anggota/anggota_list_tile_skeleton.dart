import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/widgets/text_label.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnggotaListTileSkeleton extends StatelessWidget {
  const AnggotaListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListTile(
        leading: Icon(Icons.account_circle, size: 40),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
            Row(
              children: [
                Text(
                  'Item number 1 as location long',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        style: ListTileStyle.list,
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
