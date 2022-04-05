import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../all_login_cubit/login.dart';
import '../cubit/cubit.dart';
import '../network/local/cashhelper.dart';

Color DefaultColor=Colors.indigo;
void NavTo(context,Widget)=>Navigator.push(context,
    MaterialPageRoute(builder: (contex)=>Widget));

void LogOut(context)=> CashHelper.RemoveData(key: 'token').then((value) {
  if (value){
    NavAndFinish(context, LoginScreen());
  }
});

void NavAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=>Widget), (route) => false);

Widget BuildListProductItem(
    model,
    {
      bool isOldPrice=true
    })=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(alignment: Alignment.bottomLeft,
            children:[
              //
              Image(image: NetworkImage('${model!.image}'),
                height: 120,
                width: 120,
              ),
              // model.discount!=0
              if(model.discount!=0&& isOldPrice)
                Container(
                  padding:const EdgeInsets.symmetric(
                      horizontal: 5
                  ),
                  color: Colors.red,
                  child: const Text('DISCOUNT',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
            ]
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text('${model.name} ',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const Spacer(),
              Row(
                children: [
                  //
                  Text('${model.price}',
                    style: TextStyle(
                      color: DefaultColor,

                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //
                  if (model.discount!=0&&isOldPrice)
                  //
                    Text('${model.oldPrice}',
                      style:const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  const Spacer(),
                  // CircleAvatar(
                  //   radius: 15,
                  //   // ShopCubit.get(context).favoriets[ model.id]==true?Colors.red:Colors.grey,
                  //   backgroundColor: ShopCubit.get(context).favoriets[ model.id]==true?Colors.red:Colors.grey,
                  //   child: IconButton(
                  //       onPressed: (){
                  //         ShopCubit.get(context).ChangeFavIcon(model.id);
                  //       }, icon:const Icon(
                  //     Icons.favorite_border,
                  //     size:15,
                  //     color: Colors.white ,
                  //   )),
                  // )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
Widget BuildFavItem( model,context)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(alignment: Alignment.bottomLeft,
            children:[
              //
              Image(image: NetworkImage('${model!.image}'),
                height: 120,
                width: 120,
              ),
              // model.discount!=0
              if(model.discount!=0)
                Container(
                  padding:const EdgeInsets.symmetric(
                      horizontal: 5
                  ),
                  color: Colors.red,
                  child: const Text('DISCOUNT',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
            ]
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text('${model.name} ',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const Spacer(),
              Row(
                children: [
                  //
                  Text('${model.price}',
                    style: TextStyle(
                      color: DefaultColor,

                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //
                  if (model.discount!=0)
                  //
                    Text('${model.oldPrice}',
                      style:const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15,
                    // ShopCubit.get(context).favoriets[ model.id]==true?Colors.red:Colors.grey,
                    backgroundColor: ShopCubit.get(context).favoriets[ model.id]==true?Colors.red:Colors.grey,
                    child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).ChangeFavIcon(model.id);
                        }, icon:const Icon(
                      Icons.favorite_border,
                      size:15,
                      color: Colors.white ,
                    )),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onchange,
   validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  Function? suffixPressed,
  Function? onSubmit,
  var autoValidate = AutovalidateMode.onUserInteraction,
}) =>
    TextFormField(
      validator: validate,
      autovalidateMode: autoValidate,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onChanged: (value) {
        onchange;
      },
      onFieldSubmitted: (String value) {
        onSubmit!(value);
      },

      decoration: InputDecoration(
        labelText: label,
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        ),
      ),
    );

void  ShowToust({
  required String Text,
  required ToustStates state,

})=> Fluttertoast.showToast(
    msg: Text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ChooseToustColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToustStates{SUCSESS,ERROR,WARNNING}
Color ChooseToustColor(ToustStates state){
  Color color;
  switch(state){
    case ToustStates.SUCSESS:
      color = Colors.green;
    break;
    case ToustStates.ERROR:
      color= Colors.red;
    break;
    case ToustStates.WARNNING:
      color= Colors.amber;
    break;

  }
  return color;
}

 String?  token='';