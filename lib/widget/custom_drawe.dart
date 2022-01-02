import 'package:flutter/material.dart';
import 'package:qr_lite/cubit/Theme/theme_cubit.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
    required this.themeCubit,
  }) : super(key: key);

  final ThemeCubit themeCubit;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          Container(
            height: 240,
            color: Colors.blue,
          ),


          ListTile(
            onTap: (){},
            leading: const Icon(Icons.save_alt),
            title: const Text("Storage"),
            trailing: const Icon(Icons.arrow_right),
          ),

          SwitchListTile(
            title: Row(children: const [
              Icon(Icons.dark_mode_outlined),
              SizedBox(width: 32,),
              Text("Dark Mode")
            ],),


            
            value: widget.themeCubit.state.darkMode,
            onChanged: (value){

              widget.themeCubit.setDarkMode(value);
              setState(() {
                
              }); 

            } 
          ),
        ],
      ),
    );
  }
}