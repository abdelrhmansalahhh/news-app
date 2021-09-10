import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:news_app/modules/shop_app/register/shop_register_Screen.dart';
import 'package:news_app/shared/components/components.dart';

import 'cubit/state.dart';

class ShopLoginScreen extends StatelessWidget {
 var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
        var passwordController = TextEditingController();

    return BlocProvider(create: (BuildContext context)=>ShopLoginCubit(),
    child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context,state){},
      builder: (context,state){
          return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children:[
                  Text("LOGIN",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text("login now to browse our hpt offers",style:TextStyle(fontSize: 18,color: Colors.grey),),
                              SizedBox(height: 30,),
                              defaultFormField(
                                controller: emailController,
                               type: TextInputType.emailAddress,
                                validate: (String value){
                                  if(value.isEmpty)
                                  {
                                    return 'please enter your email address';
                                  }
                                },
                               label: 'Email Address',
                                prefix:  Icons.email_outlined),
                  SizedBox(height: 25,),
                                  defaultFormField(
                                controller: passwordController,
                               type: TextInputType.visiblePassword,
                               suffix: ShopLoginCubit.get(context).suffix,
                                onSubmit: (value) {
                            if (formkey.currentState.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                                isPassword: ShopLoginCubit.get(context).isPassword,

                               suffixPressed: (){
                                 ShopLoginCubit.get(context).changepasswordvisibility();
                               },
                                validate: (String value){
                                  if(value.isEmpty)
                                  {
                                    return 'password is too short';
                                  }
                                },
                               label: 'Password',
                                prefix:  Icons.lock_outline,),
                                                                      SizedBox(height: 25,),

                                  ConditionalBuilder(
                                    condition: state is! ShopLoginLoadingState, 
                                  builder: (context)=>defaultButton(function: (){
                                    if(formkey.currentState.validate()){
                                       ShopLoginCubit.get(context).userLogin(
                                       email: emailController.text, 
                                       password: passwordController.text,);
                                    }
                                     

                                  }, 
                                  text: 'Login',isUpperCase: true), 
                                  fallback:(context) =>Center(child:
                                  CircularProgressIndicator(), ), 
                                  ),
                                           SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                             Text("Don\'t have an account ?"),

                                                defaultTextButton(function: (){
                                                        
                                                navigateAndFinish(context,  ShopRegisterScreen());

                                                    }, 
                                                    text: 'Register',),
                                              
                                                    ],
                                                    ),

 
                                
                                ]),
            ),
          ),
        ),
      ),
    );
  }
      
    ),
    );
    
     
  }
  }