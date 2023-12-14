import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatBotScreen(),
    );
  }
}

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _chatMessages = [];
  bool _isChatting = false;
  String? currentQuestion;
  String? _userName;
  String? _personType;
  String? _selectedOption;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showChatBotPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              children: [
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 500,
                        width: 420,
                        color: Color.fromRGBO(209, 209, 209, 1),
                        child: Column(
                          children: [
                            _buildChatHeader(),
                            _isChatting
                                ? _buildChatInput(setState)
                                : _buildIntroPage(setState),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Function to build the chat header
  Widget _buildChatHeader() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('Alice.png'),
            radius: 20,
          ),
          Text(
            'Alice',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the introduction page
  Widget _buildIntroPage(Function setState) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Image.asset(
              'Alice.png',
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Hi, I\'m Alice!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "I can help you get the social care support that is right for you. I'm a robot, not a human, but will help you as best I can.",
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isChatting = true;
                });

                _simulateAliceMessages();
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to simulate Alice sending messages
  void _simulateAliceMessages() {
    _addMessage(
      "Hi, need some help?\nI'm Alice, the friendly robot.\nI can direct you to the right information and support about social care.",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "I may be able to help you find the right information about the law in England, such as letter templates or another person to help.",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "You can [click here to watch a video](https://www.youtube.com/watch?v=endjMt-VsNo) to learn more about how to use the chatbot.",
      'Alice',
      isAlice: true,
      isYouTubeLink: true,
    );

    _addMessage(
      "2) Please be aware that we cannot answer questions about children under 18.",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "We do have a factsheet for SC42 (social care assessments and duties): [SC42 Factsheet](https://static1.squarespace.com/static/5f2160ae3e84ef21653b8190/t/5fd7b1eca97d540296c9265e/1607971308978/SC42+Social+care+assessments+and+duties+-+children+and+young+people+under+18.pdf) and SC76 (transition assessments): [SC76 Factsheet](https://static1.squarespace.com/static/5f2160ae3e84ef21653b8190/t/633183518a436c63811cd269/1664189265918/SC76+Transition+assessments+2022+updated.pdf)",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "Click here for an [NHS external link](https://www.nhs.uk/conditions/social-care-and-support-guide/caring-for-children-and-young-people/children-and-young-peoples-services/) with more help with children’s social care.",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "Young people aged between 14 and 17 years old also have a right by law to an assessment if they are likely to need social care when they are an adult. This is called a 'transition assessment’.",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "Click here for a step-by-step [transition assessment](https://www.proceduresonline.com/resources/careact/p_carrying_trans_assess.html).",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "[Click here to find out how we store your data](https://www.accesscharity.org.uk/chatbot-information)",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "The chatbot is provided by Access Social Care. It will ask for your email address so that we can contact you in the future if needed.",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "We will be able to look at the information you enter here. However, please do not enter personal data that could identify anyone else.",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "This includes names, contact details. ASC does not consent to store these details of that person, and they do not need their information for the chatbot to work.",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "If you do enter personal information on the chatbot, it will be stored on the Rasa platform for up to 14 days. ASC will not share this information outside of ASC and their technical partners unless they have to by law. They will delete it after 14 days.",
      'Alice',
      isAlice: true,
    );

    _addMessage("What is your name?", "Alice", isAlice: true);
    setState(() {
      currentQuestion = "name";
    });
  }

  void _askPerson() {
    _addMessage(
      "Thanks, $_userName. Are you the person who needs social care or someone else?",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "1. I am the person who needs support",
      'Alice',
      isAlice: true,
    );
    _addMessage(
      "2. I am a family member or friend",
      'Alice',
      isAlice: true,
    );
    _addMessage(
      "3. I am a care professional",
      'Alice',
      isAlice: true,
    );
    _addMessage(
      "4. I am a student, advisor, advocate, or social prescriber",
      'Alice',
      isAlice: true,
    );
  }

  void _askOptions() {
    _addMessage(
      "Do you need help with a situation or general information?",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "1. I want guidance about an individual",
      'Alice',
      isAlice: true,
    );
    _addMessage(
      "2. Legal information",
      'Alice',
      isAlice: true,
    );
    _addMessage(
      "3. Template letters",
      'Alice',
      isAlice: true,
    );
    _addMessage(
      "4. Factsheets",
      'Alice',
      isAlice: true,
    );

    _addMessage(
      "5. FAQs",
      'Alice',
      isAlice: true,
    );
  }

  // Function to build the chat input
  Widget _buildChatInput(Function setState) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_chatMessages[index]);
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (message) {
                      _addMessage(message, 'You');
                      if (currentQuestion != null) {
                        switch (currentQuestion) {
                          case "name":
                            setState(() {
                              _userName = message;
                              currentQuestion = "person";
                            });

                            _askPerson();
                            break;

                          case "person":
                            List<String> options = ['1', '2', '3', '4'];
                            if (!options.contains(message)) {
                              _addMessage(
                                  "Please select a valid option", "Alice",
                                  isAlice: true);

                              _askPerson();
                              break;
                            }

                            setState(() {
                              _personType = message;
                              currentQuestion = "list-options";
                            });

                            _askOptions();
                            break;

                          case "list-options":
                            List<String> options = ['1', '2', '3', '4', '5'];
                            if (!options.contains(message)) {
                              _addMessage(
                                  "Please select a valid option", "Alice",
                                  isAlice: true);

                              _askOptions();
                              break;
                            }
                            setState(() {
                              _selectedOption = message;
                              currentQuestion = "next";
                            });
                            break;
                        }
                      }
                      _messageController.clear();
                      setState(() {});
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  String message = _messageController.text;
                  if (message.isNotEmpty) {
                    _addMessage(message, 'You');
                    _messageController.clear();
                    setState(() {});
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to build a message bubble
  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isAlice ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        constraints: BoxConstraints(
          maxWidth: 280,
          minWidth: 100,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.isAlice)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('Alice.png'),
                    radius: 10,
                  ),
                ),
              Expanded(
                child: parseLinks(message.text),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Function to manually parse and display links
  Widget parseLinks(String text) {
    final RegExp linkRegExp = RegExp(r'\[([^\]]+)\]\(([^)]+)\)');
    final List<InlineSpan> children = [];

    int previousEnd = 0;
    linkRegExp.allMatches(text).forEach((match) {
      final preMatch = text.substring(previousEnd, match.start);
      final linkText = match.group(1);
      final linkUrl = match.group(2)!;

      if (preMatch.isNotEmpty) {
        children.add(TextSpan(text: preMatch));
      }

      children.add(
        TextSpan(
          text: linkText,
          style: TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunch(linkUrl)) {
                await launch(linkUrl);
              }
            },
        ),
      );

      previousEnd = match.end;
    });

    if (previousEnd < text.length) {
      children.add(TextSpan(text: text.substring(previousEnd)));
    }

    return RichText(text: TextSpan(children: children));
  }

  // Function to add a message to the chat
  void _addMessage(String text, String sender,
      {bool isAlice = false, bool isYouTubeLink = false}) {
    _chatMessages.add(ChatMessage(text, sender,
        isAlice: isAlice, isYouTubeLink: isYouTubeLink));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alice Chat Bot'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Your main app content goes here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showChatBotPopup,
        tooltip: 'Open Chatbot',
        child: const Icon(Icons.chat),
      ),
    );
  }
}

// Model class for chat messages
class ChatMessage {
  final String text;
  final String sender;
  final bool isAlice;
  final bool isYouTubeLink;

  ChatMessage(
    this.text,
    this.sender, {
    this.isAlice = false,
    this.isYouTubeLink = false,
  });
}

String? _extractVideoId(String url) {
  RegExp regExp = RegExp(
    r'http(?:s?):\/\/(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([\w\-\_]*)(&(amp;)?[\w\?=]*)?',
  );
  RegExpMatch? match = regExp.firstMatch(url);
  return match?.group(1);
}

class EmbeddedYouTubeVideo extends StatelessWidget {
  final String videoUrl;

  EmbeddedYouTubeVideo(this.videoUrl);

  @override
  Widget build(BuildContext context) {
    String? videoId = _extractVideoId(videoUrl);

    if (videoId != null && videoId.isNotEmpty) {
      return GestureDetector(
        onTap: () async {
          String youtubeUrl = 'https://www.youtube.com/watch?v=$videoId';
          if (await canLaunch(youtubeUrl)) {
            await launch(youtubeUrl);
          }
        },
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    } else {
      return const Text('Invalid YouTube link'); // or provide a default image
    }
  }
}
