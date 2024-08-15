import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_token_app/features/authentication/data/models/user_model.dart';

abstract class FirebaseAUthDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String email, String password);
  UserModel getCurrentUser();

  Future<void> signout();
  Future<void> verifyEmail();
  Future<void> updateUser(UserModel user);
}

class FirebaseAUthDataSourceImpl implements FirebaseAUthDataSource {
  final firebase = FirebaseAuth.instance;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final UserModel userModel;
      final firebaseCredentiaL = await firebase.signInWithEmailAndPassword(
          email: email, password: password);
      final user = firebaseCredentiaL.user;
      if (user != null) {
        userModel = UserModel.fromFirebaseUser(user);
        return userModel;
      }
    } catch (e) {
      print(e);
    }

    throw UnimplementedError();
  }

  @override
  Future<void> signout() async {
    await firebase.signOut();
  }

  @override
  Future<void> updateUser(UserModel user) {
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail() async {
    User? user = firebase.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      final UserModel userModel;
      final firebaseCredentiaL = await firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = firebaseCredentiaL.user;
      //print(user);
      if (user != null) {
        userModel = UserModel.fromFirebaseUser(user);
        return userModel;
      }
    } catch (e) {
      print(e);
    }
    throw UnimplementedError();
  }

  @override
  UserModel getCurrentUser() {
    User? user = firebase.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    } else {
      throw Exception("user doesnt exist");
    }
    // TODO: implement getCurrentuser
    throw UnimplementedError();
  }
}
