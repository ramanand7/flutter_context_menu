import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'web_helper_stub.dart' if (dart.library.html) 'web_helper_web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Context Menu Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Segoe UI',
      ),
      home: DemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildResponsiveBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return AppBar(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'Context Menu Demo',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 1,
      centerTitle: isSmallScreen,
    );
  }

  Widget _buildResponsiveBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        EdgeInsets padding;
        int crossAxisCount;
        double titleFontSize;
        double spacing;
        double minCardHeight;

        if (screenWidth < 350) {
          padding = EdgeInsets.all(8.0);
          crossAxisCount = 1;
          titleFontSize = 14;
          spacing = 8;
          minCardHeight = 80;
        } else if (screenWidth < 500) {
          padding = EdgeInsets.all(12.0);
          crossAxisCount = 2;
          titleFontSize = 15;
          spacing = 10;
          minCardHeight = 90;
        } else if (screenWidth < 768) {
          padding = EdgeInsets.all(16.0);
          crossAxisCount = 2;
          titleFontSize = 16;
          spacing = 12;
          minCardHeight = 100;
        } else if (screenWidth < 1024) {
          padding = EdgeInsets.all(24.0);
          crossAxisCount = 3;
          titleFontSize = 17;
          spacing = 16;
          minCardHeight = 110;
        } else if (screenWidth < 1400) {
          padding = EdgeInsets.all(32.0);
          crossAxisCount = 4;
          titleFontSize = 18;
          spacing = 20;
          minCardHeight = 120;
        } else {
          padding = EdgeInsets.all(40.0);
          crossAxisCount = 4;
          titleFontSize = 18;
          spacing = 24;
          minCardHeight = 130;
        }

        return SingleChildScrollView(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - padding.vertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context, titleFontSize, screenWidth),
                SizedBox(height: spacing * 1.5),
                _buildFlexibleGrid(
                  context,
                  crossAxisCount,
                  spacing,
                  screenWidth,
                  minCardHeight,
                ),
                SizedBox(height: spacing),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(
      BuildContext context, double fontSize, double screenWidth) {
    return Container(
      width: double.infinity,
      child: Text(
        'Right-click on any item below to see the context menu:',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
          height: 1.4,
        ),
        maxLines: screenWidth < 350 ? 3 : 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildFlexibleGrid(
    BuildContext context,
    int crossAxisCount,
    double spacing,
    double screenWidth,
    double minCardHeight,
  ) {
    final items = [
      _DemoItem('Document', Icons.description, Colors.blue),
      _DemoItem('Image', Icons.image, Colors.green),
      _DemoItem('Video', Icons.video_file, Colors.red),
      _DemoItem('Audio', Icons.audio_file, Colors.orange),
      _DemoItem('Folder', Icons.folder, Colors.purple),
      _DemoItem('Archive', Icons.archive, Colors.teal),
      _DemoItem('PDF', Icons.picture_as_pdf, Colors.deepOrange),
      _DemoItem('Spreadsheet', Icons.table_chart, Colors.lightGreen),
      _DemoItem('Presentation', Icons.slideshow, Colors.deepPurple),
      _DemoItem('Code', Icons.code, Colors.indigo),
      _DemoItem('Settings', Icons.settings, Colors.grey),
      _DemoItem('Cloud', Icons.cloud, Colors.blueGrey),
      _DemoItem('Starred', Icons.star, Colors.amber),
      _DemoItem('Calendar', Icons.calendar_today, Colors.cyan),
      _DemoItem('Contact', Icons.contact_mail, Colors.pink),
      _DemoItem('Map', Icons.map, Colors.lime),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1.3,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildDemoCard(items[index], screenWidth, minCardHeight);
      },
    );
  }

  Widget _buildDemoCard(
      _DemoItem item, double screenWidth, double minCardHeight) {
    double iconSize;
    double titleFontSize;
    double borderRadius;
    double cardPadding;

    if (screenWidth < 350) {
      iconSize = 28;
      titleFontSize = 12;
      borderRadius = 6;
      cardPadding = 8;
    } else if (screenWidth < 500) {
      iconSize = 32;
      titleFontSize = 13;
      borderRadius = 7;
      cardPadding = 10;
    } else if (screenWidth < 768) {
      iconSize = 36;
      titleFontSize = 14;
      borderRadius = 8;
      cardPadding = 12;
    } else if (screenWidth < 1024) {
      iconSize = 42;
      titleFontSize = 15;
      borderRadius = 10;
      cardPadding = 14;
    } else {
      iconSize = 48;
      titleFontSize = 16;
      borderRadius = 12;
      cardPadding = 16;
    }

    return ContextMenu(
      child: Container(
        constraints: BoxConstraints(
          minHeight: minCardHeight,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: iconSize,
                    color: item.color,
                  ),
                  SizedBox(height: cardPadding * 0.5),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

class _DemoItem {
  final String title;
  final IconData icon;
  final Color color;

  _DemoItem(this.title, this.icon, this.color);
}

class Interceptor extends StatelessWidget {
  final Widget child;

  const Interceptor({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _WebInterceptor(child: child);
    } else {
      return child;
    }
  }
}

class _WebInterceptor extends StatefulWidget {
  final Widget child;

  const _WebInterceptor({Key? key, required this.child}) : super(key: key);

  @override
  _WebInterceptorState createState() => _WebInterceptorState();
}

class _WebInterceptorState extends State<_WebInterceptor> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setupWebInterceptor();
      });
    }
  }

  void _setupWebInterceptor() {
    if (kIsWeb) {
      WebHelper.disableContextMenu();
    }
  }

  @override
  void dispose() {
    if (kIsWeb) {
      WebHelper.enableContextMenu();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ContextMenu extends StatefulWidget {
  final Widget child;

  const ContextMenu({Key? key, required this.child}) : super(key: key);

  @override
  _ContextMenuState createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Interceptor(
      child: GestureDetector(
        key: _childKey,
        onSecondaryTapDown: _showContextMenu,
        onLongPress: () {
          final RenderBox? renderBox =
              _childKey.currentContext?.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            final center =
                renderBox.localToGlobal(renderBox.size.center(Offset.zero));
            _showContextMenuAt(center);
          }
        },
        child: widget.child,
      ),
    );
  }

  void _showContextMenu(TapDownDetails details) {
    _showContextMenuAt(details.globalPosition);
  }

  void _showContextMenuAt(Offset position) {
    _hideContextMenu();

    final RenderBox? renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final childPosition = renderBox.localToGlobal(Offset.zero);
    final childSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => _ContextMenuOverlay(
        onDismiss: _hideContextMenu,
        childPosition: childPosition,
        childSize: childSize,
        tapPosition: position,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideContextMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideContextMenu();
    super.dispose();
  }
}

class _ContextMenuOverlay extends StatefulWidget {
  final VoidCallback onDismiss;
  final Offset childPosition;
  final Size childSize;
  final Offset tapPosition;

  const _ContextMenuOverlay({
    Key? key,
    required this.onDismiss,
    required this.childPosition,
    required this.childSize,
    required this.tapPosition,
  }) : super(key: key);

  @override
  _ContextMenuOverlayState createState() => _ContextMenuOverlayState();
}

class _ContextMenuOverlayState extends State<_ContextMenuOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: _calculateMenuPosition(context).dx,
              top: _calculateMenuPosition(context).dy,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: Alignment.topLeft,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: _buildContextMenu(context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Offset _calculateMenuPosition(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final menuSize = _getMenuSize(context);
    final safeAreaPadding = MediaQuery.of(context).padding;
    final minPadding = 8.0;

    final availableWidth = screenSize.width - safeAreaPadding.horizontal;
    final availableHeight = screenSize.height - safeAreaPadding.vertical;

    double x = widget.tapPosition.dx;
    double y = widget.tapPosition.dy;

    if (x + menuSize.width > availableWidth - minPadding) {
      x = availableWidth - menuSize.width - minPadding;
    }

    if (y + menuSize.height > availableHeight - minPadding) {
      y = availableHeight - menuSize.height - minPadding;
    }

    if (x < safeAreaPadding.left + minPadding) {
      x = safeAreaPadding.left + minPadding;
    }

    if (y < safeAreaPadding.top + minPadding) {
      y = safeAreaPadding.top + minPadding;
    }

    final childRect = Rect.fromLTWH(
      widget.childPosition.dx,
      widget.childPosition.dy,
      widget.childSize.width,
      widget.childSize.height,
    );

    final menuRect = Rect.fromLTWH(x, y, menuSize.width, menuSize.height);

    if (menuRect.overlaps(childRect)) {
      final strategies = [
        Offset(childRect.right + minPadding, y),
        Offset(childRect.left - menuSize.width - minPadding, y),
        Offset(x, childRect.bottom + minPadding),
        Offset(x, childRect.top - menuSize.height - minPadding),
        Offset(childRect.right + minPadding, childRect.top),
        Offset(childRect.left - menuSize.width - minPadding, childRect.top),
        Offset(
            childRect.right + minPadding, childRect.bottom - menuSize.height),
        Offset(childRect.left - menuSize.width - minPadding,
            childRect.bottom - menuSize.height),
      ];

      for (final strategy in strategies) {
        if (strategy.dx >= safeAreaPadding.left + minPadding &&
            strategy.dy >= safeAreaPadding.top + minPadding &&
            strategy.dx + menuSize.width <= availableWidth - minPadding &&
            strategy.dy + menuSize.height <= availableHeight - minPadding) {
          return strategy;
        }
      }

      x = (availableWidth - menuSize.width) / 2;
      y = (availableHeight - menuSize.height) / 2;
    }

    return Offset(x, y);
  }

  Size _getMenuSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 350) {
      return Size(140, 120);
    } else if (screenWidth < 500) {
      return Size(150, 125);
    } else if (screenWidth < 768) {
      return Size(160, 132);
    } else {
      return Size(180, 140);
    }
  }

  Widget _buildContextMenu(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final menuSize = _getMenuSize(context);
    final isVerySmallScreen = screenWidth < 350;
    final isSmallScreen = screenWidth < 768;

    return Container(
      width: menuSize.width,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            isVerySmallScreen ? 4 : (isSmallScreen ? 6 : 8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: isSmallScreen ? 6 : 10,
            offset: Offset(0, isSmallScreen ? 2 : 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: isSmallScreen ? 12 : 20,
            offset: Offset(0, isSmallScreen ? 4 : 8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem(
              context,
              icon: Icons.add,
              text: 'Create',
              onTap: () {
                widget.onDismiss();
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              context,
              icon: Icons.edit,
              text: 'Edit',
              onTap: () {
                widget.onDismiss();
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              context,
              icon: Icons.delete,
              text: 'Remove',
              onTap: () {
                widget.onDismiss();
              },
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 350;
    final isSmallScreen = screenWidth < 768;

    double iconSize = isVerySmallScreen ? 14 : (isSmallScreen ? 16 : 18);
    double fontSize = isVerySmallScreen ? 11 : (isSmallScreen ? 13 : 14);
    double horizontalPadding =
        isVerySmallScreen ? 8 : (isSmallScreen ? 12 : 16);
    double verticalPadding = isVerySmallScreen ? 8 : (isSmallScreen ? 10 : 12);
    double spacing = isVerySmallScreen ? 8 : (isSmallScreen ? 10 : 12);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
            isVerySmallScreen ? 3 : (isSmallScreen ? 4 : 6)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: isDestructive ? Colors.red[600] : Colors.grey[700],
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: isDestructive ? Colors.red[600] : Colors.grey[800],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth < 350 ? 4.0 : 8.0;

    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: margin),
      color: Colors.grey[200],
    );
  }
}
