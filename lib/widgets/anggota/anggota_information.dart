import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/widgets/section_header.dart';

class AnggotaInformation extends StatelessWidget {
  final Anggota anggota;

  const AnggotaInformation({super.key, required this.anggota});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SectionHeader(title: "Personal Information", showButton: false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _verticalRow("Full Name", anggota.nama, Icons.person_outline),
                Divider(color: Colors.grey.shade300),
                _horizonralRow("No. Induk", anggota.nomorInduk.toString(),
                    Icons.confirmation_number_outlined),
                Divider(color: Colors.grey.shade300),
                _horizonralRow("Phone", anggota.telepon, Icons.phone_outlined),
                Divider(color: Colors.grey.shade300),
                _horizonralRow(
                    "Birthdate", anggota.tglLahir, Icons.cake_outlined),
                Divider(color: Colors.grey.shade300),
                _verticalRow(
                    "Address", anggota.alamat, Icons.location_on_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizonralRow(String key, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: ColorPlanet.primary,
                  ),
                  SizedBox(width: 10),
                  Text(
                    key,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
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

  Widget _verticalRow(String key, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                key,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                icon,
                color: ColorPlanet.primary,
              ),
            ],
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
