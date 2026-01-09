import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:testmaster/Estructuras/models/comentarios.dart';
import 'package:testmaster/Pantallas/comentCreate.dart';
import 'package:testmaster/Pantallas/comentEdit.dart';

class comentHome extends StatefulWidget{
  final String nameUser;
   int idUsuario;
   comentHome({super.key, required this.idUsuario, required this.nameUser});
  
  
  @override
  State<comentHome> createState() => _comentHome();
}

class _comentHome extends State<comentHome>{
final baseUrl = 'http://10.210.75.97:3000';
late List<Comentarios> listUserComent =<Comentarios>[] ;

   @override
  void initState() {
    getUserComment(widget.idUsuario);
    setState(() {});
    super.initState();
  }

   Future<void> getUserComment(int idUser) async {
    var uri = Uri.parse("$baseUrl/comentarios/user/$idUser");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      listUserComent = comentariosFromJson(response.body);
      print(listUserComent.length);
      setState(() {});
    }
    
  }

  Future<void> deleteComent(int idComent ) async{
    var uri = Uri.parse("$baseUrl/comentarios/$idComent");
    var response = await http.delete(uri);

    if(response.statusCode == 200){
       Fluttertoast.showToast(
        msg: "Comentario eliminado con exito",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
      );
      setState(() {getUserComment(widget.idUsuario);});
    }
    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:AppBar(
          title: Text('Comentarios del usuario '+widget.nameUser),centerTitle: true,
        ) ,
        body: ListView.builder(
          itemCount: listUserComent.length,
          itemBuilder: (context,index){
            return Container(
                      width: 70,
                      height: 150,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                          Center(
                            child: Row(
                              children: [
                                Text(listUserComent[index].contenido,style: TextStyle(color: Colors.blue,fontSize: 30),),
                              ],
                            ),
                            
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(onPressed:(){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>comentEdit(idComent: listUserComent[index].id),)
                            ).then((resultado){
                                  setState(() {getUserComment(widget.idUsuario);});
                            });
                          },child: Icon(Icons.create_sharp)),
                          SizedBox(width: 16),
                          FloatingActionButton(onPressed:(){
                            deleteComent(listUserComent[index].id);
                          },child: Icon(Icons.delete_forever)),
                          ]
                          )
                        ],
                      ),
                    );
          },
          ),
        floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context)=>comentCreate(idUsuario: widget.idUsuario,),)
            ).then((onValue)=>{
              setState(() {               
                getUserComment(widget.idUsuario);
              })
            });
            
        },
        tooltip: 'Agregar comentario',
        child: const Icon(Icons.add_comment),
      )
      );
  }

}

