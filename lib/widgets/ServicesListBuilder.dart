import 'package:finalloyal/models/services_model.dart';
import 'package:flutter/material.dart';

class ServicesListBuilder extends StatefulWidget {
  List<Services> servicesList;
  List<String> subCategories;
  String category;

  ServicesListBuilder(
      List<Services> servicesList, List<String> subCategories, category) {
    this.servicesList = servicesList;
    this.subCategories = subCategories;
    this.category = category;
  }

  @override
  _ServicesListBuilderState createState() => _ServicesListBuilderState();
}

class _ServicesListBuilderState extends State<ServicesListBuilder> {
  String foodSubcategoryFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        dropdownBuilder(widget.category),
        for (int index = 0; index < widget.servicesList.length; index++)
          if (widget.servicesList[index].selectedServiceCatagory
                      .toLowerCase() ==
                  widget.category.toLowerCase() &&
              foodSubcategoryFilter.toLowerCase() != 'all' &&
              widget.servicesList[index].selectedServiceSubCatagory
                      .toLowerCase() ==
                  foodSubcategoryFilter.toLowerCase())
            serviceCardBuilder(index)
          else if (widget.servicesList[index].selectedServiceCatagory
                      .toLowerCase() ==
                  widget.category.toLowerCase() &&
              foodSubcategoryFilter.toLowerCase() == 'all')
            serviceCardBuilder(index)
      ],
    );
  }

  Card serviceCardBuilder(int index) {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/image1.jpg'),
        ),
        title: Column(
          children: [
            Text(
              widget.servicesList[index].serviceName,
              style: TextStyle(fontSize: 22.0),
            ),
            Text(
              widget.servicesList[index].selectedServiceSubCatagory,
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 2.0,
              color: Colors.black12,
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.servicesList[index].serviceDescription,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.servicesList[index].servicePrice.toString()),
            SizedBox(
              height: 5.0,
            ),
            Text('ETB'),
          ],
        ),
      ),
    );
  }

  List<String> getSubCategories(String category) {
    widget.subCategories = new List<String>();
    List<String> tempList = new List<String>();
    tempList.add('All');

    for (int i = 0; i < widget.servicesList.length; i++) {
      if (category.toLowerCase() ==
          widget.servicesList[i].selectedServiceCatagory.toLowerCase())
        tempList.add(
            widget.servicesList[i].selectedServiceSubCatagory.toLowerCase());
    }
    widget.subCategories = tempList.toSet().toList();
    return widget.subCategories;
  }

  dropdownBuilder(String category) {
    return DropdownButton(
        hint: Text('filter'),
        items: getSubCategories(category).map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: (Text(
              item,
              style: TextStyle(
                fontSize: 18.0,
              ),
            )),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            foodSubcategoryFilter = value.toLowerCase();
          });
        },
        value: foodSubcategoryFilter);
  }
}
