import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/bloc/home_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/bloc/home_state.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/widgets/card_hero_widget.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/widgets/show_error_msg_widget.dart';
import 'package:flutter_marvel_dev/app/routes/app_routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;
  late HomeBloc homeBloc;

  @override
  void initState() {
    scrollController = ScrollController();
    homeBloc = context.read<HomeBloc>();
    scrollController
        .addListener(() => homeBloc.scrollControllerListener(scrollController));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(
        () => homeBloc.scrollControllerListener(scrollController));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes de Marvel'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.searchHero);
            },
          )
        ],
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) async {
          if (state is HomeErrorState) {
            await Fluttertoast.showToast(
              msg: "Ha sucedido un error al consultar personajes de Marvel",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            if (state is HomeInitState) {
              return const SizedBox();
            } else if (state is HomeLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeErrorState) {
              return ShowErrorMsgWidget(onRefresh: () async {
                await homeBloc.init();
              });
            } else if (state is HomeSuccessState) {
              return _renderViewCharacters(context, homeBloc);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _renderViewCharacters(BuildContext context, HomeBloc homeBloc) {
    return StreamBuilder<List<InfoCharacterDom>?>(
      stream: homeBloc.listDom.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: IntrinsicGridView.vertical(
                  padding: EdgeInsets.all(12).copyWith(top: 16),
                  verticalSpace: 10,
                  horizontalSpace: 10,
                  children: [
                    for (final character in snapshot.data!)
                      CardHeroWidget(character: character),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: homeBloc.loadingElements,
              builder: (context, value, child) => Visibility(
                  visible: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: CircularProgressIndicator()),
                  )),
            )
          ],
        );
      },
    );
  }
}
