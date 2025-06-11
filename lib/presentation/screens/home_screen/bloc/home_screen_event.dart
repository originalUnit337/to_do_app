import 'package:equatable/equatable.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object?> get props => [];
}

class GetAllNotesEvent extends HomeScreenEvent {
  const GetAllNotesEvent();
}
