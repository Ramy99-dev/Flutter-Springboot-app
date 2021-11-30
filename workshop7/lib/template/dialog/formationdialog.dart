import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workshop7/entities/formation.dart';
import 'package:workshop7/entities/student.dart';
import 'package:workshop7/service/formationservice.dart';
import 'package:workshop7/service/studentservice.dart';


class FormationDialog extends StatefulWidget  {
  final Function()? notifyParent;
  Formation? formation;

  FormationDialog({@required this.notifyParent, this.formation});
  @override
  State<FormationDialog> createState() => _FormationDialogState();
}

class _FormationDialogState extends State<FormationDialog> {
  TextEditingController nomCtrl =TextEditingController();

  TextEditingController dureeCtrl =TextEditingController();




  String title = "Ajouter Formation";
  bool modif = false;

  late int idFormation ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.formation !=null)
    {
      modif=true;
      title = "Modifier Formation";
      nomCtrl.text = widget.formation!.nom;
      dureeCtrl.text=widget.formation!.duree.toString();
      idFormation = widget.formation!.id!;
    }

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(title),
            TextFormField(
              controller:nomCtrl ,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Champs est obligatoire";
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "nom"
              ),
            ),
            TextFormField(
              controller:dureeCtrl ,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Champs est obligatoire";
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Durée"
              ),
            ),
            ElevatedButton(onPressed: ()async {
              if(modif == false)
              {
                  await addFormation(Formation(int.parse(dureeCtrl.text),nomCtrl.text));

              }
              else{
                await updateFormation(Formation(int.parse(dureeCtrl.text),nomCtrl.text, idFormation));

              }
              widget.notifyParent!();

            }, child: Text("Ajouter"))
          ],
        ),
      ),
    );
  }
}
