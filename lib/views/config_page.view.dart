import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interfone_digital/services/cep_service.dart';
import 'package:interfone_digital/utils/formatters/uppercase_formatter.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final formKey = GlobalKey<FormState>();
  final cepController = TextEditingController();
  final enderecoController = TextEditingController();
  final cepService = CepService();

  bool isCepServiceLoading = false;

  buscarCep() async {
    setState(() {
      isCepServiceLoading = true;
    });
    final cep = cepController.text;

    final endereco = await cepService.buscarCepService(cep);
    enderecoController.text = endereco;
    setState(() {
      isCepServiceLoading = false;
    });
  }

  @override
  void dispose() {
    cepController.dispose();
    enderecoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Form(
                  key: formKey,
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: TextFormField(
                          inputFormatters: [UpperCaseTextFormatter()],
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: 'Primeiro Nome',
                            border: OutlineInputBorder(),
                            enabled: true,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: TextFormField(
                          inputFormatters: [UpperCaseTextFormatter()],
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: 'Nome Completo',
                            border: OutlineInputBorder(),
                            enabled: true,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Focus(
                          child: TextFormField(
                            controller: cepController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter()
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'CEP',
                              border: const OutlineInputBorder(),
                              enabled: true,
                              suffix: isCepServiceLoading
                                  ? const SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                      ))
                                  : null,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, informe o CEP';
                              }

                              if (value.length < 10) {
                                return 'CEP inválido';
                              }
                              return null;
                            },
                          ),
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              buscarCep();
                            }
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: TextFormField(
                          controller: enderecoController,
                          minLines: 1,
                          maxLines: 3,
                          inputFormatters: [UpperCaseTextFormatter()],
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: 'Endereço',
                            border: OutlineInputBorder(),
                            enabled: false,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: TextFormField(
                          inputFormatters: [UpperCaseTextFormatter()],
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: 'Número',
                            border: OutlineInputBorder(),
                            enabled: true,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: TextFormField(
                          inputFormatters: [UpperCaseTextFormatter()],
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: 'Complemento',
                            border: OutlineInputBorder(),
                            enabled: true,
                          ),
                        )),
                  ])))),
    );
  }
}
