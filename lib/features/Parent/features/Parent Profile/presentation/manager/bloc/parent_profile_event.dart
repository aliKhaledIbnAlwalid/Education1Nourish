part of 'parent_profile_bloc.dart';

@immutable
abstract class ParentProfileEvent extends Equatable {
  const ParentProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchParentProfile extends ParentProfileEvent {
  // final String userId;

  // const FetchParentProfile(this.userId);

  // @override
  // List<Object> get props => [userId];
}
