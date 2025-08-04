import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pibd31_egorov_pmu/data/repositories/mock_repository.dart';
import '../../data/repositories/film_repository.dart';
import '../../domain/models/card.dart';
import '../details_page/details_page.dart';
import '../dialogs/show_dialog.dart';

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
  /*final searchController = TextEditingController();
  late Future<List<CardData>?> data;
  final repo = FilmRepository();
  bool isLoading = false;
  @override
  void initState() {
    data = repo.loadData(onError: (e) => showErrorDialog(context, error: e));
    isLoading = true;
    data.then((_) => setState(() {
      isLoading = false; // Остановить индикатор при завершении загрузки
    }));
    super.initState();
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
                setState( () {
                  data = repo.loadData(q: search);
                });
              },
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<CardData>?>(
                future: data,
                builder: (context, snapshot) => SingleChildScrollView(
                  child: snapshot.hasData
                      ?Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: snapshot.data?.map((data) {
                      return _MyCardWidget.formData(
                        data,
                        onLike: (bool isLiked) {
                          _showSnackBar(context, isLiked);
                        },
                        onTap: () => _navToDetails(context, data),
                      );
                    }).toList() ??
                        [],
                  )
                      :const CircularProgressIndicator(),
                ),
              ),
            ),
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
  }*/
  /*final searchController = TextEditingController();
  late Future<List<CardData>?> data;
  final repo = FilmRepository();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    data = repo.loadData(onError: (e) => showErrorDialog(context, error: e));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String search) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final newData = await repo.loadData(q: search, onError: (e) => showErrorDialog(context, error: e));
      setState(() {
        data = Future.value(newData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CardData>?>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка загрузки данных'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Нет данных'));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!.map((dataItem) {
                      return _MyCardWidget.formData(
                        dataItem,
                        onLike: (bool isLiked) => _showSnackBar(context, isLiked),
                        onTap: () => _navToDetails(context, dataItem),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
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
  }*/
  final searchController = TextEditingController();
  late Future<List<CardData>?> data;
  final repo = FilmRepository();
  Timer? _debounce;

  // Новые переменные для хранения данных
  List<CardData> _allData = [];
  List<CardData> _filteredData = [];

  @override
  void initState() {
    super.initState();
    // Загружаем все данные один раз
    repo.loadData(onError: (e) => showErrorDialog(context, error: e)).then((loadedData) {
      setState(() {
        _allData = loadedData ?? [];
        _filteredData = _allData; // изначально показываем все
        data = Future.value(_filteredData);
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String search) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      // Фильтруем локально по полю name
      final filtered = _allData.where((item) =>
          item.text.toLowerCase().contains(search.toLowerCase())
      ).toList();

      setState(() {
        _filteredData = filtered;
        data = Future.value(_filteredData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CardData>?>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка загрузки данных'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Нет данных'));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!.map((dataItem) {
                      return _MyCardWidget.formData(
                        dataItem,
                        onLike: (bool isLiked) => _showSnackBar(context, isLiked),
                        onTap: () => _navToDetails(context, dataItem),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
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
}

