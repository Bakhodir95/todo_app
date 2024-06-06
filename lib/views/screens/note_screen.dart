import 'package:flutter/material.dart';
import 'package:todo_app/controllers/note_controller.dart';
import 'package:todo_app/models/note_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final NoteController noteController = NoteController();
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'bsnW2LfxEsM',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: noteController.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("There are no notes. Please add some notes first!"),
            );
          }

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Notes",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final note = snapshot.data![index];
                    return NoteCard(
                      note: note,
                      controller: _controller,
                      onDelete: () {
                        setState(() {
                          // Handle delete action
                          // noteController.(note.id);
                        });
                      },
                      onEdit: () {
                        // Handle edit action
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;
  final YoutubePlayerController controller;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const NoteCard({
    required this.note,
    required this.controller,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.blue,
          child: ListTile(
            title: Text(note.title),
            subtitle: Column(
              children: [
                Text(note.content),
                Text("${note.createdDate}"),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
        YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
      ],
    );
  }
}
