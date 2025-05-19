import 'package:flutter/material.dart';
import '../../model/application.dart';
import '../../service/firestore_service.dart';
import '../../viewmodel/application_tracking_viewmodel.dart';
import 'package:intl/intl.dart';


class ApplicationListTile extends StatefulWidget {
  final ApplicationTrackingViewModel viewModel;
  final Application app;

  ApplicationListTile({Key? key, required this.viewModel, required this.app}) : super(key: key);

  @override
  _ApplicationListTileState createState() => _ApplicationListTileState();
}

class _ApplicationListTileState extends State<ApplicationListTile> {
  FirestoreService firestoreService = FirestoreService();
  String? applicationStage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryContainer
          ),
          child: ListTile(
            trailing: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: const Text('Edit Application'),
                          content: SizedBox(
                            height: 230,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  RadioListTile<String>(
                                    title: const Text('Ready to Apply'),
                                    value: 'Ready to Apply',
                                    groupValue: applicationStage,
                                    onChanged: (value) {
                                      setState(() {
                                        applicationStage = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Applied'),
                                    value: 'Applied',
                                    groupValue: applicationStage,
                                    onChanged: (value) {
                                      setState(() {
                                        applicationStage = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Interviewing'),
                                    value: 'Interviewing',
                                    groupValue: applicationStage,
                                    onChanged: (value) {
                                      setState(() {
                                        applicationStage = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Received Offer'),
                                    value: 'Received Offer',
                                    groupValue: applicationStage,
                                    onChanged: (value) {
                                      setState(() {
                                        applicationStage = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Update'),
                              onPressed: () {
                                if (applicationStage == null) {
                                  return;
                                }
                                widget.viewModel.updateApplicationStatus(widget.app.id, applicationStage!);
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Delete this Application'),
                              onPressed: () {
                                widget.viewModel.deleteApplication(widget.app.id);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.edit, size: 25),
            ),
            title: Text(
              '${widget.app.jobTitle} \n@ ${widget.app.companyName}',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '${widget.app.location}\n\$${NumberFormat("#,##0").format(widget.app.payRate)}',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
      ),
    );
  }
}