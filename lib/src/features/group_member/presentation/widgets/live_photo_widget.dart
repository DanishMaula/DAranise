import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/theme.dart';

class LivePhotoWidget extends StatefulWidget {
  final String? imagePath;
  final String? videoPath;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Widget? placeholder;
  final bool showLiveBadge;

  const LivePhotoWidget({
    super.key,
    required this.imagePath,
    this.videoPath,
    this.fit = BoxFit.cover,
    this.alignment = const Alignment(0, -0.2),
    this.borderRadius,
    this.onTap,
    this.placeholder,
    this.showLiveBadge = true,
  });

  @override
  State<LivePhotoWidget> createState() => _LivePhotoWidgetState();
}

class _LivePhotoWidgetState extends State<LivePhotoWidget> {
  VideoPlayerController? _videoController;
  bool _isInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void didUpdateWidget(covariant LivePhotoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      _disposeVideoPlayer();
      _initVideoPlayer();
    }
  }

  void _initVideoPlayer() {
    final video = widget.videoPath;
    if (video == null || video.trim().isEmpty) {
      _videoController = null;
      _isInitialized = false;
      return;
    }

    final isNetwork = video.startsWith('http://') || video.startsWith('https://');
    _videoController = isNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(video))
        : VideoPlayerController.asset(video);

    _videoController!.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }).catchError((error) {
      debugPrint('LivePhotoWidget: Gagal inisialisasi video ($error)');
      if (mounted) {
        setState(() {
          _isInitialized = false;
        });
      }
    });

    _videoController!.setLooping(true);
  }

  void _disposeVideoPlayer() {
    _videoController?.dispose();
    _videoController = null;
    _isInitialized = false;
    _isPlaying = false;
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }

  void _startLive() {
    if (_isInitialized && _videoController != null) {
      HapticFeedback.lightImpact();
      setState(() => _isPlaying = true);
      _videoController!.play();
    }
  }

  void _stopLive() {
    if (_isInitialized && _videoController != null && _isPlaying) {
      HapticFeedback.lightImpact();
      setState(() => _isPlaying = false);
      _videoController!.pause();
      _videoController!.seekTo(Duration.zero);
    }
  }

  Widget _buildStaticImage() {
    final path = widget.imagePath;
    if (path == null || path.trim().isEmpty) {
      return widget.placeholder ?? const SizedBox.shrink();
    }

    final isNetwork = path.startsWith('http://') || path.startsWith('https://');
    if (isNetwork) {
      return Image.network(
        path,
        fit: widget.fit,
        alignment: widget.alignment,
        errorBuilder: (context, error, stackTrace) =>
            widget.placeholder ?? const SizedBox.shrink(),
      );
    }

    return Image.asset(
      path,
      fit: widget.fit,
      alignment: widget.alignment,
      cacheWidth: 600,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) =>
          widget.placeholder ?? const SizedBox.shrink(),
    );
  }

  Widget _buildVideoPlayer() {
    if (!_isInitialized || _videoController == null) {
      return const SizedBox.shrink();
    }

    final videoSize = _videoController!.value.size;
    if (videoSize.width == 0 || videoSize.height == 0) {
      return const SizedBox.shrink();
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: widget.fit,
        alignment: widget.alignment,
        child: SizedBox(
          width: videoSize.width,
          height: videoSize.height,
          child: VideoPlayer(_videoController!),
        ),
      ),
    );
  }

  Widget _buildLiveBadge() {
    if (!widget.showLiveBadge || !_isInitialized) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 10,
      left: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _isPlaying
                  ? AppColors.deepBlush.withValues(alpha: 0.85)
                  : Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _isPlaying
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.35),
                width: 1,
              ),
              boxShadow: _isPlaying
                  ? [
                      BoxShadow(
                        color: AppColors.deepBlush.withValues(alpha: 0.4),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.motion_photos_on_rounded,
                  color: Colors.white,
                  size: 13,
                ),
                SizedBox(width: 4),
                Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Stack(
      fit: StackFit.expand,
      children: [
        // 1. Layer Bawah: Video Player (aktif saat diinisialisasi)
        _buildVideoPlayer(),

        // 2. Layer Atas: Gambar Statis (memudar saat live photo sedang aktif)
        AnimatedOpacity(
          opacity: _isPlaying && _isInitialized ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          child: _buildStaticImage(),
        ),

        // 3. iOS Live Photo Badge
        _buildLiveBadge(),
      ],
    );

    if (widget.borderRadius != null) {
      content = ClipRRect(
        borderRadius: widget.borderRadius!,
        child: content,
      );
    }

    return GestureDetector(
      // Tahan / Long Press untuk memicu animasi Live Photo (seperti native iOS)
      onLongPressStart: (_) => _startLive(),
      onLongPressEnd: (_) => _stopLive(),
      onLongPressCancel: _stopLive,
      // Tap biasa untuk aksi seperti membuka fullscreen
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}
