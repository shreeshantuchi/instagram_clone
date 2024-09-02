import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/followUser/data/dataSource/follower_datasource.dart';
import 'package:login_token_app/features/followUser/data/model/follow_model.dart';

class FollowUserDataSourceImpl implements FollowUserDataSource {
  @override
  Future<void> followUser(
      {required FollowModel user, required FollowModel userFollow}) async {
    print(user.email);
    await FirebaseFirestore.instance
        .collection("Profile")
        .doc(userFollow.uid)
        .collection("Followers")
        .doc(user.uid)
        .set(user.toMap());
    //increasing the number of post
    await FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.uid)
        .update({
      'followingCount': FieldValue.increment(1),
    });
    await FirebaseFirestore.instance
        .collection('Profile')
        .doc(userFollow.uid)
        .update({
      'followerCount': FieldValue.increment(1),
    });
  }

  @override
  Future<void> unfollowUser(
      {required FollowModel user, required FollowModel userFollow}) async {
    print(userFollow.uid);
    await FirebaseFirestore.instance
        .collection("Profile")
        .doc(userFollow.uid)
        .collection("Followers")
        .doc(user.uid)
        .delete();

    await FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.uid)
        .update({
      'followingCount': FieldValue.increment(-1),
    });
    await FirebaseFirestore.instance
        .collection('Profile')
        .doc(userFollow.uid)
        .update({
      'followerCount': FieldValue.increment(-1),
    });
  }

  @override
  Future<bool> doesFollowerExist(String userId, String followerId) async {
    DocumentSnapshot followerDoc = await FirebaseFirestore.instance
        .collection("Profile")
        .doc(followerId)
        .collection("Followers")
        .doc(userId)
        .get();

    return followerDoc.exists;
  }
}
