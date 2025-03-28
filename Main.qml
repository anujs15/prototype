
// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.VirtualKeyboard

// ApplicationWindow {
//     id: mainWindow
//     visible: true
//     width: 800
//     height: 600
//     title: "Keyboard Shortcuts"
//     color: "black"

//     // Dataset of keyboard shortcuts (converted from data.jsx)
//     property var dataset: [
//         {key: ["Ctrl", "C"], description: "Copy selected text"},
//         {key: ["Ctrl", "X"], description: "Cut"},
//         {key: ["Ctrl", "V"], description: "Paste"},
//         {key: ["Ctrl", "Z"], description: "Undo"},
//         {key: ["Ctrl", "Y"], description: "Redo"},
//         {key: ["Ctrl", "A"], description: "Select all"},
//         {key: ["Ctrl", "P"], description: "Print"},
//         {key: ["Ctrl", "S"], description: "Save"},
//         {key: ["Ctrl", "N"], description: "New window/document"},
//         {key: ["Ctrl", "O"], description: "Open"},
//         {key: ["Ctrl", "W"], description: "Close"}
//     ]

//     property int currentIndex: 0
//        // property string result: ""
//         property var keyColors: []
//         property int toggleIndex: 0

//         Component.onCompleted: {
//             resetKeyColors()
//             keyHandler.forceActiveFocus()
//         }

//         function resetKeyColors() {
//             keyColors = new Array(dataset[currentIndex].key.length).fill("white")
//             keyColorsChanged() // Explicit signal emission
//             toggleIndex = 0
//         }

//         Rectangle {
//             id: keyHandler
//             anchors.fill: parent
//             color: "transparent"
//             focus: true

//             Keys.onPressed: (event) => {
//                 console.log("Key event:", event.key, "Modifiers:", event.modifiers)

//                 if (event.key === Qt.Key_Escape) Qt.quit()

//                 const expectedKey = dataset[currentIndex].key[toggleIndex]
//                 const isModifier = ["Ctrl", "Shift", "Alt"].includes(expectedKey)
//                 let isCorrect = false

//                 // Handle modifier keys first
//                 if (isModifier) {
//                     isCorrect = checkModifier(expectedKey, event)
//                 }
//                 // Handle regular keys with modifiers
//                 else if (event.modifiers & Qt.ControlModifier && expectedKey === "C") {
//                     isCorrect = true
//                 }
//                 // Handle other regular keys
//                 else {
//                     const pressedKey = event.text.toUpperCase()
//                     isCorrect = (pressedKey === expectedKey.toUpperCase())
//                 }

//                 processKeyResult(isCorrect)
//                 event.accepted = true
//             }

//             function checkModifier(expected, event) {
//                 switch(expected) {
//                     case "Ctrl": return event.modifiers & Qt.ControlModifier
//                     case "Shift": return event.modifiers & Qt.ShiftModifier
//                     case "Alt": return event.modifiers & Qt.AltModifier
//                 }
//                 return false
//             }

//             function processKeyResult(correct) {
//                 if (correct) {
//                     keyColors[toggleIndex] = "green"
//                     toggleIndex++
//                     keyColorsChanged()

//                     if (toggleIndex >= dataset[currentIndex].key.length) {
//                         resetTimer.start()
//                     }
//                 } else {
//                     keyColors[toggleIndex] = "red"
//                     keyColorsChanged()
//                     resetTimer.start()
//                 }
//             }

//             Timer {
//                 id: resetTimer
//                 interval: 1200
//                 onTriggered: {
//                     currentIndex = (currentIndex + 1) % dataset.length;
//                     resetKeyColors()
//                     result = ""
//                     keyHandler.forceActiveFocus()
//                 }
//             }
//         }

//     Column {

//         id:main

//         width:parent.width
//         height:parent.height
//         anchors{
//                  horizontalCenter: parent.horizontalCenter
//                  top: parent.top
//                  topMargin: parent.height/3
//         }

//         Text {
//             id:keydes
//             text: dataset[currentIndex].description
//             font.pointSize: 32
//             color: "white"
//             anchors.horizontalCenter: parent.horizontalCenter
//             anchors.topMargin: 100
//         }

