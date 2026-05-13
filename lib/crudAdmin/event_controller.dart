import 'dart:convert';

import 'package:http/http.dart' as http;

import 'event_model.dart';

class EventService {
  static const String baseUrl = 'http://localhost:3000/api/v1/events';

  final http.Client client;

  EventService({http.Client? client}) : client = client ?? http.Client();

  // Criar evento

  Future<EventModel> createEvent({
    required String token,
    required EventModel event,
  }) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(event.toJson()),
    ); //Create

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return EventModel.fromJson(data);
    }

    throw Exception('Erro ao criar evento: ${response.body}');
  }

  // Get all events

  Future<List<EventModel>> getEvents({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
  }) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        'page': '$page',
        'limit': '$limit',
        if (search != null) 'search': search,
        if (category != null) 'category': category,
      },
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => EventModel.fromJson(e)).toList();
    }

    throw Exception('Erro ao buscar eventos');
  }

  // Get event by ID

  Future<EventModel> getEventById(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return EventModel.fromJson(data);
    }

    throw Exception('Evento não encontrado');
  }

  // Update de evento

  Future<EventModel> updateEvent({
    required String token,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final response = await client.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      return EventModel.fromJson(responseData);
    }

    throw Exception('Erro ao atualizar evento');
  }

  // Deletar evento

  Future<void> deleteEvent({required String token, required String id}) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao deletar evento');
    }
  }

  // Cancelar evento

  Future<void> cancelEvent({required String token, required String id}) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/$id/cancel'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao cancelar evento');
    }
  }

  // Finalizar evento

  Future<void> finishEvent({required String token, required String id}) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/$id/finish'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao finalizar evento');
    }
  }
}
