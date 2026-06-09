import 'package:flutter/material.dart';

// ── Constantes de domínio ──────────────────────────────────────────────────

/// Lista de cursos disponíveis para seleção no formulário de eventos.
const kCursos = [
  'Ciência da Computação',
  'Engenharia da Computação',
  'Sistemas de Informação',
  'Análise e Desenvolvimento de Sistemas',
  'Engenharia Civil',
  'Engenharia Elétrica',
  'Administração',
  'Direito',
  'Medicina',
  'Todos os cursos',
];

/// Número máximo de períodos por curso.
const kMaxPeriodosPorCurso = <String, int>{
  'Ciência da Computação': 8,
  'Engenharia da Computação': 10,
  'Sistemas de Informação': 8,
  'Análise e Desenvolvimento de Sistemas': 5,
  'Engenharia Civil': 10,
  'Engenharia Elétrica': 10,
  'Administração': 8,
  'Direito': 10,
  'Medicina': 12,
  'Todos os cursos': 12,
};

/// Retorna a lista de períodos disponíveis para o conjunto de cursos
/// selecionados. O máximo é o maior número de períodos entre os cursos.
List<String> periodosParaCursos(List<String> cursos) {
  if (cursos.isEmpty) return [];
  final maxPeriodos = cursos
      .map((c) => kMaxPeriodosPorCurso[c] ?? 8)
      .reduce((a, b) => a > b ? a : b);
  return List.generate(maxPeriodos, (i) => '${i + 1}º Período');
}

// ── Widget de seleção múltipla ─────────────────────────────────────────────

/// Campo que abre um diálogo com checkboxes para seleção múltipla.
/// Exibe chips com os itens selecionados (ou texto de hint se vazio).
class MultiSelectField extends StatelessWidget {
  final String hint;
  final List<String> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  /// Se verdadeiro, o campo fica desabilitado (útil quando ainda não há
  /// cursos selecionados para derivar os períodos disponíveis).
  final bool enabled;

  const MultiSelectField({
    super.key,
    required this.hint,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.enabled = true,
  });

  Future<void> _abrirDialogo(BuildContext context) async {
    // Cópia temporária para não alterar o estado enquanto o usuário navega.
    final temp = List<String>.from(selected);

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setStateDialog) => AlertDialog(
          title: Text(hint),
          contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options
                    .map(
                      (opt) => CheckboxListTile(
                        dense: true,
                        value: temp.contains(opt),
                        title: Text(opt, style: const TextStyle(fontSize: 14)),
                        activeColor: const Color(0xFF3B5EDF),
                        onChanged: (checked) => setStateDialog(() {
                          if (checked == true) {
                            temp.add(opt);
                          } else {
                            temp.remove(opt);
                          }
                        }),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                onChanged(List<String>.from(temp));
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF3B5EDF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = !enabled;

    return GestureDetector(
      onTap: isDisabled ? null : () => _abrirDialogo(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDisabled ? const Color(0xFFF5F5F5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: selected.isEmpty
                  ? Text(
                      hint,
                      style: TextStyle(
                        color: isDisabled
                            ? Colors.black26
                            : Colors.black45,
                        fontSize: 16,
                      ),
                    )
                  : Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: selected
                          .map(
                            (s) => Chip(
                              label: Text(
                                s,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF2F49D1),
                                ),
                              ),
                              backgroundColor: const Color(0xFFE8EDFF),
                              deleteIcon: const Icon(
                                Icons.close,
                                size: 14,
                                color: Color(0xFF2F49D1),
                              ),
                              onDeleted: isDisabled
                                  ? null
                                  : () {
                                      final nova =
                                          List<String>.from(selected)
                                            ..remove(s);
                                      onChanged(nova);
                                    },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide.none,
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: isDisabled ? Colors.black26 : Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
