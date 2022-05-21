import 'package:flutter/material.dart';
import 'package:fyp/screens/handyman/houehold_screeen.dart';
import 'package:fyp/screens/promise_agreement/promise_agreement.dart';
import 'package:fyp/screens/rental/rental_agreement.dart';

class ContractCreateModel {
  final String name;
  final IconData iconUrl;
  final String description;
  final String time;
  final String routeName;

  ContractCreateModel({
    required this.iconUrl,
    required this.description,
    required this.time,
    required this.name,
    required this.routeName,
  });
  static List<ContractCreateModel> contract = [
    ContractCreateModel(
      iconUrl: Icons.vpn_key,
      description: 'An official Pledge to myself with a Signature',
      time: '2 min',
      name: 'Promise',
      routeName: PromiseAgreement.routeName,
    ),
    ContractCreateModel(
      iconUrl: Icons.cached,
      description: 'An official Pledge to myself with a Signature',
      time: '2 min',
      name: 'Rental',
      routeName: RentAgreement.routeName,
    ),
    ContractCreateModel(
      iconUrl: Icons.vpn_key,
      description: 'An official Pledge to myself with a Signature',
      time: '2 min',
      name: 'HandyMan',
      routeName: HouseHoldScreen.routeName,
    ),
    ContractCreateModel(
      iconUrl: Icons.vpn_key,
      description: 'An official Pledge to myself with a Signature',
      time: '2 min',
      name: 'Promise',
      routeName: RentAgreement.routeName,
    ),
  ];
}
