part of 'home_page.dart';
typedef OnLikeCallback = void Function(bool isLiked)?;

class _MyCardWidget extends StatefulWidget {
  final String text;
  final String description;
  final String? image;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;
  const _MyCardWidget(
      this.text, {
        required this.description,
        this.image,
        this.onLike,
        this.onTap,
      });
  factory _MyCardWidget.formData(CardData data, {OnLikeCallback onLike, VoidCallback? onTap,}) => _MyCardWidget(
    data.text,
    description: data.description,
    image: data.image,
    onLike: onLike,
    onTap: onTap,
  );

  @override
  State<_MyCardWidget> createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends State<_MyCardWidget> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        constraints: const BoxConstraints(minHeight: 140),
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
              width: 3,
            )
        ),
        child: IntrinsicHeight(
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: SizedBox(
                  height: double.infinity,
                  width: 150,
                  child: Image.network(
                    widget.image ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Placeholder(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 16, bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                      widget.onLike?.call(isLiked);
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isLiked
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        key: ValueKey<int>(0),
                      )
                          : const Icon(
                        Icons.favorite_border,
                        key: ValueKey<int>(1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}