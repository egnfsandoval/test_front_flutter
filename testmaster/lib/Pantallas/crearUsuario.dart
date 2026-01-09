import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class registroUsuario extends StatefulWidget{
  const registroUsuario({super.key});
  
  @override
  State<registroUsuario> createState() => _registroUsuario();
}

class _registroUsuario extends State<registroUsuario>{
final baseUrl = 'http://10.210.75.97:3000';
  final TextEditingController _contname1 = TextEditingController();
  final TextEditingController _contname2 = TextEditingController();
  final TextEditingController _contapell1 = TextEditingController();
  final TextEditingController _contapell2 = TextEditingController();
  final TextEditingController _contmail = TextEditingController();
  final TextEditingController _contpass = TextEditingController();

  void saveUser(){
  if(_contname1.text.isEmpty&&_contname2.text.isEmpty&&_contapell1.text.isEmpty&&_contapell2.text.isEmpty&&_contmail.text.isEmpty&&_contpass.text.isEmpty){
    Fluttertoast.showToast(
        msg: "Debe de Ingresar todos los campos",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
    );
  }else{
    Map<String,dynamic> request ={
      "nombre1": _contname1.text,
      "nombre2":_contname2.text,
      "apellido1": _contapell1.text,
      "apellido2": _contapell2.text,
      "email": _contmail.text,
      "password": _contpass.text
    };
    CallUserSave(request);
  }
    
  }

  Future<void> CallUserSave(Map<String,dynamic> request) async {
    var uri = Uri.parse("$baseUrl/usuarios");
    var response = await http.post(uri,body:request);

    if(response.statusCode == 201){
        Fluttertoast.showToast(
        msg: "Usuario almacenado con exito",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0,
    );
    cancelarUser();
    }
  }
  void cancelarUser(){
    _contname1.clear();
    _contname2.clear();
    _contapell1.clear();
    _contapell2.clear();
    _contmail.clear();
    _contpass.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('Registro de usuarios'),centerTitle: true,
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
              TextField(
                controller: _contpass,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: saveUser,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('Guardar'), 
                  ),
                  ElevatedButton(onPressed: cancelarUser,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  child: const Text('Cancelar'), 
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