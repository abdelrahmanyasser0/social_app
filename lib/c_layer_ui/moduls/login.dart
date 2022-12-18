import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_app_firebase/a_layer_data/cacheHelper.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/regester.dart';
import 'package:social_app_firebase/z_shared/componants.dart';
import '../../b_layer_bloc/login_cubit/cubit_login.dart';
import '../../b_layer_bloc/login_cubit/login_states.dart';
import 'layout_page.dart';
class LogingScreen extends StatelessWidget {
  LogingScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create:(BuildContext context)=>LoginCubit() ,
        child: BlocConsumer<LoginCubit,LoginStates>(
          listener:(context, state){
            if(state is LoginScreenError){
              showToast(text: state.error, state: ToastStates.ERROR);
            }
            if(state is LoginScreenSuccess){
              CacheHelper.saveData(key: 'uId', value: state.uId).
              then((value){
                navigatorAndFinish(context: context, widget: const AppLayoutPage());
              }).catchError((error){
                print(error.toString());
              });

            }
          }  ,
          builder: ((context, state) {
            var passController=TextEditingController();
            var emailController=TextEditingController();
            var cubit= LoginCubit.get(context);
            return Scaffold(
                appBar: AppBar(),
                body:Center(
                  child:  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Login',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 35),),
                            const SizedBox(height: 10,),
                            Text('login to communicat with friends',style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14),),

                            const SizedBox(height: 24,),
                            TextFormField(
                              controller: emailController=TextEditingController(),
                              validator: (value){
                                if(value!.isEmpty){
                                  return('filed can not be empty');
                                }
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'email',
                                  prefixIcon: Icon(Icons.email)
                              ),

                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: passController,
                              obscureText: cubit.isPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('filed can not be empty');
                                }
                              },
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon:IconButton(onPressed: (){
                                    cubit.passwordProcessTogel();
                                  },
                                    icon: Icon(cubit.suffix),
                                  ),
                              ),
                            ),
                            const SizedBox(height: 20,),

                            MaterialButton(
                              height: 50,
                              color: Colors.blue,
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  LoginCubit.get(context).logIn(
                                      email: emailController.text,
                                      password: passController.text);
                                }
                              },
                              child: Center(
                                  child: Text(
                                    'LogIn',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 24, color: Colors.white),
                                  )),
                            ),
                            Row(
                              children: [
                                const Text(' Don\'t have email ?'),
                                TextButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                                    },
                                    child: const Text('click here'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            );
          }),
        )
    );
  }
}
