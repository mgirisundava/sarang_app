// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'people_loved_bloc.dart';

@immutable
abstract class PeopleLovedEvent {}

class OnPeopleLovedCalledEvent extends PeopleLovedEvent {}

class AddPeopleLoved extends PeopleLovedEvent {
  final UserModel user;

  AddPeopleLoved({required this.user});
}

class DeletePeopleLoved extends PeopleLovedEvent {
  final UserModel user;

  DeletePeopleLoved({required this.user});
}
