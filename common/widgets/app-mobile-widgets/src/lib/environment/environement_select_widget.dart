import 'package:flutter/material.dart';

class EnvironmentSelectionView extends StatefulWidget {
  final String titleIskan;
  final String titleAppVersion;
  final String appVersion;
  final String ctaTitle;
  final Function(String)? onSelect;

  const EnvironmentSelectionView(
      {super.key,
        required this.titleIskan,
        required this.titleAppVersion,
        required this.appVersion,
        required this.ctaTitle,
        this.onSelect});

  @override
  State<EnvironmentSelectionView> createState() => _EnvironmentSelectionViewState();
}

class _EnvironmentSelectionViewState extends State<EnvironmentSelectionView> {
  String dropdownValue = 'dev';

  Map<String, String> itemList = {
    'dev': 'Dev',
    'preprod': 'Pre Prod',
  };

  @override
  Widget build(BuildContext context) {
    return displayEnvironments(
      widget.titleIskan,
      widget.titleAppVersion,
      widget.appVersion,
      itemList,
      widget.ctaTitle,
      widget.onSelect,
    );
  }

  Widget displayTitleWithDecoratedBox(String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 15,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xFFC7BDBA), //background color of dropdown button
          border: Border.all(color: Colors.black38, width: 3), //border of dropdown button
          borderRadius: BorderRadius.circular(30), //border raiuds of dropdown button
          boxShadow: const <BoxShadow>[
            //apply shadow on Dropdown button
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 5) //blur radius of shadow
          ]),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black, //Font color
              fontSize: 25 //font size on dropdown button
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      height: 20,
      thickness: 5,
      indent: 20,
      endIndent: 0,
      color: Colors.black,
    );
  }

  Widget dropdownList(Map<String, String> item) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.teal,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(50),
            boxShadow: const <BoxShadow>[BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)]),
        child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton(
              value: dropdownValue,
              items: item.entries
                  .map<DropdownMenuItem<String>>((MapEntry<String, String> e) => DropdownMenuItem<String>(
                value: e.key,
                child: Text(e.value),
              ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  displayTeamSpirit();
                });
              },
              icon: const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Icon(Icons.arrow_circle_down_sharp),
              ),
              iconEnabledColor: Colors.white,
              //Icon color
              style: const TextStyle(
                //te
                  color: Colors.white, //Font color
                  fontSize: 25 //font size on dropdown button
              ),
              dropdownColor: Colors.blueGrey,
              underline: Container(),
              isExpanded: true,
              borderRadius: BorderRadius.circular(25), //border raiuds of dropdown button
            )));
  }

  Widget continueCTA(String ctaTitle, Function(String p1)? onSelect) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      onPressed: () {
        onSelect!(dropdownValue);
      },
      child: Text(
        ctaTitle,
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget displayEnvironments(String titleIskan, String titleAppVersion, String appVersion, Map<String, String> itemList,
      String ctaTitle, Function(String p1)? onSelect) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Card(
            elevation: 20,
            shadowColor: Colors.brown,
            color: const Color(0x00B0705C),
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                displayTitleWithDecoratedBox(titleIskan),
                displayTitleWithDecoratedBox(titleAppVersion),
                displayTitleWithDecoratedBox(appVersion),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Available on Environment',
            style: TextStyle(
                color: Colors.black, //Font color
                fontSize: 20 //font size on dropdown button
            ),
          ),
          divider(),
          dropdownList(itemList),
          divider(),
          const SizedBox(
            height: 20,
          ),
          continueCTA(ctaTitle, onSelect),
          displayTeamSpirit()
        ]));
  }

  Widget displayTeamSpirit() {
    var quotes = [
      'Coming together is a beginning. Keeping together is progress. Working together is success.',
      'Alone we can do so little, together we can do so much.',
      'None of us is as smart as all of us.',
      'Talent wins games, but teamwork and intelligence win championships.',
      'Coming together is a beginning. Keeping together is progress. Working together is success.',
      'It is literally true that you can succeed best and quickest by helping others to succeed.',
      'Teamwork makes the dream work.',
      'Together, ordinary people can achieve extraordinary results.',
      'The strength of the team is each individual member. The strength of each member is the team.',
      'Great things in business are never done by one person. They’re done by a team of people.'
    ];
    var spiritMessage = (quotes.toList()..shuffle()).first;
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0, top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '😀 Team Spirit 😀'.toUpperCase(),
            style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(
            thickness: 2,
            color: Colors.blue,
          ),
          Text(
            spiritMessage,
            style: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Color(0xFFB71C1C),
            ),
          ),
        ],
      ),
    );
  }
}
