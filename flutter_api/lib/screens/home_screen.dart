import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_api/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final TextEditingController _imagemController = TextEditingController();
final HomeController homeController = HomeController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retorno Popup - MTB'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !homeController.isLoading.value &&
                    homeController.msgret.value != null
                ? Text(
                    homeController.msgret.value.toString(),
                    style: TextStyle(fontSize: 15),
                  )
                : Text(''),
            !homeController.isLoading.value &&
                    homeController.imagem.value != null
                ? Container(
                    height: 300,
                    width: 300,
                    child: Image.memory(
                      base64Decode(
                        homeController.imagem.value.toString(),
                      ),
                    ),
                  )
                : Container(
                    height: 300,
                    width: 300,
                    child: Visibility(
                      child: const CircularProgressIndicator(),
                      visible: homeController.isLoading.value,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      homeController.procurarZip(parameter1: 'DEV FLUTTER');
                    },
                    child: Text("PESQUISAR IMAGEM")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
