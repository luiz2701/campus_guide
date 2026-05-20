/*
  Utilitários de diálogos usados no fluxo de autenticação/registro.

  Contém diálogos reutilizáveis que exibem mensagens ao usuário durante o
  processo de confirmação de e-mail e navegam para a tela de `Login`
  quando apropriado. Todos os diálogos aqui são exibidos via `showDialog`
  e, por padrão, não são `barrierDismissible` (o usuário não pode fechar com
  toque fora) — o controle de fechamento é feito programaticamente.
*/
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:campus_guide/routes/app_routes.dart';

class Popups {
  /// Mostra um diálogo de aguardando confirmação de e-mail.
  ///
  /// - Exibe um diálogo não-dispensável que aguarda por um tempo (timer).
  /// - Se o timer expirar, fecha o diálogo atual e abre o diálogo
  ///   `naoEncontrado` para indicar falha na confirmação.
  /// - Possui ação para reenviar/avançar que manipula a navegação para
  ///   a tela de `Login` quando necessário.
  void esperandoConfirmacao(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        Timer(Duration(seconds: 5), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
            naoEncontrado(context);
          }
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,

          shape: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 27, 93, 146),
              width: 12,
            ),
          ),

          backgroundColor: Colors.white,

          content: Container(
            width: 320,
            height: 190,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 110),
                          child: Icon(Icons.error_outline),
                        ),

                        IconButton(
                          style:
                              IconButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ).copyWith(
                                overlayColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                              ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                          iconSize: 15,
                        ),
                      ],
                    ),
                    Text(
                      'Espereando confirmação...',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Enviamos um link de confirmação para seu',
                      style: TextStyle(
                        fontSize: 13,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    Text(
                      'email institucional',
                      style: TextStyle(
                        fontSize: 13,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    Text(
                      'Confirme seu email para prosseguir',
                      style: TextStyle(
                        fontSize: 13,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Container(
                  width: 240,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 203, 195, 195),
                  ),
                  child: Center(
                    child: Text(
                      "Aguardando...",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),

          actionsPadding: EdgeInsets.only(bottom: 18.0),

          actions: [
            Align(
              alignment: Alignment.topCenter,
              child: TextButton(
                style:
                    TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      splashFactory: NoSplash.splashFactory,
                    ).copyWith(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                child: Text("Reenviar email", style: TextStyle(fontSize: 12)),
                onPressed: () {
                  Navigator.pop(context);
                  encontrado(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// Mostra o diálogo indicando que o e-mail não foi confirmado.
  ///
  /// - O botão "Voltar" fecha o diálogo atual e redireciona para
  ///   a tela de login via `Navigator.pushReplacementNamed(context, AppRoutes.login)`.
  void naoEncontrado(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,

          shape: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 27, 93, 146),
              width: 12,
            ),
          ),

          backgroundColor: Colors.white,

          content: Container(
            width: 320,
            height: 135,
            padding: EdgeInsets.zero,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel_outlined, size: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Email não confirmado',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Text(
                        'Não foi possivel confirmar seu email. Verivique',
                        style: TextStyle(
                          fontSize: 13,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      Text(
                        'se seu email está correto e tente novamente',
                        style: TextStyle(
                          fontSize: 13,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          actionsPadding: EdgeInsets.only(
            top: 0,
            bottom: 35,
            right: 0,
            left: 0,
          ),

          actions: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 240,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 219, 3, 3),
                ),
                child: TextButton(
                  style:
                      TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        splashFactory: NoSplash.splashFactory,
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                  child: Text(
                    "Voltar",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Mostra o diálogo indicando que o e-mail foi confirmado com sucesso.
  ///
  /// - O botão "Avançar" fecha o diálogo atual e redireciona para
  ///   a tela de login via `Navigator.pushReplacementNamed(context, AppRoutes.login)`.
  void encontrado(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,

          shape: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 27, 93, 146),
              width: 12,
            ),
          ),

          backgroundColor: Colors.white,

          content: Container(
            width: 320,
            height: 135,
            padding: EdgeInsets.zero,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Email confirmado',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Text(
                        'Seu email foi confirmado com sucesso!',
                        style: TextStyle(
                          fontSize: 13,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      Text(
                        'Você já pode prosseguir.',
                        style: TextStyle(
                          fontSize: 13,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          actionsPadding: EdgeInsets.only(
            top: 0,
            bottom: 35,
            right: 0,
            left: 0,
          ),

          actions: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 240,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 1, 38, 202),
                ),
                child: TextButton(
                  style:
                      TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        splashFactory: NoSplash.splashFactory,
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                  child: Text(
                    "Avançar",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
