import 'package:dart_quote/string_quote.dart';
import 'package:flutter/material.dart';
import 'package:dart_quote/dart_quote.dart';
import '../main.dart';

class ResultadosPage extends StatelessWidget{
  double? _deviceWidth, _deviceHeight;
  // Resultados
  double? valorFinalImc = new MyApp().obtenerImc()!;
  String? veredictoFinal = new MyApp().obtenerVeredicto()!;


  ResultadosPage({Key? key});
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('RESULTADOS!', style: TextStyle(color:Colors.white, fontWeight: FontWeight.w400),),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Los resultados mostrados no deben\n ser tomados como punto final\n sobre la salud de una persona,\n acuda con su medico.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
              Text('IMC = $valorFinalImc'),
              Text('Conclusion: $veredictoFinal',style: TextStyle(fontWeight: FontWeight.w600)),
              StringQuote(text: "Es mejor prevenir que curar").quote(),
              _btnDevolverse(context),

            ],
          ),
        )
      ),
    );
  }
  // rgb(76, 175, 80)

  Widget _btnDevolverse(BuildContext context){
    return Container(
      width: _deviceWidth! * 0.90,
      height: _deviceHeight! * 0.08,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:Color.fromRGBO(76, 175, 80, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onPressed: () => {
          Navigator.pop(context)
        },
        child: const Text('Regresar a inicio', style: TextStyle(color:Colors.white),),
      ),
    );
  }
}