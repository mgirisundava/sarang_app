// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'explore_people_bloc.dart';

@immutable
abstract class ExplorePeopleState {}

class ExplorePeopleInitial extends ExplorePeopleState {}

class ExplorePeopleLoading extends ExplorePeopleState {}

class ExplorePeopleError extends ExplorePeopleState {}

class ExplorePeopleSuccess extends ExplorePeopleState {
  final List<UserModel> result;

  ExplorePeopleSuccess(this.result);
}
