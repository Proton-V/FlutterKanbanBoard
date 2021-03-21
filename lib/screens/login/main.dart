import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kanban/bloc/auth/auth.dart';
import 'package:test_kanban/screens/board/main.dart';
import 'package:test_kanban/screens/board/main.dart';
import 'package:test_kanban/shared/components.dart';
import 'package:test_kanban/shared/models/user.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passController = TextEditingController();
  var size;
  final regExp = RegExp("^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]");

  _login() {
    if (_formKey.currentState.validate()) {
      LoginEvent event = new LoginEvent();
      event.user = new User(loginController.text, passController.text);
      BlocProvider.of<BlocAuth>(context).add(event);
    }
  }

  String _validatorEmail(value) {
    if (!regExp.hasMatch(value)) {
      return "type a valid login";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    loginController.text = 'armada';
    passController.text = 'FSH6zBZ0p9yH';
    BlocProvider.of<BlocAuth>(context).add(new ResetStateEvent());
  }

  @override
  void dispose() {
    super.dispose();
    loginController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.0671),
          SizedBox(height: size.height * 0.085),
          Expanded(
            child: _formLogin(),
          ),
        ],
      ),
    );
  }

  Widget _formLogin() {
    // ignore: missing_return
    return BlocBuilder<BlocAuth, AuthState>(buildWhen: (previous, current) {
      if (current is LogedState) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BoardPage(key: GlobalKey<FormState>())));
      } else if (current is LoginFailState) {
        print('ERRR');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(current.msg)));
      }
    }, builder: (context, state) {
      return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                InputLogin(
                  validator: _validatorEmail,
                  prefixIcon: Icons.account_circle,
                  hint: 'Login',
                  keyboardType: TextInputType.name,
                  textEditingController: loginController,
                ),
                SizedBox(height: size.height * 0.03),
                InputLogin(
                  prefixIcon: Icons.lock,
                  hint: 'Password',
                  obscureText: true,
                  textEditingController: passController,
                ),
                SizedBox(height: size.height * 0.035),
                _buttonLogin(),
                SizedBox(height: size.height * 0.01),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buttonLogin() {
    return BlocBuilder<BlocAuth, AuthState>(
      builder: (context, state) {
        if (state is LoadingLoginState) {
          return ButtonLogin(
            isLoading: true,
            backgroundColor: Colors.white,
            label: 'LOGIN ...',
            mOnPressed: () => {},
          );
        } else if (state is LogedState) {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'CONECTED!',
            mOnPressed: () => {},
          );
        } else {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'SIGN IN',
            mOnPressed: () => _login(),
          );
        }
      },
    );
  }
}
