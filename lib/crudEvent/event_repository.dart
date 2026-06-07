import 'package:cloud_firestore/cloud_firestore.dart';

import 'event_model.dart';

class EventRepository {
  final CollectionReference _col = FirebaseFirestore.instance.collection(
    'eventos',
  );

  Future<List<EventModel>> buscarTodos() async {
    final snapshot = await _col.orderBy('dataInicio').get();
    return snapshot.docs.map((doc) => EventModel.fromDoc(doc)).toList();
  }

  Future<EventModel?> buscarPorId(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return EventModel.fromDoc(doc);
  }

  Stream<List<EventModel>> stream() {
    return _col
        .orderBy('dataInicio')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => EventModel.fromDoc(doc)).toList(),
        );
  }

  Future<void> criar(EventModel evento) async {
    await _col.add(evento.toMap());
  }

  Future<void> atualizar(EventModel evento) async {
    await _col.doc(evento.id).update(evento.toMap());
  }

  Future<void> cancelar(String id) async {
    await _col.doc(id).update({
      'status': EventStatus.cancelado.name,
      'atualizadoEm': Timestamp.fromDate(DateTime.now()),
    });
  }
}