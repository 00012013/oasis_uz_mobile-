enum UserRole { USER, ADMIN }

extension UserRoleExtension on UserRole {
  String toStringValue() {
    switch (this) {
      case UserRole.USER:
        return 'USER';
      case UserRole.ADMIN:
        return 'ADMIN';
      default:
        throw ArgumentError('Invalid UserRole');
    }
  }
}
