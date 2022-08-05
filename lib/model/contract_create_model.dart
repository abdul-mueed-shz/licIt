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
      description:
          'An official confidentiality agreement between two parties about maintainance of secrecy of certain information',
      time: '5 min',
      name: 'Non Disclosure Agreement',
      title:
          'A non disclosure agreement, also known as a confidentiality agreement is a legally binding contract in which one party agrees to give second party confidential information about its business or products and the second party agrees not to share this information with anyone else for a specified time period.',
      routeName: GeneralTemplate.routeName,
    ),
    ContractCreateModel(
      iconUrl: Icons.vpn_key,
      description:
          "An official contract for a tenant's regular payment to a landlord for the use of property or land",
      time: '15 min',
      name: 'Rental',
      title:
          'Anything can be rented using licit rental-agreement from room ,apartment or house to a car,bicycle or power tools whether a short term or long term rental, the parties can customize their terms and how and when rental payment are to be made.',
      routeName: RentAgreementScreen.routeName,
    ),
    ContractCreateModel(
      iconUrl: Icons.handyman,
      description:
          'An employment contract is an agreement that covers the working relationship between a company and an employee',
      time: '10 min',
      name: 'Job Agreement',
      title:
          'An employement contract is a signed agreement between an individual and an employer or a labor union. It establishes both the rights and responsibilities of the two parties: the worker and the company. ',
      routeName: JobAgreementScreen.routeName,
    ),
  ];
}
//Promise to yourself to lose weight ? No smoking ? \n So Do what you promise and you will get what you want.\nWe will support you have that power in you. \n Are you afraid you well snap?