//         Row {
//             spacing: 30
//             //anchors.horizontalCenter: parent.horizontalCenter
//             anchors{
//                      horizontalCenter: keydes.horizontalCenter
//                      top: keydes.top
//                      topMargin: 100
//             }

//             Repeater {
//                 model: dataset[currentIndex].key
//                 delegate: Rectangle {
//                     id:keyrect

//                     width: keyColors[index] === "green" ? 70 : keyColors[index] === "red" ? 70 : 60
//                     height: keyColors[index] === "green" ? 50 : keyColors[index] === "red" ? 50 : 40

//                     color: keyColors[index] === "green" ? "white" : keyColors[index] === "red" ? "white" : "black"
//                     border.color: keyColors[index] === "green" ? "white" : keyColors[index] === "red" ? "white" : "gray"
//                     border.width: 2
//                     radius: 10

//                     Text {
//                         anchors.centerIn: parent
//                         font.pointSize: 14
//                         color:keyColors[index] === "green" ? "darkblack" : keyColors[index] === "red" ? "darkblack" : "gray"
//                         text: modelData
//                     }

//                     // CheckBoxcircle

//                     Rectangle{
//                          visible:keyColors[index] === "green" ? true : keyColors[index] === "red" ? true : false
//                        anchors{
//                            right: parent.right
//                            top: parent.top
//                             rightMargin: -5
//                             topMargin: -5
//                        }

//                        width:18
//                        height:18
//                        radius: 9

//                        color:keyColors[index] === "green" ? "green" : keyColors[index] === "red" ? "red" : "black"

//                        Image {
//                            id: myimage
//                            anchors.centerIn: parent ?
//                              source:keyColors[index] === "green" ? "qrc:/images/right.png" : keyColors[index] === "red""qrc:/images/wrong.png":"none"
//                              width: parent.width/2
//                              height: parent.height/2
//                            }

//                     }
//                 }
//             }
//         }

//         Button {
//             text: "Skip"

//             anchors{
//                      right: parent.right
//                      top: parent.top
//                      topMargin: parent.height/2
//                      rightMargin: parent.width/4
//             }

//             onClicked: {
//                 currentIndex = (currentIndex + 1) % dataset.length;
//                 resetKeyColors(); // Reset colors when skipping to next shortcut.
//             }
//         }

//         // Text {
//         //     text: result
//         //     font.pointSize: 30
//         //     color: result === "" ? "transparent" : (result === 'Correct! Next shortcut.' ? 'green' : 'red')
//         //     visible: result !== "" // Make it visible only if there is a result
//         //     anchors.horizontalCenter: parent.horizontalCenter
//         //     anchors.topMargin: 20
//         // }
//     }
// }








// import QtQuick 2.15
// import QtQuick.Controls 2.15

// ApplicationWindow {
//     id: mainWindow
//     visible: true
//     width: 800
//     height: 600
//     title: "Keyboard Shortcut Trainer"
//     color: "black"

//     property var dataset: [
//         {key: ["Ctrl", "C"], description: "Copy selected text"},
//         {key: ["Ctrl", "Shift", "N"], description: "New private window"},
//         {key: ["Ctrl", "V"], description: "Paste"},
//         {key: ["Ctrl", "Z"], description: "Undo"},
//         {key: ["Ctrl", "X"], description: "Cut"},
//         {key: ["Ctrl", "Y"], description: "Redo"},
//         {key: ["Ctrl", "A"], description: "Select all"},
//         {key: ["Ctrl", "P"], description: "Print"},
//         {key: ["Ctrl", "S"], description: "Save"},
//         {key: ["Ctrl", "N"], description: "New window/document"},
//         {key: ["Ctrl", "O"], description: "Open"},
//         {key: ["Ctrl", "W"], description: "Close"}
//     ]

//     property int currentIndex: 0
//     property var activeKeys: ({})
//     property var expectedSequence: []
//     property int currentStep: 0

//     // UI properties
//     property color baseColor: "#404040"
//     property color successColor: "#2ecc71"
//     property color errorColor: "#e74c3c"

//     Component.onCompleted: {
//         resetSequence()
//         keyHandler.forceActiveFocus()
//     }

