import 'package:flutter/material.dart';

import 'package:todo/pages/add_todo.dart';

import 'package:todo/services/todo_service.dart';

import '../utils/snackbar_todo.dart';

import '../widget/todo_card.dart';

class TODOLIST extends StatefulWidget {

  const TODOLIST({super.key});

  @override

  State<TODOLIST> createState() => _TODOLISTState();

}

class _TODOLISTState extends State<TODOLIST> { 

  bool isLoading = true;

  List items = [];

  @override

  void initState() {

    super.initState();

    fetchTodo();

  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(

        title: const Text('TODO LIST'),

        centerTitle: true,

      ),

      body: 
      
      Visibility(

        visible : isLoading,

        replacement : const Center(child: CircularProgressIndicator()),

        child : RefreshIndicator(
      
          onRefresh: fetchTodo,
      
          child: Visibility(

            visible: items.isNotEmpty,

            replacement: Center(
              
              child: Text( 'No TODO Found' ,
              
              style: Theme.of(context).textTheme.displaySmall,
              
              ),
              
              ),

            child: ListView.builder(       
            
            itemCount: items.length,

            padding: const EdgeInsets.all(8),
                
            itemBuilder: (context, index){
                
            final item = items[index] as Map;
                
            return TODOCARD(

              index: index,

              item: item,

              deleteById: deleteById,

              navigateToEditTodo: navigateToEditTodo,

            );
                
            },
                  
            ),

          ),
      
        ),

      ),

      floatingActionButton: FloatingActionButton.extended(
       
        onPressed: navigateToAddTodo,

         label: const Text('ADD TODO'),
         
         ) ,

    );

  }

  Future<void> navigateToAddTodo( ) async {

    final route = MaterialPageRoute(
      
    builder: (context) =>  const ADDTODO(),
    

    );

    await Navigator.push(context, route);

    setState(() 
    {
      
      isLoading = true;

    }
    
    );

    fetchTodo();
    
  }


  Future<void> navigateToEditTodo(Map item) async {

    final route = MaterialPageRoute(
      
    builder: (context) =>  ADDTODO(todo: item),
    

    );

    await Navigator.push(context, route);

    setState(() 
    {
      
      isLoading = true;

    }
    
    );

    fetchTodo();
    
  }

  Future<void> fetchTodo() async{

    final response = await TODOService.fetchTodo();

    if(response != null)
    {

      setState(() 
      {
        
        items = response;

      }
      
      );

    }else{

      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Something is Wrong Sorry');

    }

    setState(() 
    {
      
      isLoading = true;

    }
    
    );

  }

    Future<void> deleteById(String id) async{

    final isSuccess = await TODOService.deleteById(id);

    if(isSuccess)
    {

      final filtered = items.where((element) => element['_id'] != id).toList();

      setState( ( ) 
      {
        
        items = filtered;

      }

      );

    }
    else
    {

      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Deletion Failed');

    }

  }
  
}