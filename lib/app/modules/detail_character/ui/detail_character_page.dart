import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/bloc/detail_character_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/bloc/detail_character_state.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/widgets/card_more_information_hero_widget.dart';
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

  @override
  void initState() {
    characterBloc = context.read<DetailCharacterBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final settings = ModalRoute.of(context)?.settings;
    characterDom = settings?.arguments as InfoCharacterDom;
    super.didChangeDependencies();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: CardMoreInformationHeroWidget(character: characterDom)),
          ],
        ),
      ),
    );
  }
}
