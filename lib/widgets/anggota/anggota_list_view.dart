import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_tile.dart';

class AnggotaListView extends StatelessWidget {
  final List<Anggota> items;
  final Function refreshAnggotaListCallback;
  final Function(Anggota) updateAnggotaCallback;
  final Function(Anggota) deleteAnggotaCallback;
  final bool? limitItems;

  const AnggotaListView({
    super.key,
    required this.items,
    required this.updateAnggotaCallback,
    required this.deleteAnggotaCallback,
    this.limitItems = false,
    required this.refreshAnggotaListCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: limitItems!
              ? (items.length > 3 ? 3 : items.length)
              : items.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Anggota item = items[index];
            return AnggotaListTile(
              item: item,
              refreshAnggotaListCallback: refreshAnggotaListCallback,
              updateAnggotaCallback: updateAnggotaCallback,
              deleteAnggotaCallback: deleteAnggotaCallback,
            );
          },
        ),
      ],
    );
  }
}