//     function resetSequence() {
//         currentStep = 0
//         activeKeys = {}
//         expectedSequence = dataset[currentIndex].key
//     }

//     function checkKeyPress(event) {
//         const currentKey = expectedSequence[currentStep]
//         const isModifier = ["Ctrl", "Shift", "Alt"].includes(currentKey)
//         let keyMatch = false

//         if (currentKey === "Ctrl") {
//             keyMatch = event.modifiers & Qt.ControlModifier
//         } else if (currentKey === "Shift") {
//             keyMatch = event.modifiers & Qt.ShiftModifier
//         } else if (currentKey === "Alt") {
//             keyMatch = event.modifiers & Qt.AltModifier
//         } else {
//             keyMatch = event.key === currentKey.charCodeAt(0)
//         }

//         return keyMatch && !activeKeys[currentKey]
//     }

//     Rectangle {
//         id: keyHandler
//         anchors.fill: parent
//         focus: true
//         color: "transparent"
//         Keys.enabled: true

//         Keys.onPressed: {
//             if (event.isAutoRepeat) return
//             if (event.key === Qt.Key_Escape) Qt.quit()

//             const currentKey = expectedSequence[currentStep]
//             if (checkKeyPress(event)) {
//                 activeKeys[currentKey] = true
//                 currentStep++

//                 if (currentStep === expectedSequence.length) {
//                     showResult(true)
//                     nextShortcutTimer.start()
//                 }
//                 event.accepted = true
//             } else if (!Object.values(activeKeys).includes(true)) {
//                 showResult(false)
//                 errorResetTimer.start()
//             }
//         }

//         Keys.onReleased: {
//             const releasedKey = Object.keys(activeKeys).find(key =>
//                 (key === "Ctrl" && !(event.modifiers & Qt.ControlModifier)) ||
//                 (key === "Shift" && !(event.modifiers & Qt.ShiftModifier)) ||
//                 (key === "Alt" && !(event.modifiers & Qt.AltModifier)) ||
//                 (event.key === key.charCodeAt(0))
//             )

//             if (releasedKey) {
//                 delete activeKeys[releasedKey]
//                 if (currentStep > 0) {
//                     currentStep = 0
//                     resetSequence()
//                 }
//             }
//         }

//         Column {

//              id:main
//              width:parent.width
//              height: parent.height
//              spacing: 40
//              anchors{
//                  horizontalCenter: parent.horizontalCenter
//                  top: parent.top
//                  topMargin: parent.height/3
//              }

//             Text {
//                 id:keydes
//                 text: dataset[currentIndex].description
//                 color: "white"
//                 font { pixelSize: 32; bold: true }
//                 anchors.horizontalCenter: parent.horizontalCenter
//                 anchors.topMargin: 100
//             }

//             Row {
//                 spacing: 30
//                 anchors{
//                          horizontalCenter: keydes.horizontalCenter
//                          top: keydes.top
//                          topMargin: 100
//                        }

//                 Repeater {
//                     model: expectedSequence
//                     delegate: Rectangle {

//                         id:keyrect
//                         width:currentStep>index ? 70 : 60
//                         height: currentStep>index ? 50 : 40
//                         radius: 10
//                         color: {
//                             if (currentStep > index) return "white"
//                             if (currentStep === index && activeKeys[modelData]) return "gray"
//                             return "black"
//                         }
//                         border.color: currentStep>index ? "white" : "gray"
//                         border.width: 2

//                         Text {
//                             text: modelData
//                             color: currentStep>index ? "darkblack":"gray"
//                             font { pixelSize: 14; bold: true }
//                             anchors.centerIn: parent
//                         }

//                         // checkboxcircle

//                         Rectangle{
//                             visible: currentStep>index ? true : false
//                             anchors{
//                                 right: parent.right
//                                 top: parent.top
//                                 rightMargin: -5
//                                 topMargin: -5
//                             }

//                             width: 18
//                             height: 18
//                             radius: 9

//                             color:currentStep>index ? "green": "red"

//                             Image {
//                                 id: myimage
//                                 anchors.centerIn: parent
//                                 source: currentStep>index ? "qrc:/images/right.png":"qrc:/images/wrong.png"
//                                 width: parent.width/2
//                                 height: parent.height/2
//                             }
//                         }

