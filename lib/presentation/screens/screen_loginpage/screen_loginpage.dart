import 'package:arthor/core/appconstants.dart';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/presentation/blocs/send_otp_bloc.dart/send_otp_bloc.dart';
import 'package:arthor/presentation/screens/screen_verifyotppage/screen_verifyotppage.dart';
import 'package:arthor/widgets/cusstomsqure_loadingbutton.dart';
import 'package:arthor/widgets/custom_navigation.dart';
import 'package:arthor/widgets/custom_snackbar.dart';
import 'package:arthor/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class ScreenLoginpage extends StatefulWidget {
  const ScreenLoginpage({super.key});

  @override
  State<ScreenLoginpage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ScreenLoginpage> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.length != 10) {
      return 'Please enter a valid 10-digit mobile number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number should contain only digits';
    }
    return null;
  }

  void _handleSendOtp() {
    if (_formKey.currentState!.validate()) {
context.read<SendOtpBloc>().add(SendOtpButtonClickEvent(mobileNumber:_mobileController.text));
    }
    else{
      CustomSnackbar.show(context, message: "Please fill Required fields", type:SnackbarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveSizedBox.height30,
                Column(
                  children: [
                    // Logo Image
                    SizedBox(
                      height: ResponsiveUtils.hp(25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          ResponsiveUtils.borderRadius(4),
                        ),
                        child: Image.asset(
                          Appconstants.applogo,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Appcolors.kprimarycolor,
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.borderRadius(4),
                                ),
                              ),
                              child: Icon(
                                Icons.directions_car,
                                size: ResponsiveUtils.sp(15),
                                color: Appcolors.kwhitecolor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.hp(2)),
                    Text(
                      'Welcome to Arthor Services',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(5),
                        fontWeight: FontWeight.w500,
                        color: Appcolors.kblackcolor,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.hp(1)),
                    Text(
                      'Please login to continue',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(3.5),
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                ResponsiveSizedBox.height40,
                // Form Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                  decoration: BoxDecoration(
                    color: Appcolors.kwhitecolor,
                    //color: const Color.fromARGB(255, 219, 201, 130),
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.borderRadius(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(33),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Mobile Number Field
                      CustomTextField(
                        hintText: 'Enter your mobile number',
                        labelText: 'Mobile Number',
                        prefixIcon: Icons.phone_outlined,
                        controller: _mobileController,
                        validator: _validateMobile,
                        keyboardType: TextInputType.phone,
                      ),

                      SizedBox(height: ResponsiveUtils.hp(4)),
                      BlocConsumer<SendOtpBloc, SendOtpState>(
                        listener: (context, state) {
                       if (state is SendOtpSuccessState) {
                         CustomNavigation.pushReplaceWithTransition(context, OtpVerificationPage(executiveId:state.executiveId, mobileNumber:_mobileController.text));
                       }
                       else if(state is SendOtpErrorState){
                        CustomSnackbar.show(context, message:state.message, type:SnackbarType.error);
                       }
                        },
                        builder: (context, state) {
                          if (state is SendOtpLoadingState) {
                                 return CustomSqureLoadingButton(
                                loading: SpinKitCircle(
                                  size: 20,
                                  color: Appcolors.kwhitecolor,
                                ),
                                color: Appcolors.kblackcolor,
                              );
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: ResponsiveUtils.hp(6.5),
                            child: ElevatedButton(
                              onPressed: _handleSendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolors.kblackcolor,
                                foregroundColor: Appcolors.kwhitecolor,
                                elevation: 5,
                                shadowColor: Appcolors.kprimarycolor.withAlpha(
                                  77,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.borderRadius(3),
                                  ),
                                ),
                              ),
                              child: TextStyles.body(
                                text: 'SEND OTP',
                                color: Appcolors.kwhitecolor,
                              ),
                            ),
                          );
                        },
                      ),
       
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
