import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireproject/src/pages/announcement/AnnouncementPage.dart';
import 'package:fireproject/board/boardList.dart';
import 'package:fireproject/chatting/chatuser/user_list.dart';
import 'package:fireproject/src/pages/announcement/home.dart';
import 'package:fireproject/src/size.dart';
import 'package:fireproject/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class bottomNavigationbar extends StatefulWidget {
  final User? user;
  const bottomNavigationbar({required this.user});

  @override
  _bottomNavigationbarState createState() => _bottomNavigationbarState();
}

class _bottomNavigationbarState extends State<bottomNavigationbar> {
  int _selectedIndex = 0; //선택한 메뉴의 인덱스를 기억
  bool _visibility = true; //floating button의 표시 여부 결정'

  //특정 텍스트 스타일을 상수로 지정
  static const TextStyle optionStyle =
      TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "DoHyeonFont");

  //메뉴별 다른 AppBar의 텍스트 지정을 위해 List<Text> 선언
  static const List<Text> _appBarOptions = <Text>[
    Text('우리의 소식통',
        style: optionStyle),
    Text('학생 상태', style: optionStyle,),
    Text('채팅', style: optionStyle,),
    Text('참여 게시판', style: optionStyle,),
    Text('계정', style: optionStyle,),
  ];

  //메뉴별 다른 body 지정을 위해 List<Widget> 선언
  static const List<Widget> _bodyOptions = <Widget>[
    HomePage(),
    Text(
      '여기에 홈페이지 당겨오면 돼용',
      style: optionStyle,
    ),
    UserList(),
    BoardList(),
    Text(
      'Index 3: Account balance',
      style: optionStyle,
    ),
  ];

  get user => this.user;


  //함수 구현
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if(_selectedIndex == 0 || _selectedIndex == 3) {
      _show();
    } else {
      _hide();
    }
  }

  void _show(){
    setState(() {
      _visibility = true;
    });
  }
  void _hide(){
    setState(() {
      _visibility = false;
    });
  }

  bool _moveWritingPage() {
    bool writingType = true;

    if(_selectedIndex == 0) {
      writingType = true;
    } else if(_selectedIndex == 3) {
      writingType = false;
    }

    return writingType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: getAppBarHeight(context),
        backgroundColor: Colors.white,
        elevation: 0.1,
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(child: _appBarOptions.elementAt(_selectedIndex)),
        ),
      ),
      body: Center(
        child: _bodyOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/newslist.svg"),
            label: '공지사항',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/studentstate.svg"),
            label: '학생상태',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/logo.svg"),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/addlist.svg"),
            label: '참여게시판',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/studentlist.svg"),
            label: '계정',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: Visibility(
        child: IconButton(
          onPressed: () {
            if(_moveWritingPage()){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => WriteAnnouncePage(user: user),
                ),
              );
            }else{
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => StartPage(),
                ),
              );
            }
          },
          tooltip: '글을 작성하세요.',
          icon: SvgPicture.asset("assets/icons/pencil.svg"),
          iconSize: 55.0,
        ),
        visible: _visibility,
      ),
    );
  }
}
