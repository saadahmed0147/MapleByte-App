import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/curved_appbar.dart';
import 'package:maple_byte/Component/round_textfield.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class UsersScreen extends StatefulWidget {
  final String currentUserId;

  const UsersScreen({required this.currentUserId, super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String userName = 'User';
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  List<MapEntry> allUsers = [];
  List<MapEntry> filteredUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserName();
    fetchAllUsers();
  }

  Future<void> fetchUserName() async {
    try {
      final userRef = FirebaseDatabase.instance.ref(
        'users/${widget.currentUserId}',
      );
      final snapshot = await userRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          userName = data['name'] ?? 'User';
        });
      }
    } catch (e) {
      print('Error fetching username: $e');
    }
  }

  Future<void> fetchAllUsers() async {
    try {
      final usersRef = FirebaseDatabase.instance.ref('users');
      final snapshot = await usersRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final entries = data.entries
            .where((e) => e.key != widget.currentUserId)
            .toList();

        setState(() {
          allUsers = entries;
          filteredUsers = entries;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading users: $e");
      setState(() => isLoading = false);
    }
  }

  void filterUserList(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = query.isEmpty
          ? allUsers
          : allUsers.where((entry) {
              final user = Map<String, dynamic>.from(entry.value);
              final name = user['name']?.toLowerCase() ?? '';
              return name.contains(query.toLowerCase());
            }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CurvedAppBar(),
        body: Column(
          children: [
            const Text(
              "Messages",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: RoundTextField(
                label: 'Search',
                hint: 'Search',
                borderRadius: 30,
                bgColor: const Color(0xffEDF0FF),
                enabledBorderColor: const Color(0xffF8F9FE),
                focusedBorderColor: AppColors.greyColor,
                inputType: TextInputType.text,
                prefixIcon: Icons.search,
                textEditingController: searchController,
                onChange: filterUserList,
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredUsers.isEmpty
                  ? const Center(
                      child: Text(
                        "No users found.",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.darkBlueColor,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: filteredUsers.length,
                      separatorBuilder: (_, __) => const Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 1,
                        color: AppColors.blackColor,
                      ),
                      itemBuilder: (context, index) {
                        final entry = filteredUsers[index];
                        final user = Map<String, dynamic>.from(entry.value);

                        final ids = [widget.currentUserId, user['uid']]..sort();
                        final chatId = ids.join('_');

                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                            user['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                            ),
                          ),
                          subtitle: StreamBuilder<DatabaseEvent>(
                            stream: FirebaseDatabase.instance
                                .ref('chats/$chatId/messages')
                                .orderByChild('timestamp')
                                .limitToLast(1)
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.snapshot.value != null) {
                                final data = Map<String, dynamic>.from(
                                  snapshot.data!.snapshot.value as Map,
                                );
                                final lastMessage = data.values.first as Map;
                                return Text(lastMessage['text'] ?? '');
                              } else {
                                return const Text('No messages yet');
                              }
                            },
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteNames.chatScreen,
                            arguments: {
                              'currentUserId': widget.currentUserId,
                              'otherUserId': user['uid'],
                              'otherUserName': user['name'],
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
