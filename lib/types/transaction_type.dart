import 'package:flutter/material.dart';

class TransactionType {
  final int id;
  final String name;
  final IconData icon;
  final int trxMultiply;
  final String description = "";

  TransactionType({
    required this.id,
    required this.name,
    required this.icon,
    required this.trxMultiply,
  });
}
