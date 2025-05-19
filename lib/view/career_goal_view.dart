import 'package:flutter/material.dart';
import 'package:job_market_app/service/firestore_service.dart';
import 'package:job_market_app/viewmodel/career_goal_viewmodel.dart';
import '../model/career_goal.dart';
import 'component/drawer.dart';

class CareerGoalPage extends StatefulWidget {
  final TextEditingController goalController = TextEditingController();
  final CareerGoalViewModel viewModel;

  var username;

  CareerGoalPage(
      {super.key,
        required this.viewModel,
      required this.username});


  @override
  _careerGoalPage createState() => _careerGoalPage();
}

class _careerGoalPage extends State<CareerGoalPage> {
  var firestore = FirestoreService();

  void refresh() {
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Goals'),
        automaticallyImplyLeading: true,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primaryContainer,
      ),
      drawer: AppDrawer(
          key: const Key('AppDrawer'), currentPage: 'CareerGoalPage', user: widget.username),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: widget.viewModel.goals.length,
                  itemBuilder: (context, index) {

                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          widget.viewModel.removeGoal(widget.viewModel.goals[index]);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: CheckboxListTile(
                          title: Text(widget.viewModel.goals[index].goalTextString),
                          subtitle: Text(widget.viewModel.goals[index].isLongTerm ? 'Long Term' : 'Short Term'),
                          value: widget.viewModel.goals[index].isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              widget.viewModel.goals[index].isChecked = !widget.viewModel.goals[index].isChecked;
                              widget.viewModel.updateGoal(widget.viewModel.goals[index]);
                            });
                          },
                        ),
                      )
                    );
                  },
                )
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.goalController,
                decoration: const InputDecoration(
                  hintText: 'Enter your goal',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      String goalText = widget.goalController.text.trim();
                      if (goalText.isNotEmpty) {
                        Goal newGoal = Goal(
                          goalTextString: goalText,
                          isLongTerm: false,
                          isChecked: false,
                        );
                        widget.viewModel.addGoals(newGoal);
                        widget.goalController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a goal before adding.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Add Short Term Goal'),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        String goalText = widget.goalController.text.trim();
                        if (goalText.isNotEmpty) {
                          Goal newGoal = Goal(
                            goalTextString: goalText,
                            isLongTerm: false,
                            isChecked: false,
                          );
                          widget.viewModel.addGoals(newGoal);
                          widget.goalController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a goal before adding.'),
                            ),
                          );
                        }
                      },
                      child: const Text('Add Long Term Goal'),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