//                     }
//                 }
//             }

//             Text {
//                 id: resultDisplay
//                 text: ""
//                 color: "white"
//                 font.pixelSize: 24
//                 anchors{
//                     right:parent.right
//                     top:parent.top
//                     topMargin: parent.height/2
//                     rightMargin: parent.width/2
//                 }
//                 opacity: 0
//                 Behavior on opacity { NumberAnimation { duration: 200 } }
//             }

//             Button {
//                 text: "Skip Shortcut"
//                 anchors{
//                     right:parent.right
//                     top:parent.top
//                     topMargin: parent.height/2
//                     rightMargin: parent.width/4
//                 }

//                 onClicked: advanceShortcut()
//                 background: Rectangle {
//                     color: "#2980b9"
//                     radius: 5
//                 }
//             }
//         }
//     }

//     Timer {
//         id: nextShortcutTimer
//         interval: 1500
//         onTriggered: advanceShortcut()
//     }

//     Timer {
//         id: errorResetTimer
//         interval: 1000
//         onTriggered: resultDisplay.opacity = 0
//     }

//     function advanceShortcut() {
//         currentIndex = (currentIndex + 1) % dataset.length
//         resetSequence()
//         resultDisplay.opacity = 0
//     }

//     function showResult(success) {
//         resultDisplay.text = success ? "✓ Correct!" : "✗ Try Again!"
//         resultDisplay.color = success ? successColor : errorColor
//         resultDisplay.opacity = 1
//         if (!success) errorResetTimer.restart()
//     }
// }





// import QtQuick 2.15
// import QtQuick.Controls 2.15

// ApplicationWindow {
//     id: mainWindow
//     visible: true
//     width: 800
//     height: 600
//     title: "Keyboard Shortcut Trainer"
//     color: "black"

//     property var dataset: [
//         {key: ["Ctrl", "C"], description: "Copy selected text"},
//         {key: ["Ctrl", "Shift", "N"], description: "New private window"},
//         {key: ["Ctrl", "V"], description: "Paste"},
//         {key: ["Ctrl", "Z"], description: "Undo"},
//         {key: ["Ctrl", "X"], description: "Cut"},
//         {key: ["Ctrl", "Y"], description: "Redo"},
//         {key: ["Ctrl", "A"], description: "Select all"},
//         {key: ["Ctrl", "P"], description: "Print"},
//         {key: ["Ctrl", "S"], description: "Save"},
//         {key: ["Ctrl", "N"], description: "New window/document"},
//         {key: ["Ctrl", "O"], description: "Open"},
//         {key: ["Ctrl", "W"], description: "Close"}
//     ]

//     property int currentIndex: 0
//     property var activeKeys: ({})
//     property var expectedSequence: []
//     property int currentStep: 0
//     property var keyColors: []

//     // UI properties
//     property color baseColor: "#404040"
//     property color successColor: "#2ecc71"
//     property color errorColor: "#e74c3c"

//     Component.onCompleted: {
//         resetSequence()
//         keyHandler.forceActiveFocus()
//     }

//     function resetSequence() {
//         currentStep = 0
//         activeKeys = {}
//         keyColors = new Array(dataset[currentIndex].key.length).fill("white")
//         expectedSequence = dataset[currentIndex].key
//     }

//     function checkKeyPress(event) {
//         const currentKey = expectedSequence[currentStep]
//         const isModifier = ["Ctrl", "Shift", "Alt"].includes(currentKey)
//         let keyMatch = false

//         if (currentKey === "Ctrl") {
//             keyMatch = event.modifiers & Qt.ControlModifier
//         } else if (currentKey === "Shift") {
//             keyMatch = event.modifiers & Qt.ShiftModifier
//         } else if (currentKey === "Alt") {
//             keyMatch = event.modifiers & Qt.AltModifier
//         } else {
//             keyMatch = event.key === currentKey.charCodeAt(0)
//         }

//         return keyMatch && !activeKeys[currentKey]
//     }

//     Rectangle {
//         id: keyHandler
//         anchors.fill: parent
//         focus: true
//         color: "transparent"
//         Keys.enabled: true

