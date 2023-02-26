import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:task_flutter_app/components/button/button_outline.dart';
import 'package:task_flutter_app/components/button/button_primary.dart';

class ConfirmBackdrop extends StatefulWidget {
  final String code;
  final Function confirm;
  final Function? cancel;

  const ConfirmBackdrop(
      {super.key, required this.code, required this.confirm, this.cancel});
  @override
  ConfirmBackdropState createState() => ConfirmBackdropState();
}

class ConfirmBackdropState extends State<ConfirmBackdrop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Icon(
                PhosphorIcons.warning_circle,
                color: Color(0xFFF46A6A),
                size: 44,
              ),
              const SizedBox(
                height: 22.75,
              ),
              _text("Excluir tarefa", Color(0xFFF46A6A), 16.0, FontWeight.w500),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Deseja realmente excluir a tarefa'),
                                    TextSpan(text:" ${widget.code}",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                    const TextSpan(text: "?"),
                                  ],
                                )
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 61,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: ButtonOutline(
                          text: "Cancelar",
                          onPressed: () {
                            if(widget.cancel!=null){
                              widget.cancel!();
                            }
                            Navigator.pop(context);
                          },
                          isEnable: true)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.44,
                    child: ButtonPrimary(
                        text: "Confirmar", onPressed: () async{
                         await widget.confirm();
                         Navigator.pop(context);
                    }, isEnable: true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*
  * Custom text in module
  * @param String text
  * @param String color
  * @param Double size
  * @param FontWeigth weight
  * return Widget
  */
  Widget _text(String text, Color color, double size, FontWeight weight) {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: weight));
  }
}
