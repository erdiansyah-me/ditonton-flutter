part of 'tvseries_search_bloc.dart';

abstract class TvseriesSearchEvent extends Equatable {
  const TvseriesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends TvseriesSearchEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}