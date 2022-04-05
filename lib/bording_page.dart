
import 'package:flutter/material.dart';
import 'package:shop/network/local/cashhelper.dart';
import 'package:shop/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'all_login_cubit/login.dart';
class BordingScreen extends StatefulWidget {
  const BordingScreen({Key? key}) : super(key: key);

  @override
  _BordingScreenState createState() => _BordingScreenState();
}

class BordingModel{
  final String image;
  final String title;
  final String body;
  BordingModel({
    required this.image,
    required this.body,
    required this.title,

});
}
class _BordingScreenState extends State<BordingScreen> {
List<BordingModel>bording=[
  BordingModel(
      image: 'images/bording3.png',
      body: 'screen body1',
      title:'screen title1') ,
  BordingModel(
      image: 'images/bording4.png',
      body: 'screen body2',
      title:'screen title2') ,
  BordingModel(
      image: 'images/bording5.png',
      body: 'screen body3',
      title:'screen title3')
];
void Submit(){
  CashHelper.SaveData(key: 'onBording', value: true).then((value) {
    if (value){
      print('on Bording save true');
      NavAndFinish(
          context,
          LoginScreen());

    }
  });

}
var bordingController =PageController();
bool islast=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                Submit();
                },
              child: const Text('skip')
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: bordingController,
                onPageChanged: (int index){
                  if(index==bording.length-1){
                    setState(() {
                      islast=true;
                    });
                  }else {
                    setState(() {
                      islast=false;
                    });
                  }

                },
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Build_Bording_Item(bording[index]),
              itemCount: bording.length,
              ),
            ),
            const SizedBox(
        height: 40,),
            Row(
              children: [
          SmoothPageIndicator(
              controller: bordingController,
              effect:  ExpandingDotsEffect(
                dotColor: Colors.grey,
                 dotHeight: 10,
                activeDotColor: DefaultColor,
                dotWidth: 10
              ),
              count: bording.length),
               const Spacer(),
               FloatingActionButton(onPressed: (){
                 if(islast){
                   Submit();
                 }
                 else{
                   bordingController.nextPage(duration: const Duration(
                   milliseconds: 750,
                 ), curve: Curves.fastLinearToSlowEaseIn

                 );
                 }

                },
                child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
  Widget Build_Bording_Item(BordingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(
          // fit: BoxFit.contain,
          image: AssetImage('${model.image}',
          ),
          // height: 100,
        ),
      ),
      Text('${model.title}',
        style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text('${model.body}',
        style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),
      ),


    ],
  );
}
