import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: Text('edit'),
              ),
              PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/grocerydetails.png',
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Grocery Shopping App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                'This application is designed for super shops. '
                'By using this app, users can manage products, view offers, and more.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              // Container(
              //   width: 340,
              //   padding: const EdgeInsets.all(8.0),
              //   decoration: BoxDecoration(
              //     color: Color(0xF0EFE6FF),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "End Date",
              //                 style: TextStyle(
              //                   fontSize: 12,
              //                   color: Colors.grey[700],
              //                 ),
              //               ),
              //               SizedBox(height: 4),
              //               Text(
              //                 "30 June, 2022",
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Icon(Icons.calendar_month, color: Colors.deepPurple),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              TextFormField(

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEFE6FF),
                  hintText: "End Date",
                  suffixIcon: Icon(Icons.calendar_month, color: Colors.purple),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                readOnly: true,

                onTap: () {


                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEFE6FF),
                  hintText: "inprogress",
                  suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.purple),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                readOnly: true,

                onTap: () {


                },
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                width: 340,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xF0EFE6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.flag_outlined,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "medium",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                  ],
                ),
              ),
              Image.asset('assets/images/barcode_image.png')
            ],
          ),
        ),
      ),
    );
  }
}

