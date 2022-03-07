import 'package:firebase_database/firebase_database.dart';
import 'package:fyp/services/authservice.dart';

class SettingDefaultStuff {
  final databaseReference = FirebaseDatabase.instance.ref();

  //For getting Default Templates
  final templateDescRef =
      FirebaseDatabase.instance.ref().child('ContractDescription');

  final contractTemplateRef =
      FirebaseDatabase.instance.ref().child('ContractTemplate');

  Future<String> getData({required String templateName}) async {
    final snapshot = await templateDescRef.get();
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    String description = 'No Description';
    values.forEach(
      (key, data) {
        if (key == templateName) {
          description = data['description'];
        }
      },
    );
    return description;
  }

  Future<String> getTemplate({required String templateName}) async {
    final snapshot = await contractTemplateRef.get();
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    String template = 'No Template Found';
    values.forEach(
      (key, data) {
        if (key == templateName) {
          template = data['template'];
        }
      },
    );
    //print(template);
    return template;
  }

  //For getting Default Descriptions
  void setUser(
      {required String name,
      required String email,
      required String phoneNumber,
      required String cnic,
      required String id}) {
    databaseReference.child('Users').child(id).set(
      {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'cnic': cnic,
      },
    );
  }

  void setEditedTemplateForUser({required String value}) {
    String id = AuthService().getUid();
    databaseReference
        .child('Users')
        .child(id)
        .child('Contracts')
        .child('editedContracts')
        .set(
      {
        'template': value,
      },
    );
  }

  void setDefaultDescription() {
    databaseReference.child("ContractDescription").child('Rental').set(
      {
        'description':
            'An Operating Lease which is month-to-month and which is cancelable. Responsible Officer. The chief financial officer of the Borrower and any other officer of the Borrower designated by the chief financial officer to sign Borrowing Base Reports and Notices of Borrowing or Conversion. Restricted Payment. Any dividend, distribution, loan, advance, guaranty, extension of credit or other payment, whether in cash or property to or for the benefit of any Person who holds an equity interest in the Borrower or any of its Subsidiaries, whether or not such interest is evidenced by a security, and any purchase, redemption, retirement or other acquisition for value of any capital stock of the Borrower or any of its Subsidiaries, whether now or hereafter outstanding, or of any options, warrants or similar rights to purchase such capital stock or any security convertible into or exchangeable for such capital stock. Revolving Credit Assignment of Leases. A third amended and restated assignment of leases, dated the Closing Date, by the Borrower in favor of the Agent for the benefit of the Lenders, as amended, supplemented and in effect from time to time, and any supplement thereto',
      },
    );
    databaseReference.child("ContractDescription").child('Loan').set(
      {
        'description':
            'A formal Loan contract shall be entered into by the two parties at least 30 days prior to the date of the rental. Failure to comply with this provision and to make payment of the required rental fees by that date may, at the discretion of the Eagle agent, result in cancellation of the reservation and forfeiture of the deposit.',
      },
    );
    databaseReference.child("ContractDescription").child('Freelance').set(
      {
        'description':
            'A Freelance contract shall be entered into by the two parties at least 30 days prior to the date of the rental. Failure to comply with this provision and to make payment of the required rental fees by that date may, at the discretion of the Eagle agent, result in cancellation of the reservation and forfeiture of the deposit.',
      },
    );
  }

  //For getting Default Templates
  void setDefaultTemplate() {
    databaseReference.child("ContractTemplate").child('Rental').set(
      {
        'template':
            '  Duration of Agreement: 12 months\tFrom: Your name\n\n1: The monthly Rent shall be _______ per month.\n2: The monthly free lance fee shall be paid through the bank transfer.\n3: The Fee can be collected by the freelancer only.\n4: No other person can collect the fee.',
      },
    );
    databaseReference.child("ContractTemplate").child('Loan').set(
      {
        'template':
            '  Duration of Agreement: 10 months\tFrom: Your name\n\n1: The monthly percentage shall be _______ per month.\n2: The monthly free lance fee shall be paid through the bank transfer.\n3: The Fee can be collected by the freelancer only.\n4: No other person can collect the fee.',
      },
    );
    databaseReference.child("ContractTemplate").child('Freelance').set(
      {
        'template':
            '  Duration of Agreement: 2 months\tFrom: Your name\n\n1: The monthly amount shall be _______ per month.\n2: The monthly free lance fee shall be paid through the bank transfer.\n3: The Fee can be collected by the freelancer only.\n4: No other person can collect the fee.',
      },
    );
  }
}
