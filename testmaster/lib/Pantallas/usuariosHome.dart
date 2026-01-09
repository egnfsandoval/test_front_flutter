import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testmaster/Estructuras/models/usuarios.dart';
import 'package:http/http.dart' as http;
import 'package:testmaster/Pantallas/comentHome.dart';
import 'package:testmaster/Pantallas/crearUsuario.dart';
import 'package:testmaster/Pantallas/modifiUser.dart';

class UsuariosHome extends StatefulWidget{
  const UsuariosHome({super.key});


@override
  State<UsuariosHome> createState() => _UsuariosHome();
}

class _UsuariosHome extends State<UsuariosHome>{

 late List<Usuarios> listUsuarios=<Usuarios>[];
 final baseUrl = 'http://10.210.75.97:3000';

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    var uri = Uri.parse("$baseUrl/usuarios");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      listUsuarios = usuariosFromJson(response.body);
      setState(() {});
    }
  }

   Future<void> deleteUser(int idUser ) async{
    var uri = Uri.parse("$baseUrl/usuarios/$idUser");
    var response = await http.delete(uri);

    if(response.statusCode == 200){
       Fluttertoast.showToast(
        msg: "Usuario eliminado con exito",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
      );
      setState(() {
        getUser();
      });
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:AppBar(
          title: Text('Usuarios'),centerTitle: true,
        ) ,
        body: ListView.builder(
          itemCount: listUsuarios?.length,
          itemBuilder: (context,index){
            //return cuadrado(data:listUsuarios[index]);
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
                              Text(listUsuarios[index].nombre1 +" "+ listUsuarios[index].apellido1+"\n"+listUsuarios[index].email,style: TextStyle(color: Colors.blue,fontSize: 30),),
                            ],
                          ),
                          
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(onPressed:(){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>modificarUsuario(idUsuario: listUsuarios[index].id),)
                          ).then((onValue)=>{
                            setState(() {
                              getUser();
                            })
                          });
                        },child: Icon(Icons.create_sharp)),
                        SizedBox(width: 16),
                        FloatingActionButton(onPressed:(){
                          deleteUser(listUsuarios[index].id);
                        },child: Icon(Icons.delete_forever)),
                        SizedBox(width: 16),
                        FloatingActionButton(onPressed:(){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>comentHome(idUsuario: listUsuarios[index].id,nameUser:listUsuarios[index].nombre1+" "+listUsuarios[index].apellido1),)
                          );
                        },child: Icon(Icons.comment))
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
            MaterialPageRoute(builder: (context)=>const registroUsuario(),)
            ).then((value)=>{
              setState(() {
                getUser();
              })
            });
            
        },
        tooltip: 'Agregar usuario',
        child: const Icon(Icons.add),
      )
      );
  }
 }
  
  

class cuadrado extends StatefulWidget{
  const cuadrado({super.key,required this.data});
 final Usuarios data;
  
  @override
  State<cuadrado> createState() => _MyHomePageRec();
  
}

class _MyHomePageRec extends State<cuadrado>{

final baseUrl = 'http://10.210.75.97:3000';
  Future<void> deleteUser(int idUser ) async{
    var uri = Uri.parse("$baseUrl/usuarios/$idUser");
    var response = await http.delete(uri);

    if(response.statusCode == 200){
       Fluttertoast.showToast(
        msg: "Usuario eliminado con exito",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
      );
      
    }
    
  }

  @override
  Widget build(BuildContext context) {
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
                Text(widget.data.nombre1 +" "+ widget.data.apellido1+"\n"+widget.data.email,style: TextStyle(color: Colors.blue,fontSize: 30),),
              ],
            ),
            
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed:(){
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=>modificarUsuario(idUsuario: widget.data.id),)
            );
          },child: Icon(Icons.create_sharp)),
          SizedBox(width: 16),
          FloatingActionButton(onPressed:(){
            deleteUser(widget.data.id);
          },child: Icon(Icons.delete_forever)),
          SizedBox(width: 16),
          FloatingActionButton(onPressed:(){
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=>comentHome(idUsuario: widget.data.id,nameUser:widget.data.nombre1+" "+widget.data.apellido1),)
            );
          },child: Icon(Icons.comment))
          ]
          )
        ],
      ),
    );
    
  }
 
}
