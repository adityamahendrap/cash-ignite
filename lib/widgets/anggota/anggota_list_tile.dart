import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/saldo_anggota_type.dart';
import 'package:progmob_magical_destroyers/providers/profile_provider.dart';
import 'package:progmob_magical_destroyers/screens/main/detail_anggota_screen.dart';
import 'package:progmob_magical_destroyers/screens/savings_loan/update_anggota_screen.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';
import 'package:progmob_magical_destroyers/widgets/text_label.dart';

class AnggotaListTile extends StatefulWidget {
  final Anggota item;
  final Function(Anggota) updateAnggotaCallback;
  final Function(Anggota) deleteAnggotaCallback;

  const AnggotaListTile({
    super.key,
    required this.item,
    required this.updateAnggotaCallback,
    required this.deleteAnggotaCallback,
  });

  @override
  State<AnggotaListTile> createState() => _AnggotaListTileState();
}

class _AnggotaListTileState extends State<AnggotaListTile> {
  MoblieApiRequester _apiRequester = MoblieApiRequester();

  void _handleListTileOnTap() {
    Get.to(() => DetailAnggotaScreen(), arguments: {'anggota': widget.item});
  }

  Future<SaldoAnggota> _getSaldoAnggota(Anggota anggota) async {
    return _apiRequester.getSaldoByAnggotaId(anggotaId: anggota.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _containerDecoration(),
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
      child: ListTile(
        onTap: () => _handleListTileOnTap(),
        leading: GestureDetector(
          onTap: () {
            Get.to(() => PhotoView(image: AssetImage(defaultImagePath)));
          },
          child: CircleAvatar(
            backgroundColor: ColorPlanet.primary,
            backgroundImage: AssetImage(defaultImagePath),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.nama,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5),
            Row(
              children: [
                _saldoAnggota(widget.item),
                // '${HelplessUtil.calculateAge(DateTime.parse(item.tglLahir))} years'),
                SizedBox(width: 5),
                // Text("| "),
                // Icon(Icons.phone_outlined,
                //     color: ColorPlanet.primary, size: 20),
                // SizedBox(width: 5),
                // Flexible(
                //   child: Text(
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //     '${item.telepon}',
                //     style: TextStyle(fontSize: 14),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 5),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.location_on_outlined,
            //       color: ColorPlanet.primary,
            //     ),
            //     SizedBox(width: 5),
            //     Text(
            //       item.alamat,
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       style: TextStyle(fontSize: 14),
            //     ),
            //   ],
            // ),
          ],
        ),
        style: ListTileStyle.list,
        trailing: _popUpMenuButton(widget.item),
      ),
    );
  }

  Widget _saldoAnggota(Anggota anggota) {
    return FutureBuilder(
      future: _getSaldoAnggota(anggota),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final int saldo = snapshot.data!.saldo!;
          return TextLabel(text: "Rp${HelplessUtil.formatNumber(saldo)}");
        } else if (snapshot.hasError) {
          clog.error('snaphot err: ${snapshot.error.toString()}');
          return TextLabel(text: "Error");
        }

        return TextLabel(text: "Loading");
      },
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  PopupMenuButton<dynamic> _popUpMenuButton(Anggota anggota) {
    return PopupMenuButton(
      onSelected: (item) {
        switch (item) {
          case 'edit':
            Get.to(
                () => UpdateAnggotaScreen(
                    updateAnggotaCallback: widget.updateAnggotaCallback),
                arguments: {'anggota': anggota});
            break;
          case 'delete':
            widget.deleteAnggotaCallback(anggota);
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
      position: PopupMenuPosition.under,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(2),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
