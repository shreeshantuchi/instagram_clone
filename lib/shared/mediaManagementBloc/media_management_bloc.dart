import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_token_app/shared/mediaManagementBloc/media_management_event.dart';
import 'package:login_token_app/shared/mediaManagementBloc/media_management_state.dart';

class MediaManagementBloc
    extends Bloc<MediaManageMentEvent, MediaManagementState> {
  final ImagePicker _picker = ImagePicker();

  MediaManagementBloc() : super(MediaManagementInitial()) {
    on<SelectImageEvent>(
      (event, emit) async {
        try {
          final List<XFile> pickedFile = await _picker.pickMultiImage();

          if (pickedFile.isNotEmpty) {
            emit(OnMediaSelected(imageList: pickedFile));
          } else {
            emit(UserCanceledState());
          }
          // ignore: empty_catches
        } catch (e) {}
      },
    );

    on<SelectCameraEvent>(
      (event, emit) async {
        try {
          final List<XFile> pickedFile = [];
          XFile? imagePicked =
              await _picker.pickImage(source: ImageSource.camera);

          if (imagePicked != null) {
            pickedFile.add(imagePicked);
            emit(OnMediaSelected(imageList: pickedFile));
          } else {
            emit(UserCanceledState());
          }
          // ignore: empty_catches
        } catch (e) {}
      },
    );
    on<ResetMediaEvent>(
      (event, emit) async {
        emit(
          MediaManagementInitial(),
        );
      },
    );
  }
}
