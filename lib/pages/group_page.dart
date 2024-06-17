import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/bloc/groups/group_bloc.dart';
import 'package:sports_app/components/snackbar.dart';
import 'package:sports_app/models/group.dart';
import '../components/custom_app_bar.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final GroupBloc _groupBloc = GroupBloc();
  bool _isModalOpen = false;
  final TextEditingController _groupNameController = TextEditingController();

  @override
  void initState() {
    _groupBloc.add(const GetGroupList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: const CustomAppBar(title: 'Groups'),
        body: Container(
          color: const Color.fromARGB(255, 163, 182, 192),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              _breadcrumbs(),
              const SizedBox(height: 15.0),
              Expanded(
                child: _groups(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            _isModalOpen = true;
          }),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _breadcrumbs() {
    return const Row(
      children: [
        Text(
          '› Groups',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _groups() {
    return BlocProvider(
        create: (_) => _groupBloc,
        child: BlocListener<GroupBloc, GroupState>(
          listener: (context, state) {
            if (state is GroupError) {
              showSnackbar(context, state.message!);
            }
          },
          child: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupInitial || state is GroupLoading) {
                return _buildLoading();
              } else if (state is GroupLoaded) {
                return _buildGroupTable(context, state.groupModel);
              } else if (state is GroupError) {
                return const Center(child: Text('Error loading groups'));
              } else {
                return Container();
              }
            },
          ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildGroupTable(BuildContext context, GroupModel model) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 40.0,
        columns: const [
          DataColumn(
            label: Center(
              child: Text(
                'Name',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          DataColumn(
            label: Center(
              child: Text(
                'Action',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
        rows: model.data!.map((group) {
          return DataRow(cells: [
            DataCell(
              Text(group.name ?? 'Unknown Group'),
            ),
            DataCell(
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to group details
                  },
                  child: const Text(
                    'View',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  // void _handleAddGroup() {
  //   if (_groupNameController.text.isNotEmpty) {
  //     _groupBloc.add(AddGroup(_groupNameController.text));
  //     _groupNameController.clear();
  //     setState(() {
  //       _isModalOpen = false;
  //     });
  //   }
  // }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }
}

class AddGroupModal extends StatelessWidget {
  final TextEditingController groupNameController;
  final VoidCallback onSubmit;
  final VoidCallback onClose;

  const AddGroupModal({
    super.key,
    required this.groupNameController,
    required this.onSubmit,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Group'),
      content: TextField(
        controller: groupNameController,
        decoration: const InputDecoration(labelText: 'Group Name'),
      ),
      actions: [
        TextButton(
          onPressed: onClose,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSubmit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
