part of 'image_management_cubit.dart';

class ImageManagementState extends Equatable {
  final List<Asset> images;
  final List<Asset> mainAttachmentList;

  ImageManagementState({
    required this.images,
    required this.mainAttachmentList,
  });

  @override
  List<Object?> get props => [images, mainAttachmentList];
}

class ImageManagementInitial extends ImageManagementState {
  ImageManagementInitial() : super(images: [], mainAttachmentList: []);
}

class ImageManagementLoaded extends ImageManagementState {
  ImageManagementLoaded({
    required List<Asset> images,
    required List<Asset> mainAttachmentList,
  }) : super(images: images, mainAttachmentList: mainAttachmentList);
}
