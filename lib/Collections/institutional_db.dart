class InstitutionalDB {
  InstitutionalDB._();

  static const _records = <String, _InstitutionalRecord>{
    '20210001': _InstitutionalRecord(
      matricula: '20210001',
      email: 'joao.silva@instituicao.edu.br',
      name: 'João Silva',
      role: 'aluno',
    ),
    '20210002': _InstitutionalRecord(
      matricula: '20210002',
      email: 'maria.souza@instituicao.edu.br',
      name: 'Maria Souza',
      role: 'aluno',
    ),
    '1231112899': _InstitutionalRecord(
      matricula: '1231112899',
      email: 'jodantasjunior@gmail.com',
      name: 'José Alves',
      role: 'aluno',
    ),

    '1234887890': _InstitutionalRecord(
      matricula: '1234887890',
      email: 'jose.adantas@souunit.com.br',
      name: 'José Júnior',
      role: 'aluno',
    ),
    '20210003': _InstitutionalRecord(
      matricula: '20210003',
      email: 'carlos.mendes@instituicao.edu.br',
      name: 'Carlos Mendes',
      role: 'aluno',
    ),
    'DOC001': _InstitutionalRecord(
      matricula: 'DOC001',
      email: 'ana.lima@instituicao.edu.br',
      name: 'Ana Lima',
      role: 'docente',
    ),
    'DOC002': _InstitutionalRecord(
      matricula: 'DOC002',
      email: 'pedro.costa@instituicao.edu.br',
      name: 'Pedro Costa',
      role: 'docente',
    ),
  };

  static _InstitutionalRecord? lookup(String matricula) {
    return _records[matricula.trim().toUpperCase()] ??
        _records[matricula.trim()];
  }

  static _InstitutionalRecord validate({
    required String matricula,
    required String email,
  }) {
    final record = lookup(matricula);

    if (record == null) {
      throw InstitutionalException.unknownMatricula();
    }

    if (record.email.toLowerCase() != email.trim().toLowerCase()) {
      throw InstitutionalException.emailMismatch();
    }

    return record;
  }
}

class _InstitutionalRecord {
  final String matricula;
  final String email;
  final String name;

  final String role;

  const _InstitutionalRecord({
    required this.matricula,
    required this.email,
    required this.name,
    required this.role,
  });
}

class InstitutionalException implements Exception {
  final String message;
  const InstitutionalException(this.message);

  factory InstitutionalException.unknownMatricula() =>
      const InstitutionalException(
        'Matrícula não encontrada na base institucional.',
      );

  factory InstitutionalException.emailMismatch() =>
      const InstitutionalException(
        'O email não corresponde à matrícula informada.',
      );

  @override
  String toString() => message;
}
