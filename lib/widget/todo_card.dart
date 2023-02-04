import 'package:flutter/material.dart';

class TODOCARD extends StatelessWidget {

  final int index;

  final Map item;

  final Function(Map) navigateToEditTodo;

  final Function(String ) deleteById;

  const TODOCARD(

    {
    
    super.key,

    required this.index,

    required this.item,

    required this.navigateToEditTodo,

    required this.deleteById,
    
    }
    
    );

  @override

  Widget build(BuildContext context) {

    final id = item['_id'];

    return Card(

                child: ListTile(
                  
                leading: CircleAvatar(child: Text('${index+1}')),
                  
                title: Text(item['title']),
                  
                subtitle: Text(item['description']),
                      
                trailing: PopupMenuButton
                (
                      
                  onSelected: (value)
                  {
                      
                    if(value == 'edit')
                    {
                      
                      navigateToEditTodo(item);
                      
                    }
                    else if(value == 'delete')
                    {
                      
                      deleteById(id);
                      
                    }
                  },
                      
                  itemBuilder: (context) 
                  {
                      
                    return [
                      
                      const PopupMenuItem
                      (
                      
                        value: 'edit',
                      
                        child: Text('Edit'),
                      
                      ),
                      
                      const PopupMenuItem
                      (
                      
                        value: 'delete',
                      
                        child: Text('Delete'),
                      
                      ),
                      
                    ];               
                      
                  },
                      
                ),
                  
              ),
            );

  }

}