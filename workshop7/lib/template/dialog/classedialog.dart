import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workshop7/entities/classe.dart';
import 'package:workshop7/entities/student.dart';
import 'package:workshop7/service/classeservice.dart';
import 'package:workshop7/service/studentservice.dart';


class ClassDialog extends StatefulWidget  {
  final Function()? notifyParent;
  Classe? classe;

  ClassDialog({@required this.notifyParent, this.classe});
  @override
  State<ClassDialog> createState() => _ClassDialogState();
}

class _ClassDialogState extends State<ClassDialog> {
  TextEditingController nomCtrl =TextEditingController();

  TextEditingController nbrCtrl =TextEditingController();



  String title = "Ajouter Classe";
  bool modif = false;

  late int idClasse ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.classe !=null)
    {
      modif=true;
      title = "Modifier Classe";
      nomCtrl.text = widget.classe!.nom;
      nbrCtrl.text=(widget.classe!.nbreEtud).toString();
      idClasse = widget.classe!.id!;
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
              controller:nbrCtrl ,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Champs est obligatoire";
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Nombre des etudiants"
              ),
            ),
            ElevatedButton(onPressed: ()async {
              if(modif == false)
              {
                await addClass(Classe(int.parse(nbrCtrl.text),nomCtrl.text));
                widget.notifyParent!();
              }
              else{
                await updateClasse(Classe(int.parse(nbrCtrl.text),nomCtrl.text,idClasse));
                widget.notifyParent!();
              }



            }, child: Text("Ajouter"))
          ],
        ),
      ),
    );
  }
}

