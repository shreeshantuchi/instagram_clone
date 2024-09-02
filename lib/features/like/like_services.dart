import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';

class LikeServices {
  Future<void> likePost(Post post, ProfileModel profile) async {
    print("linking post");
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(post.postId)
        .collection("Likes")
        .doc(profile.uid)
        .set(profile.toMap());
  }

  Future<void> dislikePost(Post post, ProfileModel profile) async {
    print("dislinking post");
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(post.postId)
        .collection("Likes")
        .doc(profile.uid)
        .delete();
  }

  Future<List<ProfileModel>> getAllLikes(
      Post post, ProfileModel profile) async {
    final allLikesDocSnap = await FirebaseFirestore.instance
        .collection('Posts')
        .doc(post.postId)
        .collection("Likes")
        .get();
    final allLikes = allLikesDocSnap.docs;
    final listAllLikes = allLikes.map((element) {
      return ProfileModel.fromJson(element.data());
    }).toList();

    return listAllLikes;
  }

  Future<void> likeOperation(Post post, ProfileModel profile) async {
    try {
      final allLikes = await getAllLikes(post, profile);
      //print("got all likes");
      final ProfileModel hasLiled =
          allLikes.singleWhere((e) => e.uid == profile.uid);
      dislikePost(post, profile);
    } catch (e) {
      await likePost(post, profile);
    }
  }

  Future<bool> isPostLiked(Post post, ProfileModel profile) async {
    final allLikes = await getAllLikes(post, profile);
    final bool hasLiked = allLikes.any((element) {
      return element.uid == profile.uid;
    });

    return hasLiked;
  }
}
