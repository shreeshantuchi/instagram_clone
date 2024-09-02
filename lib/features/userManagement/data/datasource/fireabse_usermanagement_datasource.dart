import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';

abstract class FireabseUsermanagementDatasource {
  Future<void> setProfile();
  Future<ProfileModel> getCurrentUser();
  Future<List<ProfileModel>> getAllUser();
  List<ProfileModel> profileModelList = [];
  Future<ProfileModel> getProfile(String uid);
}

class FireBaseUserManagementDatasourceImpl
    implements FireabseUsermanagementDatasource {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  List<ProfileModel> profileModelList = [];
  @override
  Future<ProfileModel> getCurrentUser() async {
    final ProfileModel userModel;
    final user = auth.currentUser;
    if (user != null) {
      final currentProfile = await firestore
          .collection("Profile")
          .where(FieldPath.documentId, isEqualTo: user.uid)
          .get();
      userModel = ProfileModel.fromJson(
        currentProfile.docs.first.data(),
      );
      return userModel;
    } else {
      throw Exception('user loading failed');
    }
  }

  @override
  Future<void> setProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    final profile = ProfileModel.fromFirebaseUser(user!);
    profile.username = user.email!.split("@").first;
    print(profile.username);
    await firestore.collection('Profile').doc(profile.uid).set(profile.toMap());
  }

  @override
  Future<List<ProfileModel>> getAllUser() async {
    final querySnapshot = await firestore.collection('Profile').get();
    final docSnapshot = querySnapshot.docs;
    profileModelList = docSnapshot.map((element) {
      return ProfileModel.fromJson(element.data());
    }).toList();
    return profileModelList;
  }

  Future<ProfileModel> getProfile(String uid) async {
    final querySnapshot = await firestore
        .collection('Profile')
        .where("uid", isEqualTo: uid)
        .get();
    final docSnapshot = querySnapshot.docs;
    final profileModel = ProfileModel.fromJson(docSnapshot.first.data());
    return profileModel;
  }
}
