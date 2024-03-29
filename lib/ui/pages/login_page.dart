import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surat_jalan/bloc/login_bloc.dart';
import 'package:surat_jalan/shared/shared_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController(text: '');

  final TextEditingController _passwordController =
      TextEditingController(text: '');

  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;

    _laucnhWhatsapp() async {
      //! Launch the WhatsApp app HARUS GANTI Nomor punya
      var noWhatsapp = '6282176515234';
      var message = 'Halo, saya lupa password saya, mohon bantuannya.';
      var whatsappAndroid =
          Uri.parse("whatsapp://send?phone=$noWhatsapp&text=$message");
      // Uri.parse(
      //     "https://api.whatsapp.com/send/?phone=$noWhatsapp&text=$message");

      if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("WhatsApp tidak terinstall di perangkat ini"),
            backgroundColor: redStatusColor,
          ),
        );
      }
    }

    void buildModal(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Lupa Password ?',
              style: txSemiBold.copyWith(
                color: primaryColor.withOpacity(0.8),
                fontSize: 22,
              ),
            ),
            content: Text(
              'Silakan hubungi admin untuk mendapatkan akses ?',
              style: txRegular.copyWith(
                color: blackColor.withOpacity(0.8),
                fontSize: 18,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                  _laucnhWhatsapp();
                },
                child: Text(
                  'Hubungi',
                  style: txMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Batal',
                  style: txMedium,
                ),
              )
            ],
          );
        },
      );
    }

    Widget heading() {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.15),
        child: AutoSizeText(
          'SPDD\nManajemen',
          style: txBold.copyWith(
            color: primaryColor,
            fontSize: 30,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      );
    }

    Widget loginForm() {
      return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailureState) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginLoadingState) {
            _isLoading = true;
          } else if (state is LoginSuccessState) {
            _isLoading = false;
            if (state.response.status.toString() == "success") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login berhasil'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacementNamed(context, '/main');
            } else if (state.response.status.toString() == "error") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.response.message.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Text(
                'Login ke Akun Anda',
                style: txMedium.copyWith(
                  color: greySubHeaderColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _emailController,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    size: 30,
                    color: primaryColor,
                  ),
                  labelText: 'Email',
                  labelStyle: txRegular.copyWith(
                    color: greySubHeaderColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: greyThinColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                obscureText: _isObsecure,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    size: 30,
                    color: primaryColor,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObsecure = !_isObsecure;
                        });
                      },
                      icon: Icon(
                        _isObsecure ? Icons.visibility_off : Icons.visibility,
                        size: 30,
                        color: primaryColor,
                      )),
                  labelText: 'Password',
                  labelStyle: txRegular.copyWith(
                    color: greySubHeaderColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: greyThinColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, '/forgot_password');
                    buildModal(context);
                  },
                  child: Text(
                    'Lupa Password?',
                    style: txRegular.copyWith(
                      color: greySubHeaderColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              if (_isLoading == true)
                Center(
                  child: Container(
                      color: whiteColor,
                      child: const CircularProgressIndicator()),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Email dan Password tidak boleh kosong'),
                            backgroundColor: Colors.blueGrey,
                          ),
                        );
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => AlertDialog(
                        //     title: const Text('Error'),
                        //     content: const Text('Mohon Isi Seluruh Kolom !'),
                        //     actions: [
                        //       TextButton(
                        //         child: const Text('OK'),
                        //         onPressed: () => Navigator.pop(context),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      } else {
                        context.read<LoginBloc>().add(
                              LoginRequestedEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                        // if (state is LoginSuccessState) {
                        //   if (state.response.status.toString() == "success") {
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => const MainPage(),
                        //       ),
                        //     );
                        //   } else if (state.response.status.toString() ==
                        //       "error") {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(state.response.message),
                        //         backgroundColor: Colors.red,
                        //       ),
                        //     );
                        //   }
                        // }
                      }
                    },
                    child: Text(
                      'Login',
                      style: txMedium.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      );
    }

    Widget footer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Belum memiliki akun?',
            style: txRegular.copyWith(
              color: greyDeepColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Daftar',
            style: txBold.copyWith(
              color: primaryColor,
              fontSize: 14,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading(),
                  const SizedBox(
                    height: 70,
                  ),
                  loginForm(),
                  const SizedBox(
                    height: 35,
                  ),
                  // footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
