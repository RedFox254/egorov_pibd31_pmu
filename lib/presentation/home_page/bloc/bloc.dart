import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pibd31_egorov_pmu/data/repositories/film_repository.dart';
import 'package:pibd31_egorov_pmu/presentation/home_page/bloc/events.dart';
import 'package:pibd31_egorov_pmu/presentation/home_page/bloc/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final FilmRepository repo;
  HomeBloc(this.repo) : super(const HomeState()){
    on<HomeLoadDataEvent>(_onLoadData);
  }
  void _onLoadData(HomeLoadDataEvent event, Emitter<HomeState> emit) async{
    if(event.nextPage == null) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }
    String? error;
    final data = await repo.loadData(
      q: event.search,
      page: event.nextPage ?? 1,
      onError: (e) => error = e,
    );
    if (event.nextPage != null){
      data?.data?.insertAll(0, state.data?.data ?? []);
    }
    emit(state.copyWith(
      data: data,
      isLoading: false,
      isPaginationLoading: false,
      error: error,
    ));
  }
}
