import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pibd31_egorov_pmu/data/repositories/mock_repository.dart';
import '../../components/utils/debounce.dart';
import '../../data/repositories/film_repository.dart';
import '../../domain/models/card.dart';
import '../details_page/details_page.dart';
import '../dialogs/show_dialog.dart';
import 'bloc/bloc.dart';
import 'bloc/events.dart';
import 'bloc/state.dart';

part 'card.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white70,
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final searchController = TextEditingController();
  /*late Future<List<CardData>?> data;
  final repo = FilmRepository();
  bool isLoading = false;*/
  final scrollController = ScrollController();

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
    scrollController.addListener(_onNextPageListener);
    super.initState();
  }

  void _onNextPageListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      // preventing multiple pagination request on multiple swipes
      final bloc = context.read<HomeBloc>();
      if (!bloc.state.isPaginationLoading) {
        bloc.add(HomeLoadDataEvent(
          search: searchController.text,
          nextPage: bloc.state.data?.nextPage,
        ));
      }
    }
  }

  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: (search) {
                Debounce.run(() => context.read<HomeBloc>().add(HomeLoadDataEvent(search: search)));
              },
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.error != null
                ? Text(
              state.error ?? '',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.red),
            )
                :state.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: state.data?.data?.length ?? 0,
                  itemBuilder: (context, index){
                    final data = state.data?.data?[index];
                    return data != null
                        ? _MyCardWidget.formData(
                      data,
                      onLike: (bool isLiked) {
                        _showSnackBar(context, isLiked);
                      },
                      onTap: () => _navToDetails(context, data),
                    )
                        : const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.isPaginationLoading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Вы ${isLiked ? 'лайкнули карточку' : 'убрали лайк с карточки'}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Colors.teal,
        duration: const Duration(seconds: 2),
      ));
    });
  }

  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }

  Future<void> _onRefresh(){
    context.read<HomeBloc>().add(HomeLoadDataEvent(search: searchController.text));
    return Future.value(null);
  }
}

