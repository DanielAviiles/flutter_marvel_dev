import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/widgets/show_error_msg_widget.dart';
import 'package:flutter_marvel_dev/app/modules/search/ui/bloc/search_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/search/ui/bloc/search_state.dart';
import 'package:flutter_marvel_dev/app/modules/search/ui/widgets/card_search_hero_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ScrollController scrollController;
  late SearchBloc searchBloc;
  late TextEditingController controller;

  @override
  void initState() {
    scrollController = ScrollController();
    controller = TextEditingController();
    searchBloc = context.read<SearchBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          autofocus: true,
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Nombre heroe',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onFieldSubmitted: (value) async {
            searchBloc.listDom.sink([]);
            if (value.isNotEmpty) {
              searchBloc.emitState(SearchState.loading());
              final listItems =
                  await searchBloc.executeSearchGetInfoCharacter(value: value);
              if (searchBloc.state is! SearchErrorState) {
                searchBloc.listDom.value!.addAll(listItems);
                searchBloc.listDom.sink(searchBloc.listDom.value);
                searchBloc.emitState(SearchState.success());
              }
            }
          },
        ),
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (BuildContext context, SearchState state) async {
          if (state is SearchErrorState) {
            await Fluttertoast.showToast(
              msg: "Ha sucedido un error al buscar el personajes de Marvel",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        },
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (BuildContext context, SearchState state) {
            if (state is SearchInitState) {
              return const Center(child: Text('Sin busquedas'));
            } else if (state is SearchLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SearchErrorState) {
              return ShowErrorMsgWidget();
            } else if (state is SearchSuccessState) {
              return _renderFindCharacters(context, searchBloc);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _renderFindCharacters(BuildContext context, SearchBloc searchBloc) {
    return StreamBuilder<List<InfoCharacterDom>?>(
      stream: searchBloc.listDom.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .86,
            child: (snapshot.data!.isEmpty && controller.text.isNotEmpty)
                ? Center(child: Text('No se encontrarón resultados'))
                : ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (ctx, idx) => Divider(),
                    itemBuilder: (ctx, idx) =>
                        CardSearchHeroWidget(character: snapshot.data![idx]),
                  ),
          ),
        );
      },
    );
  }
}
