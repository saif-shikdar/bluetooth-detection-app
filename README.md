# Bluetooth Device Detection App
 An app that scans for nearby Bluetooth devices and displays them in a list.

 3.5 Hrs spent

## Demo

This demo demonstrates:

- How a device can be connected by tapping on the item on the list. This will display a green dot.
- If a device is connected, tapping the item will disconnect the device. This will display a red dot.
- Some devices may take some time to establish a connection therefore it will show a loading indicator to give user feedback.
- It also demonstrates error handling when a device is unable to pair. This shows an error message which can be dismissed.
- On the top left corner of the screen it displays Bluetooth status. If the user turns off Bluetooth it will update in the app immediately.

https://github.com/saif-shikdar/bluetooth-detection-app/assets/43826661/65228106-edc9-43ca-9e25-5d9e789f7d8d

## Architecture

- MVVM
- SwiftUI

## Decisions

- Created a new object that has an enum that handles connection status. This is because Corebluetooth uses callbacks for didConnect and didDisconnect events. Therefore to allow the view to update in real time this had to be stored in a separate property to adhere to the @Published property wrapper.
- Created a loading indicator when the user taps on the list item as I found that some devices took some time to connect and the user won't get any feedback. Therefore adding a loading indicator makes the app more responsive.

## Download Instructions

- The app can be downloaded directly from the GitHub repository and opened with XCode.
- If the simulator is used the Bluetooth list will appear empty and the simulator doesn't support Bluetooth.
- A real device cannot be connected via cable and used to open the app. Be aware that signing into your Apple ID will be required and permission will have to be enabled.
