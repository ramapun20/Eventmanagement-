import 'package:event_buddy/presentation/login/login_page.dart';
import 'package:event_buddy/presentation/register/cubit/register_cubit.dart';
import 'package:event_buddy/utils/loading_dialog.dart';
import 'package:event_buddy/utils/popup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../main.dart';
import '../../../../../utils/constants/color_constants.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<RegisterWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _interestsController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedUserRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            padding: const EdgeInsets.only(left: 20, top: 10),
            onPressed: () {
              navigator.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        color: ColorConstants.whiteColor,
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              buildLoadingDialog(context: context, title: "Registering...");
            } else if (state is RegisterFailure) {
              Navigator.of(context, rootNavigator: true).pop();
              PopUpProvider.showSnackBarMessage(context, state.msg);
            } else if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              SchedulerBinding.instance.addPostFrameCallback((timestamp) {
                PopUpProvider.showSnackBarMessage(context, "Please Log in!!",
                    isError: false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginWidget()),
                );
              });
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                            DropdownButtonFormField(
                              value: _selectedUserRole,
                              onChanged: (value) {
                                setState(() {
                                  _selectedUserRole = value;
                                });
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: 'Company',
                                  child: Text('Event Manager'),
                                ),
                                DropdownMenuItem(
                                  value: 'user',
                                  child: Text('Basic User'),
                                ),
                              ],
                              decoration: InputDecoration(
                                labelText: 'User Role',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: ColorConstants.hintColor,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a user role';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildTextFormField(
                              _nameController,
                              "Name",
                              (txt) {
                                if (txt == null || txt.isEmpty) {
                                  return "Name is Required";
                                }
                                return null;
                              },
                              null,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            _buildTextFormField(
                              _mobileNumberController,
                              "Phone Number",
                              (txt) {
                                if (txt == null || txt.isEmpty) {
                                  return "Phone is Required";
                                }
                                return null;
                              },
                              TextInputType.number,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            _buildTextFormField(
                              _emailController,
                              "Email",
                              (txt) {
                                if (txt == null || txt.isEmpty) {
                                  return "Email is Required";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(txt)) {
                                  return "Invalid format";
                                }
                                return null;
                              },
                              TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            if (_selectedUserRole != "Company")
                              _buildTextFormField(
                                _interestsController,
                                "Interests (use comma(,) to separate)",
                                (txt) {
                                  if (txt == null || txt.isEmpty) {
                                    return "Interest is Required";
                                  }
                                  return null;
                                },
                                null,
                              ),
                            const SizedBox(
                              height: 11,
                            ),
                            _buildTextFormField(
                              _newPasswordController,
                              "New Password",
                              (txt) {
                                if (txt == null || txt.isEmpty) {
                                  return "Password is Required";
                                }
                                return null;
                              },
                              null,
                              isObscure: true,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            _buildTextFormField(
                              _repeatPasswordController,
                              "Confirm Password",
                              (txt) {
                                if (txt == null || txt.isEmpty) {
                                  return "Confirm Password is Required";
                                } else if (_newPasswordController.text != txt) {
                                  return "Password should match";
                                }
                                return null;
                              },
                              null,
                              isObscure: true,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final interest = _interestsController.text;
                      var values = interest
                          .split(",")
                          .map((x) => x.trim())
                          .where((element) => element.isNotEmpty)
                          .toList();
                      var data = {
                        "username": _nameController.text,
                        "type": _selectedUserRole,
                        "phone": _mobileNumberController.text,
                        "email": _emailController.text,
                        "skills": values,
                        "password": _repeatPasswordController.text,
                      };
                      if (_selectedUserRole == "Company") {
                        data["cname"] = _nameController.text;
                      }

                      context.read<RegisterCubit>().register(data);
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
                      'Sign Up',
                      style: TextStyle(
                          color: ColorConstants.buttonTextColor, fontSize: 14),
                    )),
                  ),
                ),
                const SizedBox(height: 25)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController _controller, String hintMsg,
          String? Function(String?)? validator, TextInputType? inputType,
          {bool isObscure = false}) =>
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: inputType ?? TextInputType.name,
        style: TextStyle(
          color: ColorConstants.blackColor, // Set the text color here
        ),
        obscureText: isObscure,
        cursorColor: ColorConstants.blackColor,
        controller: _controller,
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
          hintText: hintMsg,
          hintStyle: TextStyle(
              fontSize: 14.0, height: 1, color: ColorConstants.hintColor),
        ),
        validator: validator,
      );
}
