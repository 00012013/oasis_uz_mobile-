import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'image_management_state.dart';

class ImageManagementCubit extends Cubit<ImageManagementState> {
  ImageManagementCubit() : super(ImageManagementInitial());
  void addImage(List<Asset> imageFile) {
    final List<Asset> updatedImages = List<Asset>.from(state.images ?? [])
      ..addAll(imageFile);
    emit(ImageManagementLoaded(
      images: updatedImages,
      mainAttachmentList: state.mainAttachmentList,
    ));
  }

  void removeImage(int index) {
    if (state.images != null && index >= 0 && index < state.images!.length) {
      final List<Asset> updatedImages = List<Asset>.from(state.images!);
      updatedImages.removeAt(index);
      emit(ImageManagementLoaded(
        images: updatedImages,
        mainAttachmentList: state.mainAttachmentList,
      ));
    }
  }

  void addMainAttachment(Asset attachmentFile) {
    final List<Asset> updatedMainAttachments =
        List<Asset>.from(state.mainAttachmentList ?? [])..add(attachmentFile);
    emit(ImageManagementLoaded(
      images: state.images,
      mainAttachmentList: updatedMainAttachments,
    ));
  }

  void removeMainAttachment(int index) {
    if (state.mainAttachmentList != null &&
        index >= 0 &&
        index < state.mainAttachmentList!.length) {
      final List<Asset> updatedMainAttachments =
          List<Asset>.from(state.mainAttachmentList!);
      updatedMainAttachments.removeAt(index);
      emit(ImageManagementLoaded(
        images: state.images,
        mainAttachmentList: updatedMainAttachments,
      ));
    }
  }
}
