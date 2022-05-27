// import 'package:fyp/services/errorHandler.dart';
//
// class AuthService {
//   //check if user is authenticated
//   // handleAuthentiation() {
//   //   return StreamBuilder(
//   //     stream: FirebaseAuth.instance.authStateChanges(),
//   //     builder: (context, snapshot) {
//   //       if (snapshot.hasData) {
//   //         return const HomePage();
//   //       } else {
//   //         return const LoginScreen();
//   //       }
//   //     },
//   //   );
//   // }
//
// //Sign Up
//   // ignore: non_constant_identifier_names
//   static Future<String?> registerUserUsingEmailAndPassword(
//       String _email, String _password) async {
//     try {
//       UserCredential _credentials = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: _email, password: _password);
//       return "Success";
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         return 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         return 'The account already exists for that email.';
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   //Get Current Users ID
//   String getUid() {
//     return FirebaseAuth.instance.currentUser!.uid;
//   }
//
//   //Sign In
//   signIn(String email, String password, context) async {
//     await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password)
//         .then((value) => print('Logged In'))
//         .catchError((e) => ErrorHandler.errorDialogue(context, e));
//   }
//
//   //Sign OUT
//   signOut() {
//     FirebaseAuth.instance.signOut();
//   }
// }
