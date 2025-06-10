import 'package:equatable/equatable.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class GetAllNotesEvent extends HomeScreenEvent {
  const GetAllNotesEvent();

  @override
  List<Object?> get props => [];
}
