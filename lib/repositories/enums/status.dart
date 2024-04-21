enum Status { APPROVED, DECLINED, PENDING }

extension StatusExtension on Status {
  String toStringValue() {
    switch (this) {
      case Status.APPROVED:
        return 'APPROVED';
      case Status.DECLINED:
        return 'DECLINED';
      case Status.PENDING:
        return 'PENDING';
      default:
        throw ArgumentError('Invalid Cottage Status');
    }
  }
}
