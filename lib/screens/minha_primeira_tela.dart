import 'package:flutter/material.dart';

class MyFirstWidget extends StatelessWidget {
  const MyFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  color: Colors.redAccent,
                  height: 100,
                  width: 100,
                ),
                Container(
                  color: Colors.blueAccent,
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  color: Colors.blueAccent,
                  height: 100,
                  width: 100,
                ),
                Container(
                  color: Colors.redAccent,
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.orange,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.pinkAccent,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.purple,
                    height: 50,
                    width: 50,
                  ),
                ]),
            Container(
              color: Colors.amber,
              height: 30,
              width: 30000,
              child: const Text(
                "Diamante amarelo",
                style: TextStyle(color: Colors.black, fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  // print('Você apertou o botão');
                },
                child: const Text('Aperte o botão!'))
          ]),
    );
  }
}
