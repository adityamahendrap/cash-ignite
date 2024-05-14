import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_tile.dart';

class AnggotaListView extends StatelessWidget {
  final List<Anggota> items;
  final Function(Anggota) updateAnggotaCallback;
  final Function(Anggota) deleteAnggotaCallback;

  const AnggotaListView({
    super.key,
    required this.items,
    required this.updateAnggotaCallback,
    required this.deleteAnggotaCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade300,
            indent: 20,
            endIndent: 20,
          ),
          shrinkWrap: true,
          itemCount: items.length > 3 ? 3 : items.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Anggota item = items[index];
            return AnggotaListTile(
              item: item,
              updateAnggotaCallback: updateAnggotaCallback,
              deleteAnggotaCallback: deleteAnggotaCallback,
            );
          },
        ),
      ],
    );
  }
}
