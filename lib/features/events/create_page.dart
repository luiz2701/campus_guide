import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/buttons/primary_button.dart';
import '../../components/inputs/app_text_field.dart';
import '../../crudEvent/event_controller.dart';
import 'event_form_data.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _controller = EventController();

  final _tituloCtrl = TextEditingController();
  final _diaCtrl = TextEditingController();
  final _horaCtrl = TextEditingController();
  final _horaFimCtrl = TextEditingController();
  final _localCtrl = TextEditingController();
  final _vagasCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();
  final _ministranteCtrl = TextEditingController();

  List<String> _cursosSelecionados = [];
  List<String> _periodosSelecionados = [];
  final List<String> _ministrantes = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_atualizarTela);
  }

  void _atualizarTela() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_atualizarTela);
    _controller.dispose();
    _tituloCtrl.dispose();
    _diaCtrl.dispose();
    _horaCtrl.dispose();
    _horaFimCtrl.dispose();
    _localCtrl.dispose();
    _vagasCtrl.dispose();
    _descricaoCtrl.dispose();
    _ministranteCtrl.dispose();
    super.dispose();
  }

  Future<void> _selecionarDia() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
    );
    if (data != null) {
      _diaCtrl.text =
          '${data.day.toString().padLeft(2, '0')}/'
          '${data.month.toString().padLeft(2, '0')}/'
          '${data.year}';
    }
  }

  Future<void> _selecionarHora() async {
    final hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (hora != null) {
      _horaCtrl.text =
          '${hora.hour.toString().padLeft(2, '0')}:'
          '${hora.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _selecionarHoraFim() async {
    final hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (hora != null) {
      _horaFimCtrl.text =
          '${hora.hour.toString().padLeft(2, "0")}:'
          '${hora.minute.toString().padLeft(2, "0")}';
    }
  }

  void _adicionarMinistrante() {
    final nome = _ministranteCtrl.text.trim();
    if (nome.isEmpty) return;
    setState(() {
      _ministrantes.add(nome);
      _ministranteCtrl.clear();
    });
  }

  void _removerMinistrante(int index) {
    setState(() => _ministrantes.removeAt(index));
  }

  void _onCursosChanged(List<String> novos) {
    setState(() {
      _cursosSelecionados = novos;
      // Remove períodos que não existem mais nos cursos selecionados.
      final validos = periodosParaCursos(novos);
      _periodosSelecionados.retainWhere(validos.contains);
    });
  }

  Future<void> _publicar() async {
    if (_tituloCtrl.text.trim().isEmpty ||
        _diaCtrl.text.trim().isEmpty ||
        _horaCtrl.text.trim().isEmpty ||
        _horaFimCtrl.text.trim().isEmpty ||
        _localCtrl.text.trim().isEmpty ||
        _vagasCtrl.text.trim().isEmpty ||
        _cursosSelecionados.isEmpty ||
        _periodosSelecionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios.')),
      );
      return;
    }

    final vagas = int.tryParse(_vagasCtrl.text.trim());
    if (vagas == null || vagas <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um número de vagas válido.')),
      );
      return;
    }

    final partesDia = _diaCtrl.text.trim().split('/');
    final partesHora = _horaCtrl.text.trim().split(':');

    final partesHoraFim = _horaFimCtrl.text.trim().split(':');

    if (partesDia.length != 3 ||
        partesHora.length != 2 ||
        partesHoraFim.length != 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe uma data e hora válidas.')),
      );
      return;
    }

    final dataInicio = DateTime(
      int.parse(partesDia[2]),
      int.parse(partesDia[1]),
      int.parse(partesDia[0]),
      int.parse(partesHora[0]),
      int.parse(partesHora[1]),
    );

    final dataFim = DateTime(
      int.parse(partesDia[2]),
      int.parse(partesDia[1]),
      int.parse(partesDia[0]),
      int.parse(partesHoraFim[0]),
      int.parse(partesHoraFim[1]),
    );

    if (!dataFim.isAfter(dataInicio)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O horário de término deve ser após o de início.'),
        ),
      );
      return;
    }

    final ok = await _controller.criarEvento(
      titulo: _tituloCtrl.text.trim(),
      descricao: _descricaoCtrl.text.trim(),
      dataInicio: dataInicio,
      dataFim: dataFim,
      local: _localCtrl.text.trim(),
      vagasTotal: vagas,
      cursos: _cursosSelecionados,
      periodos: _periodosSelecionados,
      ministrantes: _ministrantes.map((n) => {'nome': n}).toList(),
    );

    if (!mounted) return;

    if (ok) {
      _tituloCtrl.clear();
      _diaCtrl.clear();
      _horaCtrl.clear();
      _horaFimCtrl.clear();
      _localCtrl.clear();
      _vagasCtrl.clear();
      _descricaoCtrl.clear();
      _ministranteCtrl.clear();
      setState(() {
        _cursosSelecionados = [];
        _periodosSelecionados = [];
        _ministrantes.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento publicado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_controller.erro ?? 'Erro ao publicar evento.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F49D1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Criar evento',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(hint: 'Título', controller: _tituloCtrl),
                const SizedBox(height: 14),
                _CampoComIcone(
                  hint: 'Dia',
                  controller: _diaCtrl,
                  icon: Icons.calendar_today_outlined,
                  onIconTap: _selecionarDia,
                ),
                const SizedBox(height: 14),
                _CampoComIcone(
                  hint: 'Hora de início',
                  controller: _horaCtrl,
                  icon: Icons.schedule_outlined,
                  onIconTap: _selecionarHora,
                ),
                const SizedBox(height: 14),
                _CampoComIcone(
                  hint: 'Hora de término',
                  controller: _horaFimCtrl,
                  icon: Icons.schedule_outlined,
                  onIconTap: _selecionarHoraFim,
                ),
                const SizedBox(height: 14),
                AppTextField(hint: 'Local', controller: _localCtrl),
                const SizedBox(height: 14),
                TextField(
                  controller: _vagasCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _inputDecoration('Número de vagas totais'),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _descricaoCtrl,
                  minLines: 3,
                  maxLines: 5,
                  decoration: _inputDecoration('Descrição'),
                ),
                const SizedBox(height: 14),
                MultiSelectField(
                  hint: 'Curso',
                  options: kCursos,
                  selected: _cursosSelecionados,
                  onChanged: _onCursosChanged,
                ),
                const SizedBox(height: 14),
                MultiSelectField(
                  hint: 'Período',
                  options: periodosParaCursos(_cursosSelecionados),
                  selected: _periodosSelecionados,
                  enabled: _cursosSelecionados.isNotEmpty,
                  onChanged: (v) => setState(() => _periodosSelecionados = v),
                ),
                const SizedBox(height: 14),
                _MinistrantesField(
                  controller: _ministranteCtrl,
                  ministrantes: _ministrantes,
                  onAdicionar: _adicionarMinistrante,
                  onRemover: _removerMinistrante,
                ),
                const SizedBox(height: 28),
                PrimaryButton(
                  text: 'Publicar',
                  loading: _controller.carregando,
                  onPressed: _publicar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3B5EDF)),
      ),
    );
  }
}

// ── Widgets internos ──────────────────────────────────────────────────────────

class _CampoComIcone extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final VoidCallback onIconTap;

  const _CampoComIcone({
    required this.hint,
    required this.controller,
    required this.icon,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onIconTap,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B5EDF)),
        ),
        suffixIcon: IconButton(
          icon: Icon(icon, color: Colors.black45),
          onPressed: onIconTap,
        ),
      ),
    );
  }
}


class _MinistrantesField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> ministrantes;
  final VoidCallback onAdicionar;
  final ValueChanged<int> onRemover;

  const _MinistrantesField({
    required this.controller,
    required this.ministrantes,
    required this.onAdicionar,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Ministrante',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF3B5EDF)),
                  ),
                ),
                onSubmitted: (_) => onAdicionar(),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: onAdicionar,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B5EDF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 22),
              ),
            ),
          ],
        ),
        if (ministrantes.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: ministrantes
                .asMap()
                .entries
                .map(
                  (e) => Chip(
                    label: Text(e.value),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => onRemover(e.key),
                    backgroundColor: const Color(0xFFE8EDFF),
                    labelStyle: const TextStyle(color: Color(0xFF2F49D1)),
                    deleteIconColor: const Color(0xFF2F49D1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide.none,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}
