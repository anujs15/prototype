import QtQuick 2.15
import QtQuick.Controls 2.15

Page {

    id: mainWindow
    visible: true
    width: 800
    height: 600
    title: "Keyboard Shortcut Trainer"
    anchors.fill: parent

    property StackView stackView

    background: Rectangle{
        color: "transparent"
}

    property var dataset: [
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
    property bool allkeys:true
    property int count:1
    property bool skipright:true


    Component.onCompleted: {
        resetSequence()
        keyHandler.forceActiveFocus()
    }

    function resetSequence() {
        allkeys=true
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

           if (event.key === Qt.Key_Escape)
            {
                if(stackView) stackView.pop()
                event.accepted=true
                return
            }

             else if(event.key === Qt.Key_Enter || event.key===Qt.Key_Return) resetSequence()
             else if(event.key === Qt.Key_Right && currentStep==0) skipRight()
              else if(event.key === Qt.Key_Left && currentStep==0) skipLeft()

            else{
                   const currentKey = expectedSequence[currentStep]

                  if (checkKeyPress(event)) {

                         activeKeys[currentKey] = true
                          var newColors=keyColors.slice()
                          newColors[currentStep] = "green"
                          keyColors=newColors
                           currentStep++

                         if (currentStep === expectedSequence.length) {
                                  showResult(allkeys)
                                nextShortcutTimer.start()

                           }

                         event.accepted = true
                  }

                 else  {
                           activeKeys[currentKey] = true
                           newColors=keyColors.slice()
                            newColors[currentStep] = "red"
                            keyColors=newColors
                            currentStep++
                            allkeys=false
                         if (currentStep === expectedSequence.length) {
                                showResult(allkeys)
                            }

                       }
            }
        }

        Keys.onReleased: {
            const releasedKey = Object.keys(activeKeys).find(key =>
                (key === "Ctrl" && !(event.modifiers & Qt.ControlModifier)) ||
                (key === "Shift" && !(event.modifiers & Qt.ShiftModifier)) ||
                (key === "Alt" && !(event.modifiers & Qt.AltModifier)) ||
                (event.key === key.charCodeAt(0))
            )

                 if((event.key=== Qt.Key_Right || event.key=== Qt.Key_Left) && currentStep==0)
                 {
                     resetSequence()
                 }

                else if(event.key === Qt.Key_Enter || event.key===Qt.Key_Return)
                 {
                     resetSequence()
                 }

              else if (releasedKey) {

                   delete activeKeys[releasedKey]
                    if (currentStep > 0 && currentStep < expectedSequence.length) {
                       showResult(false)
                       currentStep = 0
                       resetSequence()
                }
            }
            else{
                   delete activeKeys[releasedKey]
                     showResult(false)
                     currentStep =0
                    resetSequence()
                }
        }


              // count store

              Rectangle{
                        id:countstore
                        height:50
                        width: 50
                        color:"black"

                        anchors{
                            right: parent.right
                            top:parent.top
                            rightMargin: 40
                            topMargin: 40
                        }

                        Text {
                            id: text
                            font.pointSize: 18
                            anchors.centerIn: parent
                            text:  `${count}/${dataset.length}`
                            color: "white"
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
                font { pixelSize: 48; bold: true }
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 100
            }

            Row {
                spacing: 30
                anchors{
                         horizontalCenter: keydes.horizontalCenter
                         top: keydes.top
                         topMargin: 150
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

                                          Text {
                                              anchors.centerIn: parent
                                              font.pointSize: 14
                                              color:keyColors[index] === "green" ? "darkblack" : keyColors[index] === "red" ? "darkblack" : "gray"
                                              text:keyColors[index] === "green" ? "✓" : keyColors[index] === "red" ? "✗" : ""
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
                    topMargin: (parent.height/4)
                    rightMargin: (parent.width/3)
                }
                opacity: 0
                Behavior on opacity { NumberAnimation { duration: 200 } }
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

    function skipRight()
    {
        currentIndex = (currentIndex + 1)<dataset.length?currentIndex + 1:dataset.length
        count=(((count + 1) <dataset.length+1))?count+1:dataset.length
         resetSequence()
    }

    function skipLeft()
    {
        currentIndex = (currentIndex - 1)>0?currentIndex - 1:0
        count=(count - 1)>0?count-1:1
        resetSequence()
    }

    function advanceShortcut() {

          currentIndex = (currentIndex + 1) % dataset.length
          count=(((count + 1) % (dataset.length+1))==0)?1:count+1

        resetSequence()
        resultDisplay.opacity = 0
    }

    function showResult(success) {
        resultDisplay.text = success ? "✓ Correct!" : "✗ Try Again!"
        resultDisplay.color = success ? "green" : "red"
        resultDisplay.opacity = 1
        if (!success) errorResetTimer.restart()
    }
}

