import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class comentCreate extends StatefulWidget{
  int idUsuario;
    comentCreate({super.key, required this.idUsuario});
  
  @override
  State<comentCreate> createState() => _comentCreate();
}

class _comentCreate extends State<comentCreate>{
 final baseUrl = 'http://10.210.75.97:3000';
  final TextEditingController _contcoment = TextEditingController();
  
  void saveComent(){
  if(_contcoment.text.isEmpty|| _contcoment.text == ''){
    Fluttertoast.showToast(
        msg: "Debe de texto en el comentario",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
    );
  }else{
    Map<String,dynamic> request ={
      "contenido": _contcoment.text,
      "usuario_id": widget.idUsuario.toString()
    };
    print(request);
    CallUserSave(request);
  }
    
  }

  Future<void> CallUserSave(Map<String,dynamic> request) async {
    var uri = Uri.parse("$baseUrl/comentarios");
    var response = await http.post(uri,body:request);

    if(response.statusCode == 201){
        Fluttertoast.showToast(
        msg: "Comentario agregado con exito",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0,
    );
    cancelarComent();
    }
  }
  void cancelarComent(){
    _contcoment.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('Nuevo Comentario'),centerTitle: true,
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
                  ElevatedButton(onPressed: saveComent,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('Guardar'), 
                  ),
                  ElevatedButton(onPressed: cancelarComent,
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