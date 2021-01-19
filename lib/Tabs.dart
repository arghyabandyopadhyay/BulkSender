import 'package:flutter/material.dart';
import 'package:BulkSender/Models/TabDataModel.dart';

class Tabs extends StatelessWidget{
  final List<TabDataModel> tabs;
  final bool isLoading;
  Tabs({ Key key,this.tabs,this.isLoading}) : super(key: key);

  Widget _buildTabBar() {
    return TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 1,
      indicatorColor: Colors.white,
      tabs: tabs.map((tab) => Text(tab.label,textScaleFactor: 1,)).toList(),
    );
  }
  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(
        children: tabs.map((tab) => tab.child).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Container(
        width: screenWidth,
        height:MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(child: _buildTabBar(),color: Colors.blue,padding: EdgeInsets.symmetric(vertical: 10),),
            _buildTabContent(),
            if(isLoading)Container(color:Colors.black87,child: Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[Container(height:40,width:40,padding:EdgeInsets.all(10),child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.blue,),),Text("Loading...",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)]),)
          ],
        ),
      ),
    );
  }
}
