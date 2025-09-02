import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalMessage extends StatefulWidget {
  final String name;
  const PersonalMessage({super.key, required this.name});

  @override
  State<PersonalMessage> createState() => _PersonalMessageState();
}

class _PersonalMessageState extends State<PersonalMessage> {
  
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (_,index){
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Text("hello"),
                  );
                },
              ),
            ),
           // SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(10),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: (){},
                  child: Icon(Icons.send,color: Colors.black,size: 30,),
                ),
              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
