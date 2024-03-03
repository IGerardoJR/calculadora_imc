import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  MyApp({Key? key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  double? _deviceWidth, _deviceHeight;
  double _valorSlider = 0;
  double _edad = 10.0;
  double _peso = 25.0;
  NumberFormat formatoDecimal = NumberFormat("##.#");
  // Funciones para el manejo de datos.
  // Aumentar
  void aumentarValor({required String llamadoPor}){
    setState(() {
      if(llamadoPor == 'Edad'){
        _edad+=1;
      }else if(llamadoPor == 'Peso'){
        _peso+=1;
      }
    });
  }

  void disminuirValor({required String llamadoPor}){
    setState(() {
      if(llamadoPor == 'Edad'){
        _edad = _edad - 1;
      }else if(llamadoPor == 'Peso'){
        _peso = _peso - 1 ;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('IMC', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:EdgeInsets.only(top:0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  _widgetGenero("Hombre",Icons.man),
                    _widgetGenero("Mujer",Icons.woman)
                  ],
                ),
              ),
              _widgetSlider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // _widgetGenero("Hombre",Icons.man),
                  _widgetDatos(edadPeso: 'Edad'),
                  _widgetDatos(edadPeso: 'Peso'),
                ],
              ),
              // btnCalcular
              SizedBox(
                width: _deviceWidth!,
                height: _deviceHeight! * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(248, 141, 145, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                  onPressed: () => {
                    print('Edad: $_edad y Peso: $_peso')
                  },
                  child: const Text('Calcular', style: TextStyle(color:Colors.white),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//   Widgets personalizos
Widget _widgetGenero(String textoGenero, IconData icono){
    return Container(
      decoration: BoxDecoration(
          color:Color.fromRGBO(139, 176, 230, 1.0),
        borderRadius: BorderRadius.circular(10)
      ),
      width: _deviceWidth! * 0.45,
      height: _deviceHeight! * 0.25,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icono, color: Colors.white,size: 50,),
          Text("$textoGenero",style: TextStyle(color:Colors.white, fontSize: 18),)
        ],

      ),
    );
}

Widget _widgetSlider(){
      return Container(
        decoration: BoxDecoration(
          color:Color.fromRGBO(139, 176, 230, 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        width: _deviceWidth,
        height: _deviceHeight! * 0.20,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Altura', style: TextStyle(fontSize: 20, color:Colors.white, fontWeight: FontWeight.w600),),
              Text('${formatoDecimal.format(_valorSlider)} cm', style: TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.w700,
              fontSize: 20),),
              // const Text('Un slider va aqui')
              Slider(
                  value: _valorSlider,
                  min: 0.0,
                  max: 250.0,
                  onChanged: (_) => {
                    setState(() {
                      _valorSlider = _;

                    })
                  })
            ],
          ),
        )
    );
}
  // Widget para almacenar la edad y peso de la persona
Widget _widgetDatos({required String edadPeso}){
    return Container(
      width: _deviceWidth! * 0.45,
      height: _deviceHeight! * 0.25,
      decoration: BoxDecoration(
        color: Color.fromRGBO(139, 176, 230, 1.0),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Text(
                 edadPeso,
               style: TextStyle(
                 color:Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.w500
               ),
             ),
            Text(
                edadPeso == 'Peso' ? _peso.toString() : _edad.toString(),
              style: TextStyle(color:Colors.white, fontSize: 20, fontWeight: FontWeight.w700),

            ),
            // rgb(250, 141, 146)
            // Aqui iran los botones de aumento.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color.fromRGBO(250, 141, 146, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    onPressed: () => edadPeso == 'Peso' ? aumentarValor(llamadoPor: 'Peso') : aumentarValor(llamadoPor: 'Edad'),
                    child: const Text('+',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(250, 141, 146, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    onPressed: () => edadPeso  == 'Peso' ? disminuirValor(llamadoPor: 'Peso') : disminuirValor(llamadoPor: 'Edad'),
                    child: const Text('-', style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                    ),))
              ],
            )

          ],
        ),
      ),

    );

}
}