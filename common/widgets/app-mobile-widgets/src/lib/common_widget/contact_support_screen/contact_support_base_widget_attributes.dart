class ContactSupportBaseWidgetAttributes {
  String? title;
  String? followUsDesc;
  List<ContactInfoItem>? items;

  ContactSupportBaseWidgetAttributes({
    this.title,
    this.followUsDesc,
    this.items,
  });

  ContactSupportBaseWidgetAttributes copyWith({
    String? title,
    String? followUsDesc,
    List<ContactInfoItem>? items,
  }) =>
      ContactSupportBaseWidgetAttributes(
        title: title ?? this.title,
        followUsDesc: followUsDesc ?? this.followUsDesc,
        items: items ?? this.items,
      );
}

class ContactInfoItem {
  final String title;
  final Function()? action;

  ContactInfoItem({required this.title, this.action});
}
