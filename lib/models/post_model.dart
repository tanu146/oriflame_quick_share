class ProductModel {
  final String name;
  final String price;
  final String discount;
  final String imageUrl;
  final String productUrl;

  ProductModel({
    required this.name,
    required this.price,
    required this.discount,
    required this.imageUrl,
    required this.productUrl,
  });
}

class PostModel {
  final String id;
  final String imageUrl;
  final String profileImage;
  final String username;
  final String caption;
  final String musicName;
  final String? audioUrl;
  final ProductModel? product;
  final String referralCode;
  final String referralLink;
  final String? localAssetName;

  PostModel({
    required this.id,
    required this.imageUrl,
    required this.profileImage,
    required this.username,
    required this.caption,
    required this.musicName,
    this.audioUrl,
    this.product,
    required this.referralCode,
    required this.referralLink,
    this.localAssetName,
  });

  PostModel copyWith({
    String? id,
    String? imageUrl,
    String? profileImage,
    String? username,
    String? caption,
    String? musicName,
    String? audioUrl,
    ProductModel? product,
    String? referralCode,
    String? referralLink,
    String? localAssetName,
  }) {
    return PostModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      caption: caption ?? this.caption,
      musicName: musicName ?? this.musicName,
      audioUrl: audioUrl ?? this.audioUrl,
      product: product ?? this.product,
      referralCode: referralCode ?? this.referralCode,
      referralLink: referralLink ?? this.referralLink,
      localAssetName: localAssetName ?? this.localAssetName,
    );
  }
}
