import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workshop7/service/formationservice.dart';
import 'package:workshop7/template/dialog/formationdialog.dart';
import 'package:workshop7/template/navbar.dart';

import '../entities/formation.dart';


class FormationScreen extends StatefulWidget {
  @override
  _FormationScreenState createState() => _FormationScreenState();
}

class _FormationScreenState extends State<FormationScreen> {


  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar('Formation'),
      body: FutureBuilder(
        future: getAllFormation(),
        builder: (BuildContext context , AsyncSnapshot snapshot){
          if(snapshot.hasData)
          {

            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount:snapshot.data.length ,
              itemBuilder: (BuildContext context, int index){
                print(index);
                print(snapshot.data[index]);
                return  Slidable(
                  key: Key((snapshot.data[index]['id']).toString()),
                  startActionPane:   ActionPane(
                    motion:  const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context)async {
                          showDialog(context: context, builder: (BuildContext context){

                            return FormationDialog(notifyParent: refresh,formation: Formation(snapshot.data[index]['duree'],snapshot.data[index]['nom'],snapshot.data[index]['id']),);
                          });
                          //print("test");
                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  endActionPane:  ActionPane(
                    motion: ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: ()async{
                      await deleteFormation(snapshot.data[index]['id']);
                      setState(()  {
                        snapshot.data.removeAt(index);

                      });
                    }),
                    children: [Container()],


                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30.0),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start ,
                          children: [

                            Row(
                              children: [
                                const Text("Formation : "),
                                Text(
                                  snapshot.data[index]['nom'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),

                              ],
                            ),
                            Text("Durée : ${snapshot.data[index]['duree']}"),],

                        ),

                      ),

                    ],
                  )
                  ,
                );
              }, separatorBuilder: (BuildContext context, int index) =>const Divider(
              thickness: 5.0,
            ),);
          }
          else{
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton:  FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: ()async {
          showDialog(context: context, builder: (BuildContext context){

            return FormationDialog(notifyParent: refresh,);

          });
          //print("test");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
