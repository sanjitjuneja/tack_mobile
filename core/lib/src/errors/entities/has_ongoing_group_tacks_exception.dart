part of errors;

class HasOngoingGroupTacksException extends AppException {
  const HasOngoingGroupTacksException()
      : super(
          code: ErrorCode.hasOngoingGroupTacks,
          messageKey: 'errors.hasOngoingTacksInGroup',
        );
}
