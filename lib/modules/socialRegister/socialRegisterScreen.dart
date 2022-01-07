import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialHome.dart';
import 'package:socail/modules/socialRegister/socialResgisterCubit/cubit.dart';
import 'package:socail/modules/socialRegister/socialResgisterCubit/state.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/styles/colors.dart';



class SocialRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        builder: (context, state) {
          var nameController = TextEditingController();
          var emailController = TextEditingController();
          var passwordController = TextEditingController();
          var phoneController = TextEditingController();

          var formKey = GlobalKey<FormState>();
          var cubit = SocialRegisterCubit.get(context);

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
                        'REGISTER',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Register To Communicate Your Friends ',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      sharedTextFormField(
                        iconColor: colorApp,
                        controller: nameController,
                        prefixIcon: Icons.person,
                        text: "User Name",
                        validate: (String value) {
                          if (value.isEmpty) return "User Name can not be empty";
                          return null;
                        },
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15,
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
                        height: 15,
                      ),
                      sharedTextFormField(
                        iconColor: colorApp,
                        controller: phoneController,
                        prefixIcon: Icons.phone,
                        text: "Phone",
                        validate: (String value) {
                          if (value.isEmpty) return "Phone can not be empty";
                          return null;
                        },
                        type: TextInputType.phone,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
                        builder: (context) => sharedMaterialButton(
                            pressed: () {
                              if (formKey.currentState.validate()) {
                                cubit.register(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  cover: 'https://www.pngfind.com/pngs/m/225-2255254_blank-facebook-cover-paper-product-hd-png-download.png',
                                  image: 'https://st3.depositphotos.com/1767687/17621/v/1600/depositphotos_176214104-stock-illustration-default-avatar-profile-icon.jpg',
                                  bio: 'Write Your Bio ....',
                                );
                              }
                            },
                            txt: "Register",
                            isUppercase: true,
                            radius: 20,
                            background: colorApp),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState)
            {
              navigateAndReplace(context: context, screen: SocialHome());
            }
        },
      ),
    );
  }
}
