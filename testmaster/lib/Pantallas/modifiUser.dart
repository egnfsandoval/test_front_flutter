import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:testmaster/Estructuras/models/usuarios.dart';


class modificarUsuario extends StatefulWidget{
  
  int idUsuario;
   modificarUsuario({super.key,required this.idUsuario});
  @override
  State<modificarUsuario> createState() => _modificarUsuario();
}

class _modificarUsuario extends State<modificarUsuario>{

  final baseUrl = 'http://10.210.75.97:3000';
  late Usuarios usuario;
  final TextEditingController _contname1 = TextEditingController();
  final TextEditingController _contname2 = TextEditingController();
  final TextEditingController _contapell1 = TextEditingController();
  final TextEditingController _contapell2 = TextEditingController();
  final TextEditingController _contmail = TextEditingController();
  
   
   @override
  void initState() {
    getUser(widget.idUsuario);
    super.initState();
  }

  void saveUserUpdate(){
    if((_contname1.text.isEmpty||_contname1.text=='')||(_contapell1.text.isEmpty||_contapell1.text=='')||(_contmail.text.isEmpty||_contmail.text=='')){
    Fluttertoast.showToast(
        msg: "Debe de ingresar los campos: primer nombre, primer apellido y correo",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13.0,
    );
  }else{
    Map<String,dynamic> request ={
      "nombre1": _contname1.text,
      "nombre2":_contname2.text==''?null:_contname2.text,
      "apellido1": _contapell1.text,
      "apellido2": _contapell2.text==''?null:_contapell2.text,
      "email": _contmail.text
    };
    saveUdateUser(request,widget.idUsuario);
  }
  }

  Future<void> getUser(int idUser) async{
    var uri = Uri.parse("$baseUrl/usuarios/$idUser");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      usuario = usuarioFromJson(response.body);
      _contname1.text = usuario.nombre1;
      _contname2.text = usuario.nombre2==null?'':usuario.nombre2!;
      _contapell1.text = usuario.apellido1;
      _contapell2.text = usuario.apellido2==null?'':usuario.apellido2!;
      _contmail.text = usuario.email;
    }
  }
   Future<void> saveUdateUser(Map<String,dynamic> request,int idUser) async{
    var url = Uri.parse("$baseUrl/usuarios/$idUser");
    var response = await http.patch(url,body:request);
    if(response.statusCode == 200){
      print(response.body);
        Fluttertoast.showToast(
        msg: "Datos del usuario modificado con exito",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
    );
    }
   }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar:AppBar(
          title: Text('Modificación de usuario'),centerTitle: true,
        ) ,
        body: Padding(padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              TextField(
                controller: _contname1,
                decoration: const InputDecoration(
                  labelText: 'Primer Nombre',
                  border: OutlineInputBorder()
                ),
              ),
               const SizedBox(height: 10),
              TextField(
                controller: _contname2,
                decoration: const InputDecoration(
                  labelText: 'Segundo Nombre',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _contapell1,
                decoration: const InputDecoration(
                  labelText: 'Primer Apellido',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _contapell2,
                decoration: const InputDecoration(
                  labelText: 'Segundo Apellido',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _contmail,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: saveUserUpdate,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('Guardar'), 
                  ),
                ],
              )
              ],
        )
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: (){
            Navigator.pop(context);
          },  
          tooltip: 'Regresar',
          child: const Icon(Icons.arrow_back),
      )
      );
  }


}