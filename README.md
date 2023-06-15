# How to Develop a Chat App with High-Quality UI Interaction Logic
<a href="https://velog.io/@ximya_hf/Flutter-%EC%99%84%EC%84%B1%EB%8F%84-%EB%86%92%EC%9D%80-%EC%B1%84%ED%8C%85-%EA%B8%B0%EB%8A%A5%EC%9D%84-%EB%A7%8C%EB%93%A4%EA%B8%B0-%EC%9C%84%ED%95%9C-%EC%9D%B8%ED%84%B0%EB%A0%89%EC%85%98-%EB%A1%9C%EC%A7%81%EB%93%A4">한국어 버전</a> 
<br/>
There are many intricate details to consider when implementing a chat UI. To create a chat app that we use dozens of times a day, we need to consider seemingly obvious details and implement a high-quality chat feature that considers the user experience (UX).
This post explains how to develop a chat app that applies the UI `interaction` logic seen in representative chat apps such as WhatsApp, KakaoTalk, and Line.

# Basic Structure
First, let's look at the basic structure of the chat screen.
```dart
Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: const Color(0xFF007AFF),
      ), // <-- App bar
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(...), // <- Chat list view
          ), 
           _BottomInputField(), // <- Fixed bottom TextField widget
        ],
      ),
    );
```
Generally, the chat screen has a simple structure. It consists of an `AppBar`, `Chat ListView`, and a` TextField` fixed at the bottom.

An important point here is that the chat list view and the text field must be wrapped in a `Column` widget, and the chat list view section must be wrapped in an `Expanded` widget.<br/><br/>
<img src="https://github.com/Xim-ya/Basic_Chat_UI_Implementation/assets/75591730/e180b031-25d1-4861-a3ea-726e345f671b"> <br/></br>
The `chat list view` and `input field` wrapped in a Column widget are arranged vertically, and since the `chat list view section` is wrapped in Expanded, the `input field` view is naturally fixed at the bottom. This has the advantage of not needing to fix the `input field` widget at the bottom using Stack & Positioned widgets.
Please note that the examples I will continue to show are also arranged in this structure.


# 1. Interaction where the input field and chat list view section respond to changes when the virtual keyboard area is detected

<img src="https://github.com/Xim-ya/Basic_Chat_UI_Implementation/assets/75591730/1aaefc1f-dc80-420a-8c94-a12d2bd47908"/> <br/> <br/>
The first chat interaction to consider is how the `input field` and `chat list` `view section` respond to changes when the `virtual keyboard` appears. It is important for the user experience that when the virtual keyboard appears, the input field and chat list view naturally follow the movement.</br><br/>
To achieve this, you need to set the following two `properties`

### resizeToAvoidBottomInset property

```dart
return Scaffold(
      resizeToAvoidBottomInset: true, // assign true
      appBar: AppBar(
        title: const Text("Ximya"),
        backgroundColor: const Color(0xFF007AFF),
      ),
```
First, you need to set the `resizeToAvoidBottomInset` property of the Scaffold widget to `true`. When this property is set to true, the Scaffold widget automatically adjusts its size to avoid overlapping with the virtual keyboard when the `virtual keyboard` appears.

### reversed property
```dart
ListView.separated(
 reverse: true,
    itemCount: chatList.length,
    ...
 )
```
Secondly, you need to set the `reversed` property of the `ListView` widget to `true`. This property specifies whether to arrange the list items in reverse order. By setting reversed to true, items are arranged from bottom to top, and the size change of the virtual keyboard can be detected.

> NOTE: index and Position When reversed
true is set, the items in the ListView are arranged from bottom to top. As a result, the index and position of the items on the screen are reversed. This needs to be considered when manipulating the data passed to the ListView. If data manipulation is necessary, reversing the values once more before passing data to the ListView might be the solution. 
For example, controller.chatList.reversed.toList().


