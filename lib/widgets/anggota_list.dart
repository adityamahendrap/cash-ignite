import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';

class AnggotaList extends StatefulWidget {
  const AnggotaList({super.key});

  @override
  State<AnggotaList> createState() => _AnggotaListState();
}

class _AnggotaListState extends State<AnggotaList> {
  final MoblieApiRequester _apiRequester = MoblieApiRequester();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _apiRequester.getAnggotaList(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            HelplessUtil.handleApiError(snapshot.error as DioException);
            return Center(
              child: Text(
                'Failed to fetch data :(',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            final anggota = snapshot.data;
            return Center(
              child: Text(
                '$anggota',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
