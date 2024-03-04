import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Pages
import './pages/resultados.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/resultados' : (context) => ResultadosPage()
    },
    home: MyApp(),
  )

  );
}

class MyApp extends StatefulWidget{
  MyApp({Key? key});
  // Getters
  double? obtenerImc(){
    return _MyAppState.valorImc!;
  }
  String? obtenerVeredicto(){
    return _MyAppState.veredicto!;
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  double? _deviceWidth, _deviceHeight;
  double _valorSlider = 150.0;
  double _edad = 30.0;
  double _peso = 80.0;
  String? _genero = "Hombre";
  double? _opacidadHombre = 1.0;
  double? _opacidadMujer = 0.65;
  NumberFormat formatoDecimal = NumberFormat("##.#");
  static double? valorImc = 0;
 static String? veredicto = "NA";
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

  // Calcular el imc

  // Formula = peso en kg / (altura * altura en metros)
  void calcularImc(double peso, double altura){
    double? imc;
    double alturaMetros = altura / 100;
    imc = peso / (alturaMetros * alturaMetros);
    valorImc  = double.parse(formatoDecimal.format(imc));
    if(valorImc! < 18.5){
      veredicto = "Inferior al peso normal";
    }else if(valorImc! >= 18.5 && valorImc! <= 24.9){
      veredicto = "Normal";
    }else if(valorImc! >= 25 && valorImc! <= 29.9){
      veredicto = "Sobrepeso";
    }else if(valorImc! >= 30 && valorImc! <= 34.9){
      veredicto = "Obesidad morbida clase 1";
    }else if(valorImc! >= 35 && valorImc! <= 39.9){
      veredicto = "Obesidad morbida clase 2";
    }else if(valorImc! >= 40){
      veredicto = "Obesidad morbida clase 3";
    }
  }
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
      ),
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
              const Text('Selecciona tu genero!', style: TextStyle(color:Colors.black, fontWeight: FontWeight.w500, fontSize: 18),),

              Padding(
                padding:EdgeInsets.only(top:0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  _widgetGeneroHombre(),
                    _widgetGeneroMujer()
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
                    calcularImc(_peso, _valorSlider),
                    Navigator.pushNamed(context, '/resultados')

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
Widget _widgetGeneroHombre(){
      return Opacity(
        opacity: _opacidadHombre!,
        child: TextButton(
          onPressed: () => {
            setState(() {
          _opacidadMujer = 0.65;
          _opacidadHombre = 1.0;
          _genero = "Hombre";
            })
          },

          child: Container(
            decoration: BoxDecoration(
                color:Color.fromRGBO(139, 176, 230, 1.0),
              borderRadius: BorderRadius.circular(10),
              border:Border.all(
                color: Colors.red,
                width: 2
              )
            ),
            width: _deviceWidth! * 0.40,
            height: _deviceHeight! * 0.25,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.man_2, color: Colors.white,size: 50,),
                Text("Hombre",style: TextStyle(color:Colors.white, fontSize: 18),)
              ],
            ),
              ),
        ),
      );
}

  Widget _widgetGeneroMujer(){
    return Opacity(
      opacity: _opacidadMujer!,
      child: TextButton(
        onPressed: () => {
          setState(() {
        _opacidadMujer = 1.0;
        _opacidadHombre = 0.65;
        _genero = "Mujer";
          })

        },

        child: Container(
          decoration: BoxDecoration(
              color:Color.fromRGBO(139, 176, 230, 1.0),
              borderRadius: BorderRadius.circular(10),
              border:Border.all(
                  color: Colors.pink,
                  width: 2
              )
          ),
          width: _deviceWidth! * 0.40,
          height: _deviceHeight! * 0.25,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.woman, color: Colors.white,size: 50,),
              Text("Mujer",style: TextStyle(color:Colors.white, fontSize: 18),)
            ],
          ),
        ),
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