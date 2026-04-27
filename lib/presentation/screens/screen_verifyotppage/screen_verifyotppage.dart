import 'dart:async';

import 'package:arthor/core/appconstants.dart';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/domain/pushnotification_controller.dart';
import 'package:arthor/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:arthor/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';

import 'package:arthor/presentation/screens/screen_mainpage/screen_mainpage.dart';

import 'package:arthor/widgets/cusstomsqure_loadingbutton.dart';

import 'package:arthor/widgets/custom_navigation.dart';
import 'package:arthor/widgets/custom_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class OtpVerificationPage extends StatefulWidget {
  final String loginId;
  final String loginType;
  final String mobileNumber;

  const OtpVerificationPage({
    super.key,
    required this.loginId,
    required this.loginType,
    required this.mobileNumber,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isButtonEnabled = false;
  int _resendTimer = 30;
  Timer? _timer;
  String _currentOtp = '';

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    try {
      _otpController.dispose();
    } catch (e) {
      // Controller already disposed, ignore
    }
    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resetResendTimer() {
    if (!mounted) return;
    setState(() {
      _resendTimer = 30;
    });
    _startResendTimer();
  }

  void _resendOtp() {
    if (!mounted) return;
    _otpController.clear();
    setState(() {
      _currentOtp = '';
      _isButtonEnabled = false;
    });
    _resetResendTimer();

    // Call resend OTP API
    context.read<ResendOtpBloc>().add(
      ResendOtpClickEvent(loginId: widget.loginId, loginType: widget.loginType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kwhitecolor,
      body: Column(
        children: [
          // Top Section - Fixed height
          Container(
            padding: EdgeInsets.all(20),
            color: Appcolors.kwhitecolor,
            height: ResponsiveUtils.hp(50),
            width: ResponsiveUtils.screenWidth,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResponsiveSizedBox.height30,
                  Image.asset(
                    Appconstants.applogo,
                    width: ResponsiveUtils.wp(50),
                  ),
                  ResponsiveSizedBox.height20,
                  Text(
                    'Arthor Services',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.ksecondarycolor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  ResponsiveSizedBox.height20,
                ],
              ),
            ),
          ),

          // Bottom Section - Expands to fill remaining space
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 227, 174),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveSizedBox.height20,
                      TextStyles.headline(text: 'Verification Code'),
                      ResponsiveSizedBox.height10,
                      TextStyles.body(
                        text:
                            'We have sent a verification code to ${widget.mobileNumber}',
                        weight: FontWeight.w500,
                      ),
                      ResponsiveSizedBox.height30,
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: _otpController,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          inactiveBorderWidth: .5,
                          activeBorderWidth: .7,
                          selectedBorderWidth: .9,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 50,
                          fieldWidth: 48,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.grey.shade100,
                          selectedFillColor: Colors.white,
                          activeColor: Appcolors.kprimarycolor,
                          inactiveColor: Appcolors.ksecondarycolor,
                          selectedColor: Appcolors.kgreencolor,
                        ),
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onCompleted: (value) {
                          if (!mounted) return;
                          setState(() {
                            _isButtonEnabled = true;
                            _currentOtp = value;
                          });
                        },
                        onChanged: (value) {
                          if (!mounted) return;
                          setState(() {
                            _currentOtp = value;
                            _isButtonEnabled = value.length == 6;
                          });
                        },
                      ),
                      ResponsiveSizedBox.height30,
                      SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
                          listener: (context, state) {
                            if (state is VerifyOtpSuccessState) {
                              CustomNavigation.pushReplaceWithTransition(
                                context,
                                ScreenMainPage(),
                              );

                              PushNotifications().sendTokenToServer();
                            } else if (state is VerifyOtpErrorState) {
                              CustomSnackbar.show(
                                context,
                                message: state.message,
                                type: SnackbarType.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is VerifyOtpLoadingState) {
                              return CustomSqureLoadingButton(
                                loading: SpinKitCircle(
                                  size: 20,
                                  color: Appcolors.kwhitecolor,
                                ),
                                color: Appcolors.kblackcolor,
                              );
                            }
                            return ElevatedButton(
                              onPressed: _isButtonEnabled
                                  ? () {
                                      if (_currentOtp.length == 6) {
                                        context.read<VerifyOtpBloc>().add(
                                          VerifyOtpButtonclickEvent(
                                            loginId: widget.loginId,
                                            loginType: widget.loginType,
                                            executiveOtp: _currentOtp,
                                          ),
                                        );
                                      } else {
                                        SnackBar(
                                          content: Text(
                                            'Please enter valid OTP',
                                          ),
                                        );
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolors.kblackcolor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Verify',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive OTP? ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),
                          ),

                          BlocConsumer<ResendOtpBloc, ResendOtpState>(
                            listener: (context, state) {
                              if (state is ResendOtpSuccessState) {
                                CustomSnackbar.show(
                                  context,
                                  message: 'OTP sent successfully',
                                  type: SnackbarType.success,
                                );
                              } else if (state is ResendOtpErrorState) {
                                SnackBar(content: Text(state.message));
                              }
                            },
                            builder: (context, state) {
                              return TextButton(
                                onPressed: _resendTimer == 0
                                    ? () => _resendOtp()
                                    : null,
                                child: TextStyles.body(
                                  text: _resendTimer > 0
                                      ? 'Resend in $_resendTimer seconds'
                                      : 'Resend',
                                  weight: FontWeight.w600,
                                  color: _resendTimer > 0
                                      ? Colors.grey.shade500
                                      : Appcolors.kredcolor,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
