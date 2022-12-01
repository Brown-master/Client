import 'package:flutter/material.dart';
import 'package:ui_repository/components/login_form.dart';
import 'package:ui_repository/components/logo_form.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState{
  bool loading;
  User? user;
  AppState(this.loading,this.user);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Future<bool> location;
  final app=AppState(false, null);
  Widget build(BuildContext context){
    if(app.loading)return _loading();
    if(app.user==null)return _logIn();
    return _main();
  }
  Widget _loading(){
    return Scaffold(
      appBar: AppBar(title: Text('loading...')),
      body: Center(child: CircularProgressIndicator())
    );
  }
  Widget _logIn () {
    return Scaffold(
        appBar: AppBar(
            title: Text('login page')
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    child: Text('login'),
                    onPressed: () {
                      _signIn();
                    }
                )
              ],
            )
        )
    );
  }
  Widget _main () {
    return Scaffold(
        appBar: AppBar(
          title: Text('loginsss'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                _signOut();
              },
            )
          ],
        ),
        body: Center(child: Text('contents'))
    );
  }
  Future<UserCredential> _signIn() async {
    setState(() => app.loading = true);
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
    await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  void _signOut() async{
    await GoogleSignIn().signOut();
    // await _auth.signOut();
    setState(() {
      app.user = null;
    });
  }
}
  Future<bool> location_permission() async {
    Map<Permission, PermissionStatus> status =
    await [Permission.location].request(); // [] 권한배열에 권한을 작성

    if (await Permission.location.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
}

