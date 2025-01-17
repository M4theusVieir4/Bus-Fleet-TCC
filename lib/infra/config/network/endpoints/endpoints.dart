abstract class Endpoints {
  static const registerUser = '/usuario/register';
  static const loginUser = '/usuario/login';
  static const searchPonto = '/onibus/pontos-detalhe';
  static String busSearch(int id) => '/onibus/onibus?idOnibus=$id';
  static String comunicationSearch(int id) =>
      '/onibus/localizacao?idEquipamento=$id';
}
