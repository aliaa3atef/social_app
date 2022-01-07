import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialHome.dart';
import 'package:socail/modules/socialLogin/socialLoginCubit/cubit.dart';
import 'package:socail/modules/socialLogin/socialLoginCubit/state.dart';
import 'package:socail/modules/socialRegister/socialRegisterScreen.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/components/constants.dart';
import 'package:socail/shared/network/local/cashedHelper.dart';
import 'package:socail/shared/styles/colors.dart';



class SocialLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer< SocialLoginCubit, SocialLoginStates>(
          builder: (context, state) {
            var cubit = SocialLoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login To Communicate Your Friends ',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        sharedTextFormField(
                          iconColor: colorApp,
                          controller: emailController,
                          prefixIcon: Icons.email_outlined,
                          text: "Email Address",
                          validate: (String value) {
                            if (value.isEmpty)
                              return "Email address can not be empty";
                            return null;
                          },
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        sharedTextFormField(
                          iconColor: colorApp,
                          controller: passwordController,
                          prefixIcon: Icons.lock,
                          isPassword: cubit.isPassword,
                          suffixIcon: cubit.suffix,
                          suffixPressed: ()=> cubit.changeVisibilityIcon(),
                          text: "Password",
                          validate: (String value) {
                            if (value.isEmpty) return "password can not be empty";
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => sharedMaterialButton(
                            txt: "Login",
                            isUppercase: true,
                            radius: 20,
                            background: colorApp,
                              pressed: () {
                                if (formKey.currentState.validate()) {
                                  cubit.login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\’t Have An Account ? "),
                            sharedTextButton(
                                onPress: () {
                                  navigateTo(
                                      context: context,
                                      screen: SocialRegisterScreen());
                                },
                                text: "REGISTER NOW"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }, listener: (context, state) {
            if(state is SocialLoginSuccessState)
              {
                CashedHelper.setData(key: 'uId', value: state.uId).then((value){
                  uId = CashedHelper.saveData(key: 'uId');
                  navigateAndReplace(context: context, screen: SocialHome());
                });
              }
            if(state is SocialLoginErrorState)
              showToast(state.error.toString(), Colors.red, context);

      }
          ),
    );
  }
}
