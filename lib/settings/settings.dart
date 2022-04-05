import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubit.dart';
import 'package:shop/cubit/states.dart';
import 'package:shop/shared/components.dart';

class Settings_screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var model=ShopCubit.get(context).userModel;
          nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;

          return   ConditionalBuilder(
            condition:  ShopCubit.get(context).userModel != null,
            builder: (BuildContext context) =>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(

                      children: [
                      if(state is UpdateProfileDataLoadingState)
                             const LinearProgressIndicator(),
                       const SizedBox(height: 20,),
                        defaultFormField(

                         type: TextInputType.text,
                          controller: nameController,
                          label: 'Name',
                          prefix: Icons.person,


                        ),
                        const  SizedBox(
                          height: 40,
                        ),
                        defaultFormField(

                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email',
                          prefix: Icons.email,


                        ),
                        const  SizedBox(
                          height: 40,
                        ),
                        defaultFormField(

                          type: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone',
                          prefix: Icons.phone,
                          ),
                        const  SizedBox(
                          height: 40,
                        ),

                        Container(
                          height: 50,
                          width: double.infinity,
                          color: DefaultColor,
                          child: MaterialButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){ShopCubit.get(context).UpdateUserData(
                                email: emailController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              );
                              }

                            },
                            child: const Text('UPDATE',
                              style: TextStyle(
                                color: Colors.white,
                              ),),
                          ),
                        ),
                        const  SizedBox(
                          height: 50,
                        ),

                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.black,
                          child: MaterialButton(
                            onPressed: (){
                              LogOut(context);
                            },
                            child: const Text('LOG OUT',
                              style: TextStyle(
                                color: Colors.white,
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator(),),

          );
    },
    );




  }
}
