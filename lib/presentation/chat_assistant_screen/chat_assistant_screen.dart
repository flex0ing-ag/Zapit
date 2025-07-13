import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/message_bubble_widget.dart';
import './widgets/quick_action_widget.dart';
import './widgets/typing_indicator_widget.dart';

class ChatAssistantScreen extends StatefulWidget {
  const ChatAssistantScreen({super.key});

  @override
  State<ChatAssistantScreen> createState() => _ChatAssistantScreenState();
}

class _ChatAssistantScreenState extends State<ChatAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();

  bool _isTyping = false;
  bool _isListening = false;

  final List<Map<String, dynamic>> _messages = [
    {
      "id": "1",
      "message":
          "Hello! I'm your food assistant. I can help you find the perfect meal, check nutritional information, or recommend popular items. What would you like to know?",
      "isUser": false,
      "timestamp": DateTime.now().subtract(Duration(minutes: 2)),
      "type": "text"
    }
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {"id": "1", "title": "Recommend lunch", "icon": "restaurant_menu"},
    {"id": "2", "title": "Show vegetarian options", "icon": "eco"},
    {"id": "3", "title": "What's popular today?", "icon": "trending_up"}
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {
      "id": "1",
      "name": "Chicken Biryani",
      "price": "\$8.50",
      "image":
          "https://images.pexels.com/photos/1893556/pexels-photo-1893556.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "isVeg": false,
      "prepTime": "15 mins",
      "rating": 4.5,
      "description": "Aromatic basmati rice with tender chicken pieces"
    },
    {
      "id": "2",
      "name": "Paneer Butter Masala",
      "price": "\$6.00",
      "image":
          "https://images.pexels.com/photos/2474661/pexels-photo-2474661.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "isVeg": true,
      "prepTime": "12 mins",
      "rating": 4.3,
      "description": "Creamy tomato curry with soft paneer cubes"
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _loadChatHistory() {
    // Simulate loading chat history from local storage
    // In real implementation, load from SharedPreferences or local database
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "message": message,
        "isUser": true,
        "timestamp": DateTime.now(),
        "type": "text"
      });
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    _simulateAIResponse(message);
  }

  void _simulateAIResponse(String userMessage) {
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;

      String response = _generateAIResponse(userMessage);
      String responseType = _getResponseType(userMessage);

      setState(() {
        _messages.add({
          "id": DateTime.now().millisecondsSinceEpoch.toString(),
          "message": response,
          "isUser": false,
          "timestamp": DateTime.now(),
          "type": responseType,
          "menuItems": responseType == "menu_recommendation" ? _menuItems : null
        });
        _isTyping = false;
      });

      _scrollToBottom();
    });
  }

  String _generateAIResponse(String userMessage) {
    String lowerMessage = userMessage.toLowerCase();

    if (lowerMessage.contains("lunch") || lowerMessage.contains("recommend")) {
      return "Based on today's menu and your preferences, I recommend these popular lunch options:";
    } else if (lowerMessage.contains("vegetarian") ||
        lowerMessage.contains("veg")) {
      return "Here are our delicious vegetarian options available today:";
    } else if (lowerMessage.contains("popular") ||
        lowerMessage.contains("trending")) {
      return "These are the most popular items ordered today:";
    } else if (lowerMessage.contains("nutrition") ||
        lowerMessage.contains("calories")) {
      return "Here's the nutritional information for our menu items. Each item shows calories, protein, and other key nutrients.";
    } else if (lowerMessage.contains("canteen") ||
        lowerMessage.contains("location")) {
      return "Our campus has 3 canteens: Main Canteen (Building A), Food Court (Student Center), and Café Express (Library). Which one would you like to know more about?";
    } else {
      return "I can help you with menu recommendations, nutritional information, canteen locations, and popular items. What specific information are you looking for?";
    }
  }

  String _getResponseType(String userMessage) {
    String lowerMessage = userMessage.toLowerCase();

    if (lowerMessage.contains("lunch") ||
        lowerMessage.contains("recommend") ||
        lowerMessage.contains("vegetarian") ||
        lowerMessage.contains("popular")) {
      return "menu_recommendation";
    } else if (lowerMessage.contains("nutrition") ||
        lowerMessage.contains("calories")) {
      return "nutrition_info";
    } else {
      return "text";
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChatHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Clear Chat History',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Are you sure you want to clear all chat messages? This action cannot be undone.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _messages.clear();
                  _messages.add({
                    "id": "1",
                    "message":
                        "Hello! I'm your food assistant. I can help you find the perfect meal, check nutritional information, or recommend popular items. What would you like to know?",
                    "isUser": false,
                    "timestamp": DateTime.now(),
                    "type": "text"
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void _toggleVoiceInput() {
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening) {
      // Simulate voice input
      Future.delayed(Duration(seconds: 3), () {
        if (mounted && _isListening) {
          setState(() {
            _isListening = false;
          });
          _messageController.text = "What vegetarian options do you have?";
        }
      });
    }
  }

  void _handleQuickAction(String title) {
    _sendMessage(title);
  }

  void _addToCart(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item["name"]} added to cart'),
        backgroundColor: AppTheme.lightTheme.primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Food Assistant',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _clearChatHistory,
            icon: CustomIconWidget(
              iconName: 'delete_outline',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profile-screen'),
            icon: CustomIconWidget(
              iconName: 'person_outline',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    return TypingIndicatorWidget();
                  }

                  final message = _messages[index];
                  return MessageBubbleWidget(
                    message: message,
                    onAddToCart: _addToCart,
                  );
                },
              ),
            ),
          ),

          // Quick Actions
          if (_messages.isNotEmpty && !_isTyping)
            Container(
              height: 8.h,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _quickActions.length,
                itemBuilder: (context, index) {
                  final action = _quickActions[index];
                  return QuickActionWidget(
                    title: action["title"] as String,
                    iconName: action["icon"] as String,
                    onTap: () => _handleQuickAction(action["title"] as String),
                  );
                },
              ),
            ),

          // Input Area
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: AppTheme.lightTheme.dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Voice Input Button
                  GestureDetector(
                    onTap: _toggleVoiceInput,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: _isListening
                            ? AppTheme.lightTheme.primaryColor
                                .withValues(alpha: 0.1)
                            : AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(6.w),
                        border: Border.all(
                          color: _isListening
                              ? AppTheme.lightTheme.primaryColor
                              : AppTheme.lightTheme.dividerColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: CustomIconWidget(
                          iconName: _isListening ? 'mic' : 'mic_none',
                          color: _isListening
                              ? AppTheme.lightTheme.primaryColor
                              : AppTheme.lightTheme.colorScheme.onSurface,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 3.w),

                  // Text Input
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 12.w,
                        maxHeight: 24.w,
                      ),
                      child: TextField(
                        controller: _messageController,
                        focusNode: _messageFocusNode,
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: _sendMessage,
                        decoration: InputDecoration(
                          hintText: _isListening
                              ? 'Listening...'
                              : 'Ask about menu, nutrition, or recommendations...',
                          hintStyle: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.w),
                            borderSide: BorderSide(
                              color: AppTheme.lightTheme.dividerColor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.w),
                            borderSide: BorderSide(
                              color: AppTheme.lightTheme.dividerColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.w),
                            borderSide: BorderSide(
                              color: AppTheme.lightTheme.primaryColor,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 3.w,
                          ),
                          filled: true,
                          fillColor:
                              AppTheme.lightTheme.scaffoldBackgroundColor,
                        ),
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ),
                  ),

                  SizedBox(width: 3.w),

                  // Send Button
                  GestureDetector(
                    onTap: () => _sendMessage(_messageController.text),
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: _messageController.text.trim().isNotEmpty
                            ? AppTheme.lightTheme.primaryColor
                            : AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(6.w),
                        border: Border.all(
                          color: _messageController.text.trim().isNotEmpty
                              ? AppTheme.lightTheme.primaryColor
                              : AppTheme.lightTheme.dividerColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: CustomIconWidget(
                          iconName: 'send',
                          color: _messageController.text.trim().isNotEmpty
                              ? Colors.white
                              : AppTheme.lightTheme.colorScheme.onSurface,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
