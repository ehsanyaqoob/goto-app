import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:goto/Constants/Theme/app_colors.dart';

class AnimatedGradientBackground extends StatefulWidget {
  final Widget? child;
  const AnimatedGradientBackground({super.key, this.child});

  @override
  State<AnimatedGradientBackground> createState() => 
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState 
    extends State<AnimatedGradientBackground> with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late Animation<double> _gradientAnimation;
  
  // iOS-style gradient colors (softer, more pastel)
  final List<Color> _colors = [
    const Color(0xFF007AFF).withOpacity(0.8),  // iOS system blue
    const Color(0xFF5856D6).withOpacity(0.8),  // iOS system purple
    const Color(0xFFAF52DE).withOpacity(0.8),  // iOS system pink
    const Color(0xFF34C759).withOpacity(0.6),  // iOS system green


  ];
  
  final List<double> _stops = [0.0, 0.3, 0.6, 1.0];

  @override
  void initState() {
    super.initState();
    
    _gradientController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);
    
    _gradientAnimation = CurvedAnimation(
      parent: _gradientController,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        AnimatedBuilder(
          animation: _gradientAnimation,
          builder: (context, child) {
            final double value = _gradientAnimation.value;
            
            return Container(
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  center: Alignment(
                    0.5 + 0.1 * math.sin(value * math.pi * 2),
                    0.5 + 0.1 * math.cos(value * math.pi * 2),
                  ),
                  startAngle: value * math.pi,
                  endAngle: value * math.pi + math.pi * 1.5,
                  colors: _colors,
                  stops: _stops,
                  transform: GradientRotation(value * math.pi * 2),
                ),
              ),
            );
          },
        ),
        
        // Particle overlay
        const AnimatedParticleBackground(),
        
        // Child content
        if (widget.child != null) widget.child!,
      ],
    );
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }
}

class AnimatedParticleBackground extends StatefulWidget {
  const AnimatedParticleBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedParticleBackground> createState() => _AnimatedParticleBackgroundState();
}

class _AnimatedParticleBackgroundState extends State<AnimatedParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();
  final int _particleCount = 50;

  @override
  void initState() {
    super.initState();
    
    // Initialize particles with random positions within screen bounds
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(Particle(
        x: _random.nextDouble() * 2 - 1, // -1 to 1 range
        y: _random.nextDouble() * 2 - 1,
        size: 2.0 + _random.nextDouble() * 4.0,
        speed: 0.5 + _random.nextDouble() * 1.5,
        alpha: 0.15 + _random.nextDouble() * 0.15,
        direction: _random.nextDouble() * math.pi * 2,
      ));
    }
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
    
    _controller.addListener(_updateParticles);
  }

  void _updateParticles() {
    setState(() {
      final time = _controller.value * math.pi * 2;
      
      for (final particle in _particles) {
        // Update position based on direction and speed
        particle.x += math.cos(particle.direction) * particle.speed * 0.005;
        particle.y += math.sin(particle.direction) * particle.speed * 0.005;
        
        // Wrap around screen edges
        if (particle.x > 1.2) particle.x = -1.2;
        if (particle.x < -1.2) particle.x = 1.2;
        if (particle.y > 1.2) particle.y = -1.2;
        if (particle.y < -1.2) particle.y = 1.2;
        
        // Subtle pulsing effect
        particle.alpha = 0.15 + 0.1 * math.sin(time + particle.x * math.pi);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlePainter(particles: _particles),
      size: Size.infinite,
    );
  }
}

class Particle {
  double x;
  double y;
  final double size;
  final double speed;
  double alpha;
  double direction;
  
  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.alpha,
    required this.direction,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  
  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    for (final particle in particles) {
      final position = Offset(
        centerX + particle.x * centerX * 0.8,
        centerY + particle.y * centerY * 0.8,
      );
      
      // Glow effect
      final glowPaint = Paint()
        ..color = Colors.white.withOpacity(particle.alpha * 0.7)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
      
      canvas.drawCircle(position, particle.size * 1.5, glowPaint);
      
      // Main particle
      final particlePaint = Paint()
        ..color = Colors.white.withOpacity(particle.alpha)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);
      
      canvas.drawCircle(position, particle.size, particlePaint);
      
      // Bright core
      final corePaint = Paint()
        ..color = Colors.white.withOpacity(particle.alpha * 1.5);
      
      canvas.drawCircle(position, particle.size * 0.5, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}