import 'package:flutter/material.dart';

class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final double gap;
  final Axis direction;

  const MarqueeText({
    Key? key,
    required this.text,
    this.style,
    this.duration = const Duration(seconds: 5),
    this.gap = 50.0,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startScrolling() {
    if (!mounted || _scrollController.hasClients == false) return;

    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    
    if (maxScrollExtent > 0) {
      setState(() {
        _isScrolling = true;
      });

      _animationController.addListener(() {
        if (_scrollController.hasClients) {
          final value = _animationController.value;
          _scrollController.jumpTo(value * maxScrollExtent);
        }
      });

      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scrollController.jumpTo(0.0);
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              _animationController.reset();
              _animationController.forward();
            }
          });
        }
      });

      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRect(
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: widget.direction,
            physics: const NeverScrollableScrollPhysics(),
            child: widget.direction == Axis.horizontal
                ? Row(
                    children: [
                      Text(
                        widget.text,
                        style: widget.style,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(width: widget.gap),
                      Text(
                        widget.text,
                        style: widget.style,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        widget.text,
                        style: widget.style,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: widget.gap),
                      Text(
                        widget.text,
                        style: widget.style,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}