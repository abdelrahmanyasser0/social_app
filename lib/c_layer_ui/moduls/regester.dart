import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/btm_nav_modules/home.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/login.dart';
import '../../b_layer_bloc/register/register_cubit.dart';
import '../../b_layer_bloc/register/register_states.dart';
class Register  extends StatelessWidget {

  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var passwordController =TextEditingController();
  var fromKey=GlobalKey<FormState>();
  bool isPassword=true;
  IconData suffix=Icons.visibility_outlined;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialRegisterCubit(),

      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener:(context,state)
        {
          if(state is CreateUserSuccessState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LogingScreen()), (route) => false);
          }
        },
        builder:(context,state)
        {
          return Scaffold(
            appBar:AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',
                          style:Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                          ,),
                        Text('Register now to communicate with friends',
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          )
                          ,),
                        const SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller:nameController ,
                          keyboardType:TextInputType.name,
                          onFieldSubmitted: (String value){
                            print(value);
                          },
                          decoration:const InputDecoration(
                            labelText:"User Name",
                            prefixIcon: Icon(
                                Icons.person
                            ),
                            border:OutlineInputBorder(),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return "Name must not be empty ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller:emailController ,
                          keyboardType:TextInputType.emailAddress,
                          onFieldSubmitted: (String value){
                            print(value);
                          },
                          decoration:const InputDecoration(
                            labelText:"email address",
                            prefixIcon: Icon(
                                Icons.email
                            ),
                            border:OutlineInputBorder(),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return "Email address must not be empty ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller:passwordController ,
                          keyboardType:TextInputType.visiblePassword,
                          obscureText:SocialRegisterCubit.get(context).isPassword ,
                          onFieldSubmitted: (value){
                          },
                          onTap: (){
                            SocialRegisterCubit.get(context).changIconRegister();
                          },
                          decoration:InputDecoration(
                            labelText:"password",
                            prefixIcon: const Icon(
                                Icons.lock
                            ),
                            suffixIcon:Icon(
                              SocialRegisterCubit.get(context).suffix,
                            ),
                            border:OutlineInputBorder(),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return "password must not be empty ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller:phoneController ,
                          keyboardType:TextInputType.phone,
                          onFieldSubmitted: (String value){
                            print(value);
                          },
                          decoration:const InputDecoration(
                            labelText:"Phone",
                            prefixIcon: Icon(
                                Icons.phone
                            ),
                            border:OutlineInputBorder(),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return "phone must not be empty ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height:20,
                        ),
                        ConditionalBuilder(
                          condition: state is!SocialRegisterLoadingState,
                          builder: (context)=> Container(
                            width:double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(onPressed: (){
                              if(fromKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(

                                  name:nameController.text,
                                  email: emailController.text,
                                  password:passwordController.text,
                                  phone:phoneController.text,

                                );
                              }
                            },
                              child: const Text("REGISTER",
                                style: TextStyle(
                                    color: Colors.white
                                ),),),
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

