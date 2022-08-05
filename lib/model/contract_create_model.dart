import 'package:flutter/material.dart';
import 'package:fyp/screens/general_template/general_template_dart.dart';
import 'package:fyp/screens/job_agreement/job_agreement_screen.dart';
import 'package:fyp/screens/rent_agreement/rent_agreement_screen.dart';

class ContractCreateModel {
  final String name;
  final IconData iconUrl;
  final String title;
  final String time;
  final String routeName;
  final String description;

  ContractCreateModel({
    required this.iconUrl,
    required this.description,
    required this.time,
    required this.name,
    required this.routeName,
    required this.title,
  });
  static List<ContractCreateModel> contract = [
    ContractCreateModel(
      iconUrl: Icons.handshake,
      description: 'An official Pledge to myself with a Signature',
      time: '2 min',
      name: 'Promise',
      title:
          'Promise to yourself to lose weight ? No smoking ? \nSo Do what you promise and you will get what you want.\nWe will support you have that power in you. \n Are you afraid you well snap?\n\n that\'s ok,We will help you get there.\n Now you are not just promising  yourself something.\n Now you are signing an official document with yourself',
      routeName: GeneralTemplate.routeName,
    ),
    ContractCreateModel(
      iconUrl: Icons.vpn_key,
      description: 'An official Pledge to myself with a Signature',
      time: '2 min',
      name: 'Rental',
      title:
          'Anything can be rented using licit rental-agreement.\n from room ,apartment or house to a car,bicycle or power tools.\n whether a short term or long term rental,\nthe parties can customize their terms and how and when rental payment are tobe made.',
      routeName: RentAgreementScreen.routeName,
    ),
    ContractCreateModel(
      iconUrl: Icons.handyman,
      description: 'An official Pledge to myself with a Signature',
      time: '2 min',
      name: 'HandyMan',
      title:
          'Maintaining your home or apartment seems like a never-ending task.\n There are any number of systems-plumbing ,electrical,paint,landscaping,\nHVAC-that from time to time require the skill of a craftsman ,contractor, or specialist to fix or to otherwise keep in ship-shape.',
      routeName: JobAgreementScreen.routeName,
    ),
  ];
}
//Promise to yourself to lose weight ? No smoking ? \n So Do what you promise and you will get what you want.\nWe will support you have that power in you. \n Are you afraid you well snap?
