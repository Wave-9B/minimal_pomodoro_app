import 'package:flutter/material.dart';
import 'package:pomodoro_app/app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/app/theme/theme_notifier.dart';

class NeumorphicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double borderRadius;
  final Color? color;
  final bool isCircle;
  final bool isClickable;
  final bool isButtonActive; //identificar se botao será afundado
  final EdgeInsetsGeometry paddingSize;
  final double? width;
  final double? height;

  const NeumorphicButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 16.0,
    this.color,
    this.isCircle = true,
    this.isClickable = true,
    this.isButtonActive = false,
    this.paddingSize = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.width,
    this.height,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  // buttonPressed
  bool _isPressed = false;

  // 3. Funções para atualizar o estado no toque.
  void _onPointerDown(TapDownDetails details) {
    if (widget.isClickable) {
      setState(() => _isPressed = true);
    }
  }

  void _onPointerUp(TapUpDetails details) {
    if (widget.isClickable) {
      setState(() => _isPressed = false);
    }
  }

  void _onTapCancel() {
    if (widget.isClickable) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isVisuallyPressed = widget.isButtonActive || _isPressed;

    bool isDark = Provider.of<ThemeNotifier>(context).isDark;

      // ajusta button size conforme screen size
  // final screenWidth = MediaQuery.of(context).size.width;
  // final screenHeight = MediaQuery.of(context).size.height;

  //  final double width = widget.width ?? screenWidth * 0.2;
  // final double height = widget.height ?? (screenHeight * 0.06).clamp(40, 60);

    // Definir a cor do botão com base no tema atual
    final bgColor = widget.color ?? Theme.of(context).colorScheme.surface;

    //  GestureDetector
    return GestureDetector(
      onTapDown: _onPointerDown,
      onTapUp: _onPointerUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        if (widget.isClickable) {
          Feedback.forTap(context);
          widget.onPressed();
        }
      },
      // AnimatedContainer é igual container, mas com animação
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 150,
        ), // Duração da animação de "afundar"

        width: widget.width,
        height: widget.height,
        padding: widget.paddingSize,
        decoration: BoxDecoration(
          color: isDark
              ? Theme.of(context).colorScheme.surfaceContainerLow
              : Theme.of(context).colorScheme.surface,
          shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: widget.isCircle
              ? null
              : BorderRadius.circular(widget.borderRadius),

          // se _isPressed == true, "afundar" botão
          boxShadow: isVisuallyPressed
              ? [
                  BoxShadow(
                    color: isDark
                        ? AppThemes.lightShadowDarkMode(bgColor)
                        : AppThemes.lightShadowLightMode(bgColor),
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                    spreadRadius: -1,
                  ),
                  BoxShadow(
                    color: isDark
                        ? AppThemes.darkShadowDarkMode(bgColor)
                        : AppThemes.darkShadowLightMode(bgColor),
                    offset: const Offset(-2, -2),
                    blurRadius: 2,
                    spreadRadius: -1,
                  ),
                ]
              : [
                  // operação ternaria, se _isPressed == false, botao volta ao normal
                  BoxShadow(
                    color: isDark
                        ? AppThemes.darkShadowDarkMode(bgColor)
                        : AppThemes.darkShadowLightMode(bgColor),
                    offset: const Offset(4, 4),
                    blurRadius: 2,
                    spreadRadius: -1,
                  ),
                  BoxShadow(
                    color: isDark
                        ? AppThemes.lightShadowDarkMode(bgColor)
                        : AppThemes.lightShadowLightMode(bgColor),
                    offset: const Offset(-4, -4),
                    blurRadius: 2,
                    spreadRadius: -1,
                  ),
                ],
        ),
        // isso faz com q oq ta dentro do botão também "afunde"
        child: Transform.translate(
          offset: isVisuallyPressed ? const Offset(1, 1) : Offset.zero,
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
