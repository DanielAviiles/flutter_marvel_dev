import 'package:flutter/material.dart';

class ShowErrorMsgWidget extends StatelessWidget {
  const ShowErrorMsgWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.orangeAccent.shade200,
          size: 40,
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'Error al cargar datos de personajes',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
