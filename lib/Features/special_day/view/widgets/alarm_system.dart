import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _isAlarmOn = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
              backgroundColor: Colors.yellow,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Remainder'),
              actions: [
                const Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    height: size.height * .3,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage("images/clock.png"),
                          fit: BoxFit.cover,
                        )),
                    // color: Colors.amber,
                  ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: size.height * .09,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isAlarmOn ? Colors.grey[200] : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("6:00",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    Text("am",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Friday, August 20",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            Text("Your wife's Birthday",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlarmOn = !_isAlarmOn;
                                  });
                                },
                                icon: _isAlarmOn
                                    ? Icon(
                                        Icons.toggle_on_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.toggle_off_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: size.height * .09,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isAlarmOn ? Colors.grey[200] : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("6:00",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    Text("am",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Friday, August 20",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            Text("Your wife's Birthday",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlarmOn = !_isAlarmOn;
                                  });
                                },
                                icon: _isAlarmOn
                                    ? Icon(
                                        Icons.toggle_on_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.toggle_off_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: size.height * .09,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isAlarmOn ? Colors.grey[200] : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("6:00",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    Text("am",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Friday, August 20",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            Text("Your wife's Birthday",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlarmOn = !_isAlarmOn;
                                  });
                                },
                                icon: _isAlarmOn
                                    ? Icon(
                                        Icons.toggle_on_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.toggle_off_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: size.height * .09,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isAlarmOn ? Colors.grey[200] : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("6:00",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    Text("am",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Friday, August 20",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            Text("Your wife's Birthday",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlarmOn = !_isAlarmOn;
                                  });
                                },
                                icon: _isAlarmOn
                                    ? Icon(
                                        Icons.toggle_on_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.toggle_off_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: size.height * .09,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isAlarmOn ? Colors.grey[200] : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("6:00",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    Text("am",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Friday, August 20",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            Text("Your wife's Birthday",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlarmOn = !_isAlarmOn;
                                  });
                                },
                                icon: _isAlarmOn
                                    ? Icon(
                                        Icons.toggle_on_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.toggle_off_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: size.height * .09,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isAlarmOn ? Colors.grey[200] : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("6:00",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    Text("am",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Friday, August 20",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            Text("Your wife's Birthday",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlarmOn = !_isAlarmOn;
                                  });
                                },
                                icon: _isAlarmOn
                                    ? Icon(
                                        Icons.toggle_on_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.toggle_off_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: size.height * .09,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isAlarmOn ? Colors.grey[200] : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("6:00",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    Text("am",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Friday, August 20",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            Text("Your wife's Birthday",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlarmOn = !_isAlarmOn;
                                  });
                                },
                                icon: _isAlarmOn
                                    ? Icon(
                                        Icons.toggle_on_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.toggle_off_outlined,
                                        color: Colors.blue,
                                        size: 40,
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
