import 'package:flutter/material.dart';

enum SignInProvider { google, apple }

class SocialSignInButton extends StatelessWidget {
  final SignInProvider provider;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialSignInButton({
    super.key,
    required this.provider,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: _getBackgroundColor(isDark),
        side: BorderSide(
          color: _getBorderColor(isDark),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(width: 12),
          Text(
            _getLabel(),
            style: TextStyle(
              color: _getTextColor(isDark),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    switch (provider) {
      case SignInProvider.google:
        return _GoogleIcon();
      case SignInProvider.apple:
        return const Icon(
          Icons.apple,
          size: 24,
        );
    }
  }

  String _getLabel() {
    switch (provider) {
      case SignInProvider.google:
        return 'Continue with Google';
      case SignInProvider.apple:
        return 'Continue with Apple';
    }
  }

  Color _getBackgroundColor(bool isDark) {
    switch (provider) {
      case SignInProvider.google:
        return isDark ? Colors.grey[800]! : Colors.white;
      case SignInProvider.apple:
        return isDark ? Colors.white : Colors.black;
    }
  }

  Color _getBorderColor(bool isDark) {
    switch (provider) {
      case SignInProvider.google:
        return isDark ? Colors.grey[600]! : Colors.grey[300]!;
      case SignInProvider.apple:
        return isDark ? Colors.white : Colors.black;
    }
  }

  Color _getTextColor(bool isDark) {
    switch (provider) {
      case SignInProvider.google:
        return isDark ? Colors.white : Colors.black87;
      case SignInProvider.apple:
        return isDark ? Colors.black : Colors.white;
    }
  }
}

// Custom Google icon (using Material icon as fallback)
class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using a simplified Google-like icon
    // In production, you might want to use an actual Google logo asset
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          'G',
          style: TextStyle(
            color: Colors.red[600],
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
