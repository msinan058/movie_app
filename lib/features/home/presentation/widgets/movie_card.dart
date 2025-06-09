import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/core/extensions/string_extensions.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final double height;
  final int index;
  final ValueNotifier<bool> _isFavorite;
  final ValueNotifier<bool> _isExpanded;

  MovieCard({
    super.key,
    required this.movie,
    required this.height,
    required this.index,
  }) : _isFavorite = ValueNotifier(movie.isFavorite ?? false),
       _isExpanded = ValueNotifier(false);

  void _toggleDescription() {
    _isExpanded.value = !_isExpanded.value;
  }

  void _toggleFavorite(BuildContext context) {
    _isFavorite.value = !_isFavorite.value;
    
    if (movie.id != null) {
      context.read<HomeBloc>().add(ToggleFavorite(movie.id!, index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allImages = [movie.posterUrl?.fixImageUrl ?? 'https://picsum.photos/500/800', ...?movie.images?.take(5)];
    
    return SizedBox(
      height: height,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allImages.length,
        itemBuilder: (context, pageIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                CachedNetworkImage(
                  imageUrl: allImages[pageIndex].fixImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: theme.colorScheme.surface,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: theme.colorScheme.surface,
                    child: Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: theme.colorScheme.onSurface.withAlpha((0.5 * 255).round()),
                        size: 64,
                      ),
                    ),
                  ),
                ),
                // Gradient overlay at bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 250,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: theme.brightness == Brightness.dark 
                            ? [
                                Colors.transparent,
                                Colors.black.withAlpha((0.9 * 255).round()),
                              ]
                            : [
                                Colors.transparent,
                                Colors.black.withAlpha((0.7 * 255).round()),
                              ],
                      ),
                    ),
                  ),
                ),
                // Content
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              movie.title ?? 'Untitled',
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface.withAlpha((0.25 * 255).round()),
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                color: theme.colorScheme.onSurface.withAlpha((0.2 * 255).round()),
                                width: 0.5,
                              ),
                            ),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: _isFavorite,
                              builder: (context, isFavorite, _) {
                                return GestureDetector(
                                  onTap: () => _toggleFavorite(context),
                                  child: SvgPicture.asset(
                                    'assets/icons/favicon.svg',
                                    colorFilter: ColorFilter.mode(
                                      isFavorite ? theme.colorScheme.primary : Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 24,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ValueListenableBuilder<bool>(
                        valueListenable: _isExpanded,
                        builder: (context, isExpanded, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: _toggleDescription,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  constraints: BoxConstraints(
                                    maxHeight: isExpanded ? 200 : 48,
                                  ),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final String description = movie.description ?? 'No description available';
                                      final textSpan = TextSpan(
                                        text: description,
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                          color: Colors.white70,
                                        ),
                                      );
                                      final textPainter = TextPainter(
                                        text: textSpan,
                                        textDirection: TextDirection.ltr,
                                        maxLines: 2,
                                      );
                                      textPainter.layout(maxWidth: constraints.maxWidth);
                                      
                                      final bool doesTextOverflow = textPainter.didExceedMaxLines;
                                      
                                      if (isExpanded) {
                                        return SingleChildScrollView(
                                          physics: const BouncingScrollPhysics(),
                                          child: Text(
                                            description,
                                            style: theme.textTheme.bodyLarge?.copyWith(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        );
                                      }

                                      if (!doesTextOverflow) {
                                        return Text(
                                          description,
                                          style: theme.textTheme.bodyLarge?.copyWith(
                                            color: Colors.white70,
                                          ),
                                          maxLines: 2,
                                        );
                                      }

                                      // Calculate first line text
                                      final firstLinePainter = TextPainter(
                                        text: textSpan,
                                        textDirection: TextDirection.ltr,
                                        maxLines: 1,
                                      );
                                      firstLinePainter.layout(maxWidth: constraints.maxWidth);
                                      final firstLineEnd = firstLinePainter.getPositionForOffset(Offset(firstLinePainter.width, 0)).offset;
                                      
                                      final firstLine = description.substring(0, firstLineEnd);
                                      final remainingText = description.substring(firstLineEnd);

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // First line - full width
                                          Text(
                                            firstLine,
                                            style: theme.textTheme.bodyLarge?.copyWith(
                                              color: Colors.white70,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          // Second line - 80% width + More
                                          SizedBox(
                                            width: constraints.maxWidth,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 80,
                                                  child: Text(
                                                    remainingText,
                                                    style: theme.textTheme.bodyLarge?.copyWith(
                                                      color: Colors.white70,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    'Daha Fazlası',
                                                    style: theme.textTheme.titleSmall?.copyWith(
                                                      color: Colors.white.withAlpha((0.9 * 255).round()),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              if (!isExpanded) const SizedBox(height: 4),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 