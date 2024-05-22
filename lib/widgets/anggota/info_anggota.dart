import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/widgets/section_header.dart';

class InfoAnggota extends StatelessWidget {
  final Anggota anggota;

  const InfoAnggota({super.key, required this.anggota});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 20),
          SectionHeader(title: "Anggota Information", showButton: false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _verticalRow("Full Name", anggota.nama),
                Divider(color: Colors.grey.shade300),
                _horizonralRow("No. Induk", anggota.nomorInduk.toString()),
                Divider(color: Colors.grey.shade300),
                _horizonralRow("Phone", anggota.telepon),
                Divider(color: Colors.grey.shade300),
                _horizonralRow("Birthdate", anggota.tglLahir),
                Divider(color: Colors.grey.shade300),
                _verticalRow("Address", anggota.alamat),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizonralRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _verticalRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            key,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade500,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