//         Keys.onPressed: {
//             if (event.isAutoRepeat) return
//             if (event.key === Qt.Key_Escape) Qt.quit()

//             const currentKey = expectedSequence[currentStep]
//             if (checkKeyPress(event)) {
//                 activeKeys[currentKey] = true
//                // keyColors[currentStep]="green"
//                 currentStep++

//                 if (currentStep === expectedSequence.length) {
//                     showResult(true)
//                     nextShortcutTimer.start()
//                 }
//                 event.accepted = true
//             } else if (!Object.values(activeKeys).includes(true)) {
//                  //keyColors[currentStep]="red"
//                   currentStep++
//                   //event.accepted = true
//             }
//         }

//         Keys.onReleased: {
//             const releasedKey = Object.keys(activeKeys).find(key =>
//                 (key === "Ctrl" && !(event.modifiers & Qt.ControlModifier)) ||
//                 (key === "Shift" && !(event.modifiers & Qt.ShiftModifier)) ||
//                 (key === "Alt" && !(event.modifiers & Qt.AltModifier)) ||
//                 (event.key === key.charCodeAt(0))||(currentStep<=dataset[currentIndex].length)
//             )

//             if (releasedKey) {
//                 delete activeKeys[releasedKey]
//                 if (currentStep > 0) {
//                     currentStep = 0
//                     resetSequence()
//                 }
//             }
//         }

//         Column {

//              id:main
//              width:parent.width
//              height: parent.height
//              spacing: 40
//              anchors{
//                  horizontalCenter: parent.horizontalCenter
//                  top: parent.top
//                  topMargin: parent.height/3
//              }

//             Text {
//                 id:keydes
//                 text: dataset[currentIndex].description
//                 color: "white"
//                 font { pixelSize: 32; bold: true }
//                 anchors.horizontalCenter: parent.horizontalCenter
//                 anchors.topMargin: 100
//             }

//             Row {
//                 spacing: 30
//                 anchors{
//                          horizontalCenter: keydes.horizontalCenter
//                          top: keydes.top
//                          topMargin: 100
//                        }

//                 Repeater {
//                                    model: dataset[currentIndex].key
//                                    delegate: Rectangle {
//                                        id:keyrect

//                                        width: keyColors[index] === "green" ? 70 : keyColors[index] === "red" ? 70 : 60
//                                        height: keyColors[index] === "green" ? 50 : keyColors[index] === "red" ? 50 : 40

//                                        color: keyColors[index] === "green" ? "white" : keyColors[index] === "red" ? "white" : "black"
//                                        border.color: keyColors[index] === "green" ? "white" : keyColors[index] === "red" ? "white" : "gray"
//                                        border.width: 2
//                                        radius: 10

//                                        Text {
//                                            anchors.centerIn: parent
//                                            font.pointSize: 14
//                                            color:keyColors[index] === "green" ? "darkblack" : keyColors[index] === "red" ? "darkblack" : "gray"
//                                            text: modelData
//                                        }

//                                        // CheckBoxcircle

//                                        Rectangle{
//                                             visible:keyColors[index] === "green" ? true : keyColors[index] === "red" ? true : false
//                                           anchors{
//                                               right: parent.right
//                                               top: parent.top
//                                                rightMargin: -5
//                                                topMargin: -5
//                                           }

//                                           width:18
//                                           height:18
//                                           radius: 9

//                                           color:keyColors[index] === "green" ? "green" : keyColors[index] === "red" ? "red" : "black"

//                                           Image {
//                                               id: myimage
//                                               anchors.centerIn: parent ?
//                                                 source:keyColors[index] === "green" ? "qrc:/images/right.png" : keyColors[index] === "red"?"qrc:/images/wrong.png":"none"
//                                                 width: parent.width/2
//                                                 height: parent.height/2
//                                               }

//                         }

//                     }
//                 }
//             }

//             Text {
//                 id: resultDisplay
//                 text: ""
//                 color: "white"
//                 font.pixelSize: 24
//                 anchors{
//                     right:parent.right
//                     top:parent.top
//                     topMargin: parent.height/2
//                     rightMargin: parent.width/2
//                 }
//                 opacity: 0
//                 Behavior on opacity { NumberAnimation { duration: 200 } }
//             }

