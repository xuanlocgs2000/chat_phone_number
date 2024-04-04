import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_phone_number/screens/verify_phone_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_phone_number/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_phone_number/cubit/auth_cubit/auth_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController phoneController = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    backgroundColor: Colors.blue,
  );
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
              _buildTitle('Hello'),
              _buildTitle('Welcome to the app'),
              SizedBox(height: 35),
              _buildPhoneTextField(),
              SizedBox(height: 10),
              // _buildPasswordTextField(),
              // SizedBox(height: 10),
              // _buildForgotPasswordText(),
              SizedBox(height: 20),
              _buildSignInButton(),
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

  Widget _buildPhoneTextField() {
    return TextField(
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      controller: phoneController,
      decoration: InputDecoration(
        // labelText: "Email",
        hintText: "Your phone number",
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),

        prefixIcon: Icon(
          Icons.phone,
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

  Widget _buildSignInButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthCodeSentState) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => VerifyPhoneScreen(),
              ));
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
                child: Text("Sign In"),
                color: Colors.blue,
                onPressed: () {
                  String phoneNumber = '+84' + phoneController.text;
                  BlocProvider.of<AuthCubit>(context).sentOTP(phoneNumber);
                }));
      },
    );
  }
}
