# Photos

This app showcases some image handling techniques to create a photo-viewing app. The app will take image URL's as provided by a JSON feed, convert those URL’s and display as images. The app makes use of Alamofire to handle asynchronous requests for JSON objects as well as Haneke for image caching and image downloading on the background thread.

RUNNING THE APP

To run the app, please clone this repo or download the project as a ZIP file. Once the project is opened in Xcode, connect an iPhone, and hit the hotkey "Command + R" to run the app (you can also hit the play button in the top left corner of the Xcode window). Xcode will prompt you to unlock your phone if it is currently locked and will open the app once it has installed and compiled on your device. Once it is running proceed to testing the app's functionality. Steps to test the app are provided below.

For best results, please run the app on an iPhone.


TESTING

The app has a very simple user interface, here are some steps to ensure that the app is working as designed:

1.	Run the app to see the homepage. A UICollectionView will populate with images from the network shortly after opening. The speed of the images appearing will depend on your network connection. Scrolling through the collection view should be a very smooth experience.
2.	Tap on an image and you will be taken to the Gallery view. The Gallery view should show you a larger view of the image you just tapped on
3.	Every 2 seconds, the Gallery view will transition to the next photo in the list. The counter at the top of the screen will show your current position in the range of photos.
4.	Hitting the trash icon in the top right of the screen will delete the image that is currently showing in the Gallery view.
5.	Tapping the back button will return you to the Homepage view. Any images you might have deleted in the Gallery view will remain deleted in this view as well.
6.	If you lose network connectivity after loading images from the network, the app will continue to display any images that were previously downloaded
7.	If the app is initially started without a network connection, you a label will appear on screen asking you to reconnect to the Internet.

I hope you enjoy using the app! Any and all comments and suggestions are more than welcome!

