//FutureBuilder<List<User>>(
//future: userDatabase.getAllUsers(),
//builder: (BuildContext context,
//    AsyncSnapshot<List<User>> snapshot) {
//if (snapshot.hasData) {
//return Center(
//child: SizedBox(
//height: 450,
//width: 300,
//child: ClipRRect(
//borderRadius: BorderRadius.circular(60),
//// Image border
//child: SizedBox.fromSize(
//size: Size.fromRadius(50), // Image radius
//child: pList.isNotEmpty
//? Image.memory(const Base64Decoder()
//    .convert(pList[1].imageUrl!))
//    : Image.asset('assets/cover.jpg',
//fit: BoxFit.cover)),
//),
//),
//);
//} else {
//return Center(
//child: SizedBox(
//height: 450,
//width: 300,
//child: ClipRRect(
//borderRadius: BorderRadius.circular(60),
//// Image border
//child: SizedBox.fromSize(
//size: Size.fromRadius(50), // Image radius
//child: Image.asset('assets/cover.jpg',
//fit: BoxFit.cover)),
//),
//),
//);
//}
//})