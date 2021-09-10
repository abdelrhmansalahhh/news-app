import 'package:flutter/material.dart';
import 'package:news_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String image;
    final String title;

    final String body;
    BoardingModel({
    @required this.image,
        @required this.title,

    @required this.body


    });

}
 class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boarderController = PageController();

 List<BoardingModel>boarding=[
   BoardingModel(image: "assets/images/1.jpg", title: "on board 1", body: "body 1"),
      BoardingModel(image: "assets/images/2.jpg", title: "on board 2", body: "body 2"),
   BoardingModel(image: "assets/images/3.png", title: "on board 3", body: "body 3"),

 ];
 bool isLast= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function:  (){
                              navigateAndFinish(context,  ShopLoginScreen());

          },  
          text: "SKIP"),
           
         
        ],
      ),
      body:   Padding(padding: EdgeInsets.all(30),
      child:Column(
        children: [
          Expanded(child: PageView.builder(
            controller: boarderController,
            onPageChanged: (int index){
              if(index == boarding.length-1){
               setState(() {
                                isLast= true;
                              });
                print("last");
              }
              else {
                                print("not last");

                  setState(() {
                                isLast= false;
                              });
              }
            },
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildBoarderItem(boarding[index]),

          
          itemCount: boarding.length,
          )
          ),
                     SizedBox(height: 40),

          Row(
            children: [
               SmoothPageIndicator(controller:boarderController,
               count:boarding.length,
               effect: ExpandingDotsEffect(
                 dotColor: Colors.grey,
                 dotHeight: 10,
                 expansionFactor: 4,
                 dotWidth: 10,
                 spacing: 5,
                 activeDotColor: defaultColor,
               ),
               ),
                            Spacer(),
              FloatingActionButton(onPressed: (){
                if(isLast){
                  navigateAndFinish(context,  ShopLoginScreen());
                }else{
                                  boarderController.nextPage(duration: Duration(milliseconds:750,), curve: Curves.fastLinearToSlowEaseIn);

                }
               },
               child: Icon(Icons.arrow_forward_ios),
              )
              
            ],
          ),
        ],
      ) ,
      
      ),
     );
  }

Widget buildBoarderItem(BoardingModel model)=>Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Expanded(
            child:
              Image(image:AssetImage('${model.image}'),
               ),
           
          ),
           SizedBox(height: 30),
           Text("${model.title}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
           SizedBox(height: 30),
           Text("${model.body}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
           SizedBox(height: 30),


        ],
      );
}