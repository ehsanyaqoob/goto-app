import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SuccessSummaryDialog extends StatefulWidget {
  @override
  _SuccessSummaryDialogState createState() => _SuccessSummaryDialogState();
}

class _SuccessSummaryDialogState extends State<SuccessSummaryDialog> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconBounceAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _contentSlideAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    
    // Main dialog scale animation
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
    
    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );
    
    // Checkmark icon scale animation
    _iconScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    
    // Checkmark bounce animation
    _iconBounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -15.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -15.0, end: 0.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 0.0), weight: 25),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.8, curve: Curves.easeInOut),
      ),
    );
    
    // Color pulse animation
    _colorAnimation = ColorTween(
      begin: CupertinoColors.activeGreen.withOpacity(0.5),
      end: CupertinoColors.activeGreen,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );
    
    // Content slide animation
    _contentSlideAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedCheckmark() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _iconBounceAnimation.value),
          child: Transform.scale(
            scale: _iconScaleAnimation.value,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.checkmark_alt,
                size: 50,
                color: CupertinoColors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground.resolveFrom(context),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAnimatedCheckmark(),
                  SizedBox(height: 16),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _contentSlideAnimation.value),
                        child: Opacity(
                          opacity: _contentSlideAnimation.value == 20.0 
                              ? 0.0 
                              : 1.0,
                          child: Column(
                            children: [
                              Text(
                                "Task Master!",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.activeGreen,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "5 tasks completed!",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "You're crushing it today! 💪",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _contentSlideAnimation.value),
                        child: Opacity(
                          opacity: _contentSlideAnimation.value == 20.0 
                              ? 0.0 
                              : 1.0,
                          child: CupertinoButton(
                            borderRadius: BorderRadius.circular(12),
                            color: CupertinoColors.activeGreen,
                            child: Text(
                              "Keep Going",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}