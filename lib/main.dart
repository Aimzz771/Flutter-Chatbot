import 'dart:html';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as webFile;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:flutter/services.dart' show ByteData, rootBundle;

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
    // _addMessage(
    //   "Hi, need some help?\nI'm Alice, the friendly robot.\nI can direct you to the right information and support about social care.",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "I may be able to help you find the right information about the law in England, such as letter templates or another person to help.",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "You can [click here to watch a video](https://www.youtube.com/watch?v=endjMt-VsNo) to learn more about how to use the chatbot.",
    //   'Alice',
    //   isAlice: true,
    //   isYouTubeLink: true,
    // );

    // _addMessage(
    //   "2) Please be aware that we cannot answer questions about children under 18.",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "We do have a factsheet for SC42 (social care assessments and duties): [SC42 Factsheet](https://static1.squarespace.com/static/5f2160ae3e84ef21653b8190/t/5fd7b1eca97d540296c9265e/1607971308978/SC42+Social+care+assessments+and+duties+-+children+and+young+people+under+18.pdf) and SC76 (transition assessments): [SC76 Factsheet](https://static1.squarespace.com/static/5f2160ae3e84ef21653b8190/t/633183518a436c63811cd269/1664189265918/SC76+Transition+assessments+2022+updated.pdf)",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "Click here for an [NHS external link](https://www.nhs.uk/conditions/social-care-and-support-guide/caring-for-children-and-young-people/children-and-young-peoples-services/) with more help with children’s social care.",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "Young people aged between 14 and 17 years old also have a right by law to an assessment if they are likely to need social care when they are an adult. This is called a 'transition assessment’.",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "Click here for a step-by-step [transition assessment](https://www.proceduresonline.com/resources/careact/p_carrying_trans_assess.html).",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "[Click here to find out how we store your data](https://www.accesscharity.org.uk/chatbot-information)",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "The chatbot is provided by Access Social Care. It will ask for your email address so that we can contact you in the future if needed.",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "We will be able to look at the information you enter here. However, please do not enter personal data that could identify anyone else.",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "This includes names, contact details. ASC does not consent to store these details of that person, and they do not need their information for the chatbot to work.",
    //   'Alice',
    //   isAlice: true,
    // );

    // _addMessage(
    //   "If you do enter personal information on the chatbot, it will be stored on the Rasa platform for up to 14 days. ASC will not share this information outside of ASC and their technical partners unless they have to by law. They will delete it after 14 days.",
    //   'Alice',
    //   isAlice: true,
    // );

    _addMessage(
        "Are you the person who needs social care or someone else?", "Alice",
        isAlice: true);

    _addMessage("I am the care person", "Alice",
        value: "care-person", isAlice: true, isButton: true);

    _addMessage("Family or friend", "Alice",
        value: "family-friend", isAlice: true, isButton: true);

    _addMessage("Student/advisor", "Alice",
        value: "student-advisor", isAlice: true, isButton: true);

    _addMessage("Care professional", "Alice",
        value: "care-professional", isAlice: true, isButton: true);

    setState(() {
      currentQuestion = "person";
    });
  }

  Widget _buildChatInput(Function setState) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_chatMessages[index], setState);
              },
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: TextField(
          //           controller: _messageController,
          //           onSubmitted: (message) {
          //             _addMessage(message, 'You');
          //             if (currentQuestion != null) {
          //               switch (currentQuestion) {
          //                 case "name":
          //                   setState(() {
          //                     _userName = message;
          //                     currentQuestion = "person";
          //                   });

          //                   _askPerson();
          //                   break;

          //                 case "person":
          //                   List<String> options = ['1', '2', '3', '4'];
          //                   if (!options.contains(message)) {
          //                     _addMessage(
          //                         "Please select a valid option", "Alice",
          //                         isAlice: true);

          //                     _askPerson();
          //                     break;
          //                   }

          //                   setState(() {
          //                     _personType = message;
          //                     currentQuestion = "list-options";
          //                   });

          //                   _askOptions();
          //                   break;

          //                 case "list-options":
          //                   List<String> options = ['1', '2', '3', '4', '5'];
          //                   if (!options.contains(message)) {
          //                     _addMessage(
          //                         "Please select a valid option", "Alice",
          //                         isAlice: true);

          //                     _askOptions();
          //                     break;
          //                   }
          //                   setState(() {
          //                     _selectedOption = message;
          //                     currentQuestion = "next";
          //                   });
          //                   break;
          //               }
          //             }
          //             _messageController.clear();
          //             setState(() {});
          //             WidgetsBinding.instance!.addPostFrameCallback((_) {
          //               _scrollController.animateTo(
          //                 _scrollController.position.maxScrollExtent,
          //                 duration: Duration(milliseconds: 300),
          //                 curve: Curves.easeOut,
          //               );
          //             });
          //           },
          //           decoration: InputDecoration(
          //             hintText: 'Type your message...',
          //           ),
          //         ),
          //       ),
          //     ),
          //     IconButton(
          //       icon: Icon(Icons.send),
          //       onPressed: () {
          //         String message = _messageController.text;
          //         if (message.isNotEmpty) {
          //           _addMessage(message, 'You');
          //           _messageController.clear();
          //           setState(() {});
          //           WidgetsBinding.instance!.addPostFrameCallback((_) {
          //             _scrollController.animateTo(
          //               _scrollController.position.maxScrollExtent,
          //               duration: Duration(milliseconds: 300),
          //               curve: Curves.easeOut,
          //             );
          //           });
          //         }
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  // Function to build a message bubble
  Widget _buildMessageBubble(ChatMessage message, Function setState) {
    return Align(
      alignment: message.isAlice ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        constraints: BoxConstraints(
          maxWidth: 280,
          minWidth: 100,
        ),
        padding: message.isButton ? null : const EdgeInsets.all(10),
        decoration: message.isButton
            ? null
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: message.isButton
                ? [
                    if (message.isAlice)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('Alice.png'),
                          radius: 0,
                        ),
                      ),
                    Expanded(
                      child: _buildButtons(message.text, message.sender,
                          message.value, setState),
                    ),
                  ]
                : [
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
      {bool isAlice = false,
      bool isYouTubeLink = false,
      bool isButton = false,
      String value = ""}) {
    _chatMessages.add(ChatMessage(text, sender,
        isAlice: isAlice,
        isYouTubeLink: isYouTubeLink,
        isButton: isButton,
        value: value));
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

  Widget _buildButtons(
      String text, String sender, String value, Function setState) {
    // Split the message into individual buttons based on a delimiter (e.g., '|')
    List<String> buttons = text.split('|');

    // Create a button for each part of the message
    List<Widget> buttonWidgets = buttons.map((buttonText) {
      return ElevatedButton(
        onPressed: () {
          // Handle button click based on the buttonText or sender
          _handleButtonClick(buttonText, sender, value, setState);
        },
        child: Text(buttonText),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buttonWidgets,
    );
  }

  void _handleButtonClick(
      String buttonText, String sender, String value, Function setState) async {
    if (currentQuestion == null) {
      _messageController.clear();
      setState(() {});
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      _chatMessages = [];
      _messageController.clear();

      setState(() {});
      switch (currentQuestion) {
        case "person":
          switch (value) {
            case "student-advisor":
              _addMessage(
                "Do you need help with a situation or general information?",
                "Alice",
                isAlice: true,
              );

              _addMessage("I want guidance about an individual", "Alice",
                  isAlice: true, value: "guidance", isButton: true);

              _addMessage("Legal information", "Alice",
                  isAlice: true, value: "legal", isButton: true);

              _addMessage("Template letters", "Alice",
                  isAlice: true, value: "template", isButton: true);

              _addMessage("Factsheets", "Alice",
                  isAlice: true, value: "factsheet", isButton: true);

              _addMessage("FAQs", "Alice",
                  isAlice: true, value: "faq", isButton: true);

              setState(() {
                currentQuestion = "help";
              });
              break;
          }
        case "help":
          switch (value) {
            case "template":
              _addMessage(
                "Please select a category you want the template letter from",
                "Alice",
                isAlice: true,
              );

              _addMessage("Advocacy", "Alice",
                  isAlice: true, value: "advocacy", isButton: true);

              _addMessage("Assessment", "Alice",
                  isAlice: true, value: "sssessment", isButton: true);

              _addMessage("Care changes", "Alice",
                  isAlice: true, value: "care-changes", isButton: true);

              _addMessage("Care planning", "Alice",
                  isAlice: true, value: "care-planning", isButton: true);

              _addMessage("Children and young people", "Alice",
                  isAlice: true, value: "children", isButton: true);

              _addMessage("Carer's rights", "Alice",
                  isAlice: true, value: "carer-rights", isButton: true);

              _addMessage("Complaints", "Alice",
                  isAlice: true, value: "complaints", isButton: true);

              _addMessage("Cost of living", "Alice",
                  isAlice: true, value: "cost", isButton: true);

              _addMessage("Cuts", "Alice",
                  isAlice: true, value: "cuts", isButton: true);

              _addMessage("Direct payments", "Alice",
                  isAlice: true, value: "direct-payment", isButton: true);

              _addMessage("Discrimination", "Alice",
                  isAlice: true, value: "discrimination", isButton: true);

              _addMessage("General", "Alice",
                  isAlice: true, value: "general", isButton: true);

              _addMessage("Hospital discharge", "Alice",
                  isAlice: true, value: "hospital", isButton: true);

              _addMessage("Mental capacity", "Alice",
                  isAlice: true, value: "mental-capacity", isButton: true);

              _addMessage("Moving house", "Alice",
                  isAlice: true, value: "moving-house", isButton: true);

              _addMessage("Reviews", "Alice",
                  isAlice: true, value: "reviews", isButton: true);

              _addMessage("Safeguarding", "Alice",
                  isAlice: true, value: "safeguarding", isButton: true);

              setState(() {
                currentQuestion = "letter";
              });
              break;
          }
        case "letter":
          switch (value) {
            case "safeguarding":
              _addMessage(
                  "What type of assistance are you looking for?", "Alice",
                  isAlice: true);

              _addMessage("SC75 - raising safeguarding concerns", "Alice",
                  isAlice: true, value: "sc75", isButton: true);

              _addMessage("SC84 - Request for safeguarding enquiry", "Alice",
                  isAlice: true, value: "sc84", isButton: true);

              _addMessage(
                  "Please note: If you are concerned that an adult is in immediate danger from abuse or neglect, or that a criminal act has happened you should contact the police by dialing 999.",
                  "Alice",
                  isAlice: true);

            case "sc75":
              _addMessage(
                  "Can you tell us what local authority is responsible for your social care?",
                  "Alice",
                  isAlice: true);

              _addMessage(
                  "We collect data about where enquiries are coming from to see patterns in care of different local authorities. We can also use this info to argue for better social care in your area. ",
                  "Alice",
                  isAlice: true);

              _addMessage("Type your postcode so we can check for you", "Alice",
                  isAlice: true, value: "postcode", isButton: true);

              _addMessage("Type your local authority if you know it", "Alice",
                  isAlice: true, value: "authority", isButton: true);

              _addMessage("I don’t want to give my local authority information",
                  "Alice",
                  isAlice: true, value: "skip", isButton: true);

            case "skip":
              _addMessage(
                  "Based on our conversation, you want to write to the local authority or integrated care board about raising a safeguarding concern?",
                  "Alice",
                  isAlice: true);

              _addMessage("I can help you write a letter/email", "Alice",
                  isAlice: true, value: "help-write", isButton: true);

              _addMessage("Download the template letter", "Alice",
                  isAlice: true, value: "download", isButton: true);

            case "download":
              downloadLocalFile();

              _addMessage(
                  "Just before you go… Can I make sure that everyone involved is safe and not at risk?",
                  "Alice",
                  isAlice: true);

              _addMessage("Yes", "Alice",
                  isAlice: true, value: "yes", isButton: true);

              _addMessage("No", "Alice",
                  isAlice: true, value: "no", isButton: true);

            case "no":
              _addMessage("We hope you have found Alice helpful. Bye!", "Alice",
                  isAlice: true);
          }
      }
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  Future<String> getLocalFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path + '/' + fileName;
  }

  void downloadLocalFile() async {
    ByteData data = await rootBundle.load('SC75.docx');
    Uint8List docxBytes = data.buffer.asUint8List();

    if (kIsWeb) {
      final blob = Blob([docxBytes]);
      final url = Url.createObjectUrlFromBlob(blob);

      final anchorElement = AnchorElement(href: url)
        ..setAttribute("download", "SC75.docx")
        ..click();

      // Clean up resources after download
      Url.revokeObjectUrl(url);
    }
  }
}

// Model class for chat messages
class ChatMessage {
  final String text;
  final String sender;
  final bool isAlice;
  final bool isYouTubeLink;
  final bool isButton;
  final String value;

  ChatMessage(
    this.text,
    this.sender, {
    this.isAlice = false,
    this.value = "",
    this.isYouTubeLink = false,
    this.isButton = false,
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

                    //   _addMessage(message, 'You');
                    //   if (currentQuestion != null) {
                    //     switch (currentQuestion) {
                    //       case "name":
                    //         setState(() {
                    //           _userName = message;
                    //           currentQuestion = "person";
                    //         });

                    //         _askPerson();
                    //         break;

                    //       case "person":
                    //         List<String> options = ['1', '2', '3', '4'];
                    //         if (!options.contains(message)) {
                    //           _addMessage(
                    //               "Please select a valid option", "Alice",
                    //               isAlice: true);

                    //           _askPerson();
                    //           break;
                    //         }

                    //         setState(() {
                    //           _personType = message;
                    //           currentQuestion = "list-options";
                    //         });

                    //         _askOptions();
                    //         break;

                    //       case "list-options":
                    //         List<String> options = ['1', '2', '3', '4', '5'];
                    //         if (!options.contains(message)) {
                    //           _addMessage(
                    //               "Please select a valid option", "Alice",
                    //               isAlice: true);

                    //           _askOptions();
                    //           break;
                    //         }
                    //         setState(() {
                    //           _selectedOption = message;
                    //           currentQuestion = "next";
                    //         });
                    //         break;
                    //     }
                    //   }
                    //   _messageController.clear();
                    //   setState(() {});
                    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
                    //     _scrollController.animateTo(
                    //       _scrollController.position.maxScrollExtent,
                    //       duration: Duration(milliseconds: 300),
                    //       curve: Curves.easeOut,
                    //     );
                    //   });
                    // },

                    