# 2. Interaction when chat is added and scrolled down!
<img src="https://github.com/Xim-ya/Basic_Chat_UI_Implementation/assets/75591730/9f2b687a-0d5d-4218-92ea-0f91c5ddf726"><br/><br/>
When a message is added to the chat list, it should be placed at the bottom and scroll naturally. To achieve this, you need to set the `reversed` property of the ListView to `true`. By setting reversed to true, items are arranged from bottom to top. Therefore, when a message is added, the area of the ListView expands and the scroll position changes.


# 3. Aligning Chat Messages to the Top
<img src="https://github.com/Xim-ya/Basic_Chat_UI_Implementation/assets/75591730/4686e6bb-6124-4741-a131-31bfa562bdf8"><br/><br/>
So far, I've told you that you need to set the `reversed` property of the ListView widget to `true`. However, this leads to the issue of the chat list section being placed at the very bottom of the screen.
```dart
Align(
 alignment: Alignment.topCenter,
 child: ListView.separated(
 shrinkWrap: true,
 reverse: true,
    itemCount: chatList.length,
    itemBuilder: (context, index) {
    return Bubble(chat: chatList[index]);
       },
    );
   ),
```
Since setting the reversed property to true places the chat list section at the very bottom of the screen, you need to make some modifications to make the chat messages appear at the top of the screen. Wrap the ListView widget with `Align` and set the alignment property to Alignment.topCenter to place it at the top. Also, you need to set the `shrinkWrap: true` property on the ListView. This way, the ListView adjusts its size to fit its internal content and is placed at the top under the influence of the Alignment widget.



# 4. Optimizing Scroll Position after Sending Messages
<img src="https://github.com/Xim-ya/Basic_Chat_UI_Implementation/assets/75591730/7c65aa9f-c2a9-42b5-b3d1-3a9594dfa941"><br/><br/>
When a chat message is sent, the scroll position should change to the very bottom, regardless of where the current scroll position is. To achieve this, you can control the scrolling behavior of the ListView using a `ScrollController`.

```dart
final scrollController = ScrollController()

...

ListView.separated(
 shrinkWrap: true,
 reverse: true,
    controller: scrollController                                  
    itemCount: chatList.length,
    itemBuilder: (context, index) {
  return Bubble(chat: chatList[index]);
     },
 );
```

First, initialize a ScrollController variable. Then, pass this variable to the controller property of the ListView. Now you can control the scrolling behavior of the ListView.

```dart
Future<void> onFieldSubmitted() async {
  addMessage();
   
  // Move the scroll position to the bottom
  scrollController.animateTo(
    0,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  textEditingController.text = '';
}
```

Then, apply the `scrollController.animatedTo` event to the method that occurs when a chat is added to add an animation that scrolls to the very bottom. The reason we passed an offset value of `0` to the animatedTo method is because, with listview.buidler set to `reversed:true`, a position of `0` essentially means the very bottom of the list.


# 5. Dismissing the Virtual Keyboard on Chat Area Click
Lastly, in a typical chat app, there is an `interaction where the virtual keyboard hides down` when the general chat list area is tapped while the virtual keyboard is up. To implement this, you just need to add a simple piece of code.
```dart
Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus(); // <-- Hide virtual keyboard
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Selector<ChatController, List<Chat>>(
                  selector: (context, controller) =>
                      controller.chatList.reversed.toList(),
                  builder: (context, chatList, child) {
                    return ListView.separated(
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.only(top: 12, bottom: 20) +
                          const EdgeInsets.symmetric(horizontal: 12),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 12,
                      ),
                      controller:
                          context.read<ChatController>().scrollController,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return Bubble(chat: chatList[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
```
Wrap the chat list section with a `GestureDetector` widget and pass the `FocusScope.of(context).unfocus()` event to the onTap function.
```dart
// 1. Initialization
final focusNode = FocusNode();

// 2. Passing the focusNode object
TextField(
 focusNode :  focusNode,
...
),

// 3. When the chat section is tapped
onChatListSectinoTapped() {
 focusNode.unfocus()
```

Another way is to use a FocusNode object to hide the virtual keyboard. Initialize a FocusNode object and set the focusNode attribute in the text field. Then, when the chat list section is tapped, call `focusNode.unfocus()` to hide the virtual keyboard.