//             Button {
//                 text: "Skip Shortcut"
//                 anchors{
//                     right:parent.right
//                     top:parent.top
//                     topMargin: parent.height/2
//                     rightMargin: parent.width/4
//                 }

//                 onClicked: advanceShortcut()
//                 background: Rectangle {
//                     color: "#2980b9"
//                     radius: 5
//                 }
//             }
//         }
//     }

//     Timer {
//         id: nextShortcutTimer
//         interval: 1500
//         onTriggered: advanceShortcut()
//     }

//     Timer {
//         id: errorResetTimer
//         interval: 1000
//         onTriggered: resultDisplay.opacity = 0
//     }

//     function advanceShortcut() {
//         currentIndex = (currentIndex + 1) % dataset.length
//         resetSequence()
//         resultDisplay.opacity = 0
//     }

//     function showResult(success) {
//         resultDisplay.text = success ? "✓ Correct!" : "✗ Try Again!"
//         resultDisplay.color = success ? successColor : errorColor
//         resultDisplay.opacity = 1
//         if (!success) errorResetTimer.restart()
//     }
// }

// var newColors=keyColors.slice()
// newColors[currentStep] = "green"
// keyColors=newColors





import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 800
    height: 600
    title: "Keyboard Shortcut Trainer"
    color: "black"

    property var dataset: [
        {key: ["Ctrl", "C"], description: "Copy selected text"},
        {key: ["Ctrl", "Shift", "N"], description: "New private window"},
        {key: ["Ctrl", "V"], description: "Paste"},
        {key: ["Ctrl", "Z"], description: "Undo"},
        {key: ["Ctrl", "X"], description: "Cut"},
        {key: ["Ctrl", "Y"], description: "Redo"},
        {key: ["Ctrl", "A"], description: "Select all"},
        {key: ["Ctrl", "P"], description: "Print"},
        {key: ["Ctrl", "S"], description: "Save"},
        {key: ["Ctrl", "N"], description: "New window/document"},
        {key: ["Ctrl", "O"], description: "Open"},
        {key: ["Ctrl", "W"], description: "Close"}
    ]

    property int currentIndex: 0
    property var activeKeys: ({})
    property var expectedSequence: []
    property int currentStep: 0
    property var keyColors: []

    // UI properties
    property color baseColor: "#404040"
    property color successColor: "#2ecc71"
    property color errorColor: "#e74c3c"

    Component.onCompleted: {
        resetSequence()
        keyHandler.forceActiveFocus()
    }

    function resetSequence() {
        currentStep = 0
        activeKeys = {}
        keyColors = new Array(dataset[currentIndex].key.length).fill("white")
        expectedSequence = dataset[currentIndex].key
    }

    function checkKeyPress(event) {
        const currentKey = expectedSequence[currentStep]
        const isModifier = ["Ctrl", "Shift", "Alt"].includes(currentKey)
        let keyMatch = false

        if (currentKey === "Ctrl") {
            keyMatch = event.modifiers & Qt.ControlModifier
        } else if (currentKey === "Shift") {
            keyMatch = event.modifiers & Qt.ShiftModifier
        } else if (currentKey === "Alt") {
            keyMatch = event.modifiers & Qt.AltModifier
        } else {
            keyMatch = event.key === currentKey.charCodeAt(0)
        }

        return keyMatch && !activeKeys[currentKey]
    }

    Rectangle {
        id: keyHandler
        anchors.fill: parent
        focus: true
        color: "transparent"
        Keys.enabled: true

        Keys.onPressed: {
            if (event.isAutoRepeat) return
            if (event.key === Qt.Key_Escape) Qt.quit()

            const currentKey = expectedSequence[currentStep]
            if (checkKeyPress(event)) {
                activeKeys[currentKey] = true
                var newColors=keyColors.slice()
                newColors[currentStep] = "green"
                keyColors=newColors
                currentStep++

                if (currentStep === expectedSequence.length) {
                    showResult(true)
                    nextShortcutTimer.start()
                }
                event.accepted = true
            } else if (!Object.values(activeKeys).includes(true)) {
                 newColors=keyColors.slice()
                newColors[currentStep] = "red"
                keyColors=newColors
                  currentStep++
            }
        }

        Keys.onReleased: {
            const releasedKey = Object.keys(activeKeys).find(key =>
                (key === "Ctrl" && !(event.modifiers & Qt.ControlModifier)) ||
                (key === "Shift" && !(event.modifiers & Qt.ShiftModifier)) ||
                (key === "Alt" && !(event.modifiers & Qt.AltModifier)) ||
                (event.key === key.charCodeAt(0))
            )

            if (releasedKey) {
                delete activeKeys[releasedKey]
                if (currentStep > 0) {
                    currentStep = 0
                    resetSequence()
                }
            }
        }

        Column {

             id:main
             width:parent.width
             height: parent.height
             spacing: 40
             anchors{
                 horizontalCenter: parent.horizontalCenter
                 top: parent.top
                 topMargin: parent.height/3
             }

            Text {
                id:keydes
                text: dataset[currentIndex].description
                color: "white"
                font { pixelSize: 32; bold: true }
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 100
            }

            Row {
                spacing: 30
                anchors{
                         horizontalCenter: keydes.horizontalCenter
                         top: keydes.top
                         topMargin: 100
                       }

                Repeater {
                                   model: dataset[currentIndex].key
                                   delegate: Rectangle {
                                       id:keyrect

                                       width: keyColors[index] === "green" ? 70 : keyColors[index] === "red" ? 70 : 60
                                       height: keyColors[index] === "green" ? 50 : keyColors[index] === "red" ? 50 : 40

                                       color: keyColors[index] === "green" ? "white" : keyColors[index] === "red" ? "white" : "black"
                                       border.color: keyColors[index] === "green" ? "white" : keyColors[index] === "red" ? "white" : "gray"
                                       border.width: 2
                                       radius: 10

                                       Text {
                                           anchors.centerIn: parent
                                           font.pointSize: 14
                                           color:keyColors[index] === "green" ? "darkblack" : keyColors[index] === "red" ? "darkblack" : "gray"
                                           text: modelData
                                       }

                                       // CheckBoxcircle

                                       Rectangle{
                                            visible:keyColors[index] === "green" ? true : keyColors[index] === "red" ? true : false
                                          anchors{
                                              right: parent.right
                                              top: parent.top
                                               rightMargin: -5
                                               topMargin: -5
                                          }

                                          width:18
                                          height:18
                                          radius: 9

                                          color:keyColors[index] === "green" ? "green" : keyColors[index] === "red" ? "red" : "black"

                                          Image {
                                              id: myimage
                                              anchors.centerIn: parent ?
                                                source:keyColors[index] === "green" ? "qrc:/images/right.png" : keyColors[index] === "red"?"qrc:/images/wrong.png":"none"
                                                width: parent.width/2
                                                height: parent.height/2
                                              }

                        }

                    }
                }
            }

            Text {
                id: resultDisplay
                text: ""
                color: "white"
                font.pixelSize: 24
                anchors{
                    right:parent.right
                    top:parent.top
                    topMargin: parent.height/2
                    rightMargin: parent.width/2
                }
                opacity: 0
                Behavior on opacity { NumberAnimation { duration: 200 } }
            }

            Button {
                text: "Skip Shortcut"
                anchors{
                    right:parent.right
                    top:parent.top
                    topMargin: parent.height/2
                    rightMargin: parent.width/4
                }

                onClicked: advanceShortcut()
                background: Rectangle {
                    color: "#2980b9"
                    radius: 5
                }
            }
        }
    }

    Timer {
        id: nextShortcutTimer
        interval: 1500
        onTriggered: advanceShortcut()
    }

    Timer {
        id: errorResetTimer
        interval: 1000
        onTriggered: resultDisplay.opacity = 0
    }

    function advanceShortcut() {
        currentIndex = (currentIndex + 1) % dataset.length
        resetSequence()
        resultDisplay.opacity = 0
    }

    function showResult(success) {
        resultDisplay.text = success ? "✓ Correct!" : "✗ Try Again!"
        resultDisplay.color = success ? successColor : errorColor
        resultDisplay.opacity = 1
        if (!success) errorResetTimer.restart()
    }
}
