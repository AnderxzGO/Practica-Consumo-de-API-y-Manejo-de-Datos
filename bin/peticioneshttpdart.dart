import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}

Future<List<User>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => User.fromJson(json)).toList();
  } else if (response.statusCode == 404) {
    throw Exception('Recurso no encontrado x_x');
  } else if (response.statusCode == 500) {
    throw Exception('Error del servidor.');
  } else {
    throw Exception('Error desconocido con código: ${response.statusCode}');
  }
}

void filtradoDeUsuarios(List<User> users) {
  final filteredUsers = users.where((user) => user.username.length > 6);
  int totalCount = filteredUsers.length;

  if (filteredUsers.isNotEmpty) {
    for (var user in filteredUsers) {
      print('Usuario: ${user.username} |-> ID: ${user.id} ');
    }
    print('|------------------------------------------------>');
    print('Total de usuarios que cumplen con la condición: $totalCount');
    print('|----------------------------------->');
  } else {
    print('<------------------------------------------------------->');
    print(
        'No se encontraron usuarios con nombres de usuario de más de 6 caracteres.');
    print('<------------------------------------------------------->');
  }
}

void ContadorDeLaExtension(List<User> users) {
  final bizUsers = users.where((user) => user.email.endsWith('.biz'));
  if (bizUsers.isNotEmpty) {
    print('|--|Numero de usuarios con el dominio ".biz": ${bizUsers.length}');
    print(' ');
    print('<--------Usuarios con el dominio ".biz"--------->');
    for (var user in bizUsers) {
      print('Usuario: ${user.username} |-> Email: ${user.email}');
    }
  } else {
    print('No se encontraron usuarios con dominio ".biz." ');
  }
}

void main() async {
  try {
    final users = await fetchUsers();
    print('Codigo Modificado por: Anderson Smith Iriarte Q.');
    print('Programación Movil 2024-2 |<>| Grupo 01');
    print('');
    filtradoDeUsuarios(users);
    print(' ');
    ContadorDeLaExtension(users);
  } catch (e) {
    print('Error: $e');
  }
}
