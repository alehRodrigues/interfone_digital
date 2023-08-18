import 'package:search_cep/search_cep.dart';

class CepService {
  final viaCepService = ViaCepSearchCep();

  Future<String> buscarCepService(String cep) async {
    try {
      var cepTratado = cep.replaceAll('-', '').replaceAll('.', '').trim();
      final endereco = await viaCepService.searchInfoByCep(cep: cepTratado);

      return endereco.fold((l) => l.errorMessage, (r) => r.response());
    } catch (e) {
      return e.toString();
    }
  }
}

extension ViaCepString on ViaCepInfo {
  String response() {
    return '$logradouro - $bairro - $localidade / $uf';
  }
}
