import 'package:first_app/models/constant.dart';
import 'package:first_app/services/key_moments_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class KeyMomentContainer extends StatefulWidget {
  const KeyMomentContainer({super.key, required this.title});
  final int title;

  @override
  State<KeyMomentContainer> createState() => _KeyMomentContainerState();
}

class _KeyMomentContainerState extends State<KeyMomentContainer> {
  @override
  Widget build(BuildContext context) {
    final keymoments = Provider.of<KeyMomentProvider>(context, listen: false);
    return Container(
        width: double.infinity,
        height: 700,
        child: FutureBuilder(
            future: keymoments.fetchKeymoment(widget.title),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center();
              } else {
                final keymoments = snapshot.data!;
                return ListView.builder(
                    itemCount: keymoments.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(
                            "${keymoments[index].imageDescription}",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 300,
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${key_moment_uri}${keymoments[index].image}"),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "${keymoments[index].imageSubTitle}",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    });
              }
            }));
  }
}
