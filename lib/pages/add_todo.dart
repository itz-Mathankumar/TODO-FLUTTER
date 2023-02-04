import 'package:flutter/material.dart';

import 'package:todo/services/todo_service.dart';

import '../utils/snackbar_todo.dart';

class ADDTODO extends StatefulWidget {

  final Map? todo;

  const ADDTODO(
    {
      
      super.key,

      this.todo,
      
      }

    );

  @override

  State<ADDTODO> createState() => _ADDTODOState();

}

class _ADDTODOState extends State<ADDTODO> {

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  @override

  void initState()
  {

    super.initState();

    final todo =  widget.todo;

    if(todo != null)
    {

      isEdit = true;

      final title = todo['title'];

      final description = todo['description'];

      titleController.text = title;

      descriptionController.text = description;

    }
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar : AppBar(

        title : Text(
          
          isEdit ? 'EDIT TODO' : 'ADD TODO',
          
          ),

      ),

      body : ListView(

        children:[

          TextField(

            controller: titleController,

            decoration:const InputDecoration(hintText:"Title", contentPadding: EdgeInsets.all(5.0)),

          ),

          TextField(

            controller: descriptionController,

            decoration:const InputDecoration(hintText:'Description', contentPadding: EdgeInsets.all(5.0)),

            keyboardType: TextInputType.multiline,

            minLines: 5,
            
            maxLines: 8,

          ),

          const SizedBox(height: 20),

          ElevatedButton(
            
            onPressed: isEdit ? updateData : submitData, 
            
            child: Padding(

              padding: const EdgeInsets.all(16.0),

              child: Text(

              isEdit ? 'Update' : 'Submit',
              
              ),

            )
            
            ),

        ],

      ),
      
    );

  }

    Future<void> updateData() async {

    final todo = widget.todo;

    if(todo == null)
    {

      showErrorMessage(context, message:'Sorry no data to update');

      return;

    }

    final id = todo['_id'];

    final isSuccess = await TODOService.updateData(id, body);

    if(isSuccess)
    {
      
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message:'Successfully updated TODO');

    }else {

      // ignore: use_build_context_synchronously
      showErrorMessage(context, message:'Failed to update TODO');

    }

    }

  Future<void> submitData() async {

    final isSuccess = await TODOService.submitData(body);

    if(isSuccess)
    {

      titleController.text = "";

      descriptionController.text="";
      
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message:'Successfully created TODO');

    }else {

      // ignore: use_build_context_synchronously
      showErrorMessage(context, message:'Failed to create TODO');

    }

  }

  Map get body{

    final title = titleController.text;

    final description = descriptionController.text;

    return {

      "title":title,

      "description":description,

    };

  }

}