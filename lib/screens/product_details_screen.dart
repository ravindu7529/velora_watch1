import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String price;
  final String image;
  final String description;

  const ProductDetailScreen({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  void _onPressedDown(TapDownDetails details) {
    _animationController.reverse();
  }

  void _onPressedUp(TapUpDetails details) {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLandscape ? _buildLandscapeLayout() : _buildPortraitLayout(),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(widget.image, height: 200),
        const SizedBox(height: 16),
        Text(widget.name, style: Theme.of(context).textTheme.titleLarge),
        Text(
          widget.price,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.red),
        ),
        const SizedBox(height: 16),
        Text(widget.description),
        const SizedBox(height: 16),
        GestureDetector(
          onTapDown: _onPressedDown,
          onTapUp: _onPressedUp,
          onTapCancel: () => _animationController.forward(),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added to cart!')),
            );
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: ElevatedButton(
              onPressed: null,
              child: const Text('Add to Cart'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added to favourites!')),
            );
          },
          child: ElevatedButton(
            onPressed: null,
            child: const Text('Add to Favourites'),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Image.asset(widget.image, height: 200),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name, style: Theme.of(context).textTheme.titleLarge),
              Text(
                widget.price,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.red),
              ),
              const SizedBox(height: 16),
              Text(widget.description),
              const SizedBox(height: 16),
              GestureDetector(
                onTapDown: _onPressedDown,
                onTapUp: _onPressedUp,
                onTapCancel: () => _animationController.forward(),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart!')),
                  );
                },
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ElevatedButton(
                    onPressed: null,
                    child: const Text('Add to Cart'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to favourites!')),
                  );
                },
                child: ElevatedButton(
                  onPressed: null,
                  child: const Text('Add to Favourites'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
