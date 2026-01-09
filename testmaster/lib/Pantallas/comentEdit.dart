import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:testmaster/Estructuras/models/comentarios.dart';
import 'package:testmaster/Estructuras/models/usuarios.dart';


class comentEdit extends StatefulWidget{
  
  int idComent;
   comentEdit({super.key,required this.idComent});
  @override
  State<comentEdit> createState() => _comentEdit();
}

class _comentEdit extends State<comentEdit>{

  final baseUrl = 'http://10.210.75.97:3000';
  late Comentarios comentario;
  final TextEditingController _contcoment = TextEditingController();
  
  
   
   @override
  void initState() {
    getComent(widget.idComent);
    super.initState();
  }

  void saveUserUpdate(){
    if((_contcoment.text.isEmpty||_contcoment.text=='')){
    Fluttertoast.showToast(
        msg: "El comentario no puede estar vacio",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13.0,
    );
  }else{
    Map<String,dynamic> request ={
      "contenido": _contcoment.text
    };
    saveUdateUser(request,widget.idComent);
  }
  }

  Future<void> getComent(int idcoment) async{
    var uri = Uri.parse("$baseUrl/comentarios/$idcoment");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      comentario = comentarioFromJson(response.body);
      _contcoment.text = comentario.contenido;
      
    }
  }
   Future<void> saveUdateUser(Map<String,dynamic> request,int idComent) async{
    var url = Uri.parse("$baseUrl/comentarios/$idComent");
    var response = await http.patch(url,body:request);
    if(response.statusCode == 200){
      print(response.body);
        Fluttertoast.showToast(
        msg: "Comentario modificado con exito",
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
          title: Text('Editar comentario'),centerTitle: true,
        ) ,
        body: Padding(padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              TextField(
                controller: _contcoment,
                minLines: 1, // Start with one line
                maxLines: 6, // Expand up to 5 lines, then scroll
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Comentario',
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