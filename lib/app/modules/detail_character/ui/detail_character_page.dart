import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/bloc/detail_character_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/bloc/detail_character_state.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/widgets/card_comic_widget.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/widgets/card_more_information_hero_widget.dart';
import 'package:flutter_marvel_dev/app/modules/detail_comics/domain/models/info_comic_dom.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailCharacterPage extends StatefulWidget {
  const DetailCharacterPage({Key? key}) : super(key: key);

  @override
  State<DetailCharacterPage> createState() => _DetailCharacterPageState();
}

class _DetailCharacterPageState extends State<DetailCharacterPage> {
  late InfoCharacterDom characterDom;
  late DetailCharacterBloc characterBloc;
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    characterBloc = context.read<DetailCharacterBloc>();
    controller
        .addListener(() => characterBloc.scrollControllerListener(controller));
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final settings = ModalRoute.of(context)?.settings;
    characterDom = settings?.arguments as InfoCharacterDom;
    characterBloc.endPointComicsOfCharacter = characterDom.relatedComics;
    await characterBloc.init();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.removeListener(
        () => characterBloc.scrollControllerListener(controller));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle personaje de Marvel'),
        elevation: 0,
      ),
      body: BlocListener<DetailCharacterBloc, DetailCharacterState>(
        listener: (BuildContext context, DetailCharacterState state) async {
          if (state is DetailCharacterErrorState) {
            await Fluttertoast.showToast(
              msg:
                  "Ha sucedido un error al consultar los comics del personajes de Marvel",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child:
                        CardMoreInformationHeroWidget(character: characterDom)),
                const SizedBox(height: 30),
                BlocBuilder<DetailCharacterBloc, DetailCharacterState>(
                  builder: (BuildContext context, DetailCharacterState state) {
                    if (state is DetailCharacterInitState) {
                      return const SizedBox();
                    } else if (state is DetailCharacterErrorState) {
                      return const Center(
                          child: Text('Falló al encontrar comics'));
                    } else if (state is DetailCharacterLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DetailCharacterSuccessState) {
                      return StreamBuilder<List<InfoComicDom>?>(
                        stream: characterBloc.listDom.stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return const Center(
                                child: CircularProgressIndicator());
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * .29,
                            child: ListView.builder(
                              controller: controller,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: CardComicOfCharacter(
                                        comic: snapshot.data![index]),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(
                0,
                MediaQuery.of(context).size.height * .41,
                0,
              ),
              child: ValueListenableBuilder<bool>(
                valueListenable: characterBloc.loadingElements,
                builder: (ctx, snap, _) {
                  return Visibility(
                    visible: snap,
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 6)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
