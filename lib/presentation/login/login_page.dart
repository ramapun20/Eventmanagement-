import 'package:event_buddy/presentation/bottom_navbar.dart';
import 'package:event_buddy/presentation/login/cubit/login_cubit.dart';
import 'package:event_buddy/presentation/register/registration_page.dart';
import 'package:event_buddy/utils/loading_dialog.dart';
import 'package:event_buddy/utils/popup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/constants/color_constants.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _registeredMobileNumberController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future login(
    String registeredMobileNumber,
    newPassword,
  ) async {
    context.read<LoginCubit>().login(
          registeredMobileNumber.trim(),
          newPassword.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          debugPrint('LoginLoading');
          buildLoadingDialog(context: context, title: "Logging In...");
        } else if (state is LoginFailure) {
          Navigator.of(context, rootNavigator: true).pop();
          PopUpProvider.showSnackBarMessage(context, state.msg);
          debugPrint('LoginFailure');
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          SchedulerBinding.instance.addPostFrameCallback((timestamp) {
            PopUpProvider.showSnackBarMessage(context, "You are logged in!!",
                isError: false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyBottomNavigationBar(
                        userResponse: state.user,
                      )),
            );
          });
        }
      },
      child: Scaffold(
        body: _getContentPage(height),
      ),
    );
  }

  Scaffold _getContentPage(double height) {
    return Scaffold(
      body: Container(
        color: ColorConstants.whiteColor,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 100),
              // Center(
              //     child: Padding(
              //   padding: const EdgeInsets.only(bottom: 20),
              //   child: Text(
              //     'Welcome to',
              //     style: TextStyle(
              //         color: ColorConstants.hintColor,
              //         fontWeight: FontWeight.w200,
              //         fontSize: 17),
              //   ),
              // )),
              // Container(
              //   height: 100,
              //   width: 184,
              //   child: Text(
              //     "Event Buddy",
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              Divider(
                color: ColorConstants.lineBorderColor,
                thickness: 0,
                height: 0.5,
                indent: 92.0,
                endIndent: 92.0,
              ),
              Padding(
                padding: const EdgeInsets.all(13),
                child: Text(
                  'EVENT BUDDY',
                  style: TextStyle(
                      color: ColorConstants.primaryAppColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 27),
                ),
              ),
              Divider(
                color: ColorConstants.lineBorderColor,
                thickness: 0,
                height: 0.5,
                indent: 92.0,
                endIndent: 92.0,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 36, right: 36),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              color: ColorConstants
                                  .blackColor, // Set the text color here
                            ),
                            cursorColor: ColorConstants.blackColor,
                            controller: _registeredMobileNumberController,
                            // keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: ColorConstants.blackColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: ColorConstants.hintColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: ColorConstants.blackColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: ColorConstants.hintColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: ColorConstants.blackColor,
                                ),
                              ),
                              // suffixStyle: TextStyle(
                              //     fontSize: 14.0,
                              //     height: 1,
                              //     color: ColorConstants.blackColor),
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  height: 1,
                                  color: ColorConstants.hintColor),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(
                              color: ColorConstants
                                  .blackColor, // Set the text color here
                            ),
                            cursorColor: ColorConstants.blackColor,
                            controller: _newPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              fillColor: ColorConstants.blackColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: ColorConstants.hintColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: ColorConstants.blackColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: ColorConstants.hintColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: ColorConstants.blackColor,
                                ),
                              ),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  height: 1,
                                  color: ColorConstants.hintColor),
                              focusColor: ColorConstants.blackColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 50, top: 20),
                child: InkWell(
                  onTap: () {
                    // navigator.push(MaterialPageRoute(builder: (context) {
                    //   return ResetPasswordScreen();
                    // }));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login(_registeredMobileNumberController.text.toString(),
                        _newPasswordController.text.toString());
                  }
                },
                child: Container(
                  height: 42,
                  width: 181.5,
                  decoration: BoxDecoration(
                    color: ColorConstants.buttonBgColor,
                    borderRadius: BorderRadius.circular(39),
                    border: Border.all(
                      color: ColorConstants.buttonBorderColor, // Border color
                      width: 1, // Border width
                    ),
                  ),
                  child: Center(
                      child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: ColorConstants.buttonTextColor, fontSize: 14),
                  )),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterWidget()),
                ),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 61, top: 19),
                    child: Text(
                      'Don\'t Have Account? Click here',
                      style: TextStyle(
                        fontSize: 11,
                        color: ColorConstants.clickTextColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
