import 'package:flutter/material.dart';

class LogoutDialog {
  static void show(BuildContext context, {required VoidCallback onConfirm}) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),

          contentPadding: const EdgeInsets.all(24),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const Icon(Icons.error_outline, size: 40, color: Colors.black87),

              const SizedBox(height: 16),

              const Text(
                "Tem certeza que deseja sair?",

                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              const Text(
                "Você poderá voltar a qualquer hora",

                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF3131),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        child: const Text(
                          "Sair",

                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: SizedBox(
                      height: 50,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D4DB3),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        child: const Text(
                          "Cancelar",

                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
