import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/saldo_anggota_type.dart';
import 'package:progmob_magical_destroyers/controllers/profile_provider.dart';
import 'package:progmob_magical_destroyers/screens/main/anggota/anggota_detail_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/anggota/edit_anggota_screen.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';
import 'package:progmob_magical_destroyers/widgets/text_label.dart';

class AnggotaListTile extends StatefulWidget {
  final Anggota item;
  final Function refreshAnggotaListCallback;

  const AnggotaListTile({
    super.key,
    required this.item,
    required this.refreshAnggotaListCallback,
  });

  @override
  State<AnggotaListTile> createState() => _AnggotaListTileState();
}

class _AnggotaListTileState extends State<AnggotaListTile> {
  MobileApiRequester _apiRequester = MobileApiRequester();

  Future<void> _handleListTileOnTap() async {
    await Get.to(() => AnggotaDetailScreen(anggota: widget.item));
    widget.refreshAnggotaListCallback();
  }

  Future<SaldoAnggota> _getSaldoAnggota(Anggota anggota) async {
    // return SaldoAnggota(saldo: 1);
    // TODO: some api path unaccessible when i do batch request like this
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
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.item.nama,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            _saldoAnggota(widget.item),
          ],
        ),
        style: ListTileStyle.list,
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
}
