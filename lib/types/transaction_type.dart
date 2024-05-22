import 'package:flutter/material.dart';

class TransactionType {
  final int id;
  final String name;
  final String imageUrl;
  final int trxMultiply;
  final String description = "";

  TransactionType({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.trxMultiply,
  });
}
