import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_phone_number/screens/home_screen.dart';
import 'package:chat_phone_number/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_phone_number/cubit/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_phone_number/screens/details_screen.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              _buildLogo(),
              SizedBox(height: 10),
              // _buildTitle('Verify your phone number'),
              _buildTitle('Verify your phone '),
              SizedBox(height: 35),
              _buildOtpTextField(),
              SizedBox(height: 10),

              SizedBox(height: 20),
              _buildVerifyButton(),
              SizedBox(height: 20),
              // _buildSignUpText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 70,
      height: 70,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 199, 204, 208),
      ),
      child: FlutterLogo(),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOtpTextField() {
    return TextField(
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      controller: otpController,
      decoration: InputDecoration(
        // labelText: "Email",
        hintText: "6 digits OTP",
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),

        prefixIcon: Icon(
          Icons.drag_indicator_sharp,
          size: 18,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => userName()),
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CupertinoButton(
                child: Text("Verify"),
                color: Colors.blue,
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context)
                      .verifyOTP(otpController.text);
                }));
      },
    );
  }
}
