// import 'dart:js';

import 'package:covid_case_tracker/responses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
String url="https://covid-19.dataflowkit.com/v1";
void main(){

  runApp(MaterialApp(
    home: Page1(),
    debugShowCheckedModeBanner: false,
     ));
}
class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
   Future<Responses>? responses;
   TextEditingController searchController=TextEditingController();
   String? searchedvalue;
   Future? callOnce;


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callOnce=Repository.getIt();

  }

  @override
  Widget build(BuildContext context) {
     var style=GoogleFonts.varelaRound(
       fontSize: 17,
       fontWeight: FontWeight.bold,
       color: Color(0xff0395dd)

     );
     var numbers=GoogleFonts.aBeeZee(
       fontSize: 14,
       fontWeight: FontWeight.bold,
       color: Color(0xffe3e3a0)
     );
    return SafeArea(
      child: Scaffold(
       backgroundColor: Color(0xfff2f2f2),
        appBar: AppBar(
          backgroundColor:Color(0xff07112e),
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.9,

                  child: TextFormField(
                    controller: searchController,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Color(0xff0395dd),
                    onChanged: (value)async{
                      print(value);
                      setState(() {
                        searchedvalue=value;
                      });
                    },


                  //  autofocus: false,
                    style: TextStyle(
                      color: Color(0xff0395dd),

                    ),
                    decoration: InputDecoration(
                      fillColor: Color(0xff0395dd),
                        hintText: "Search",
                        hintStyle: TextStyle(color: Color(0xff0395dd),fontSize: 12),
                        suffixIcon:Icon(Icons.search_outlined,
                          color: Color(0xff0395dd),size: 30,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color(0xff0395dd)
                            )
                        ),
                  ),
                  ))
              ]
            ),
          ),
        ),
        body:FutureBuilder(
          future: callOnce,
          builder: (context,AsyncSnapshot<dynamic> snapshot){
            dynamic listcount=0;
            if(snapshot.data==null)
              return Center(child: CircularProgressIndicator());
             listcount=snapshot.data!.length;

            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                ),
              );
            }else{
              if(snapshot.hasError){
                return Center(
                  child: Text("Error Occured"),
                );
              }else{
                // var data=snapshot.data;
               // print(data);
                return (searchedvalue=="" || searchedvalue==null)?ListView.builder(
                  itemCount: listcount,
                  itemBuilder: (context, index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Card(
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        color: Color(0xff07112e),
                        child: IntrinsicHeight(
                          child: Row(
                           // mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                child: (snapshot.data[index].countryText!=null)?Center(
                                  child: Text(snapshot.data[index].countryText,
                                  textAlign: TextAlign.center,
                                  style: style
                                  ),
                                ):Container(),
                              ),
                              VerticalDivider(
                                thickness: 1,
                                width: 20,
                                indent: 40,
                                endIndent: 40,
                                color: Colors.grey.shade300,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Confirmed Cases",style: style),
                                    (snapshot.data[index].totalCasesText!=null)?Text(snapshot.data[index].totalCasesText,
                                    style: numbers,
                                    ):Container(),


                                    Text("Active Cases",style: style),
                                    (snapshot.data[index].activeCasesText!=null)?Text(snapshot.data[index].activeCasesText,
                                      style: numbers,
                                    ):Container(),


                                    Text("Total Recovered",style:style),
                                    (snapshot.data[index].totalRecoveredText!=null)?Text(snapshot.data[index].totalRecoveredText,
                                      style:numbers,
                                    ):Container(),


                                    Text("Total Deaths",style: style),
                                    (snapshot.data[index].totalDeathsText!=null)?Text(snapshot.data[index].totalDeathsText,
                                      style:numbers,
                                    ):Container(),


                                    Text("New Cases",style: style),
                                    (snapshot.data[index].newCasesText!=null)?Text(snapshot.data[index].newCasesText,
                                      style: numbers,
                                    ):Container(),


                                    Text("New Deaths",style: style),
                                    (snapshot.data[index].newDeathsText!=null)?Text(snapshot.data[index].newDeathsText,
                                      style:numbers,
                                    ):Container(),


                                    // Text("Last Update",style:style),
                                    // (snapshot.data[index].lastUpdate!=null)?Text(snapshot.data[index].lastUpdate,
                                    //   style: numbers,
                                    // ):Container(child: Text(""),),



                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
                :ListView.builder(itemBuilder: (context,index){

                  dynamic s1=snapshot.data[index].countryText.toString().toLowerCase();
                  dynamic s2=searchedvalue.toString().toLowerCase();
                  return (s1.contains(s2))?Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Card(
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      color: Color(0xff07112e),
                      child: IntrinsicHeight(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: (snapshot.data[index].countryText!=null)?Center(
                                child: Text(snapshot.data[index].countryText,
                                    textAlign: TextAlign.center,
                                    style: style
                                ),
                              ):Container(),
                            ),
                            VerticalDivider(
                              thickness: 1,
                              width: 20,
                              indent: 40,
                              endIndent: 40,
                              color: Colors.grey.shade300,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Confirmed Cases",style: style),
                                  (snapshot.data[index].totalCasesText!=null)?Text(snapshot.data[index].totalCasesText,
                                    style: numbers,
                                  ):Container(),


                                  Text("Active Cases",style: style),
                                  (snapshot.data[index].activeCasesText!=null)?Text(snapshot.data[index].activeCasesText,
                                    style: numbers,
                                  ):Container(),


                                  Text("Total Recovered",style:style),
                                  (snapshot.data[index].totalRecoveredText!=null)?Text(snapshot.data[index].totalRecoveredText,
                                    style:numbers,
                                  ):Container(),


                                  Text("Total Deaths",style: style),
                                  (snapshot.data[index].totalDeathsText!=null)?Text(snapshot.data[index].totalDeathsText,
                                    style:numbers,
                                  ):Container(),


                                  Text("New Cases",style: style),
                                  (snapshot.data[index].newCasesText!=null)?Text(snapshot.data[index].newCasesText,
                                    style: numbers,
                                  ):Container(),


                                  Text("New Deaths",style: style),
                                  (snapshot.data[index].newDeathsText!=null)?Text(snapshot.data[index].newDeathsText,
                                    style:numbers,
                                  ):Container(),


                                  // Text("Last Update",style:style),
                                  // (snapshot.data[index].lastUpdate!=null)?Text(snapshot.data[index].lastUpdate,
                                  //   style: numbers,
                                  // ):Container(child: Text(""),),



                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ):Container();
                 // return Container();
                },
                itemCount: listcount,
                )
                ;

              }
            }
          },
        )


        //     :FutureBuilder(
        //   future: Repository.getIt(),
        //   builder: (context,AsyncSnapshot<dynamic> snapshot){
        //     var listcount=snapshot.data.length;
        //     // print(data);
        //     if(snapshot.connectionState==ConnectionState.waiting){
        //       return Center(
        //         child: CircularProgressIndicator(
        //         ),
        //       );
        //     }else{
        //       if(snapshot.hasError){
        //         return Center(
        //           child: Text("hi }"),
        //         );
        //       }else{
        //         // var data=snapshot.data;
        //         // print(data);
        //         return ListView.builder(
        //           itemCount: listcount,
        //           itemBuilder: (context, index){
        //             String string1=snapshot.data[index].countryText;
        //             String string2=searchedvalue!;
        //             return (string1.contains(string2))?
        //                 Text(snapshot.data[index].countryText)
        //                 : Text("no");
        //           }
        //         );
        //
        //       }
        //     }
        //   },
        // )
      ),
    );
  }

  
}
