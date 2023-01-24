import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mtw_project/utill/dimensions.dart';
import 'package:mtw_project/views/screens/data/user_data.dart';
import 'package:mtw_project/views/screens/data/user_datail_page.dart';
import 'package:sizer/sizer.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;

  const SearchWidget({Key? key, required this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField<User?>(
        hideSuggestionsOnKeyboardHide: false,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 9.sp),
          ),
        ),
        suggestionsCallback: UserData.getSuggestion,
        itemBuilder: (context, User? suggetion) {
          final user = suggetion;
          return ListTile(
            leading: Container(
              width: 45.sp,
              height: 40.sp,
              child: Image.network(
                user!.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            title: Text(user.name),
          );
        },
        noItemsFoundBuilder: (ctx) => Container(
          height: 100,
          child: Center(
            child: Text(
              "No User Found.",
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ),
        onSuggestionSelected: (User? suggetion) {
          final user = suggetion!;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => UserDetailPage(user: user),
            ),
          );
          // ScaffoldMessenger.of(context)
          //   ..removeCurrentSnackBar()
          //   ..showSnackBar(
          //     SnackBar(
          //       content: Text('Selected user: ${user!.name}'),
          //     ),
          //   );
        },
      ),
    );
  }
}

// Container(
//                   // height: 7.h,
//                   decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.ac_unit),
//                   ),
//                 ),
