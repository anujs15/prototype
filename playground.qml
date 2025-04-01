import QtQuick 2.15
import QtQuick.Controls 2.15
import "dataset.js" as Fn
import mouseless 1.0

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


    Component.onCompleted: {
        Store.resetSequence()
        keyHandler.forceActiveFocus()
    }



    Rectangle {
        id: keyHandler
        anchors.fill: parent
        focus: true
        color: "transparent"
        Keys.enabled: true

        Keys.onPressed: (event)=> Store.handleKeyPress(event)
        Keys.onReleased: (event)=>Store.handleKeyRelease(event)


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
                            text:  `${Store.count}/${Fn.dataset.length}`
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
                text: Fn.dataset[Store.currentIndex].description
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
                                   model: Fn.dataset[Store.currentIndex].key
                                   delegate: Rectangle {
                                       id:keyrect

                                       width: Store.keyColors[index] === "green" ? 70 : Store.keyColors[index] === "red" ? 70 : 60
                                       height: Store.keyColors[index] === "green" ? 50 : Store.keyColors[index] === "red" ? 50 : 40

                                       color: Store.keyColors[index] === "green" ? "white" : Store.keyColors[index] === "red" ? "white" : "black"
                                       border.color: Store.keyColors[index] === "green" ? "white" : Store.keyColors[index] === "red" ? "white" : "gray"
                                       border.width: 2
                                       radius: 10

                                       Text {
                                           anchors.centerIn: parent
                                           font.pointSize: 14
                                           color:Store.keyColors[index] === "green" ? "darkblack" : Store.keyColors[index] === "red" ? "darkblack" : "gray"
                                           text: modelData
                                       }

                                       // CheckBoxcircle

                                       Rectangle{
                                            visible:Store.keyColors[index] === "green" ? true : Store.keyColors[index] === "red" ? true : false
                                          anchors{
                                              right: parent.right
                                              top: parent.top
                                               rightMargin: -5
                                               topMargin: -5
                                          }

                                          width:18
                                          height:18
                                          radius: 9

                                          color:Store.keyColors[index] === "green" ? "green" : Store.keyColors[index] === "red" ? "red" : "black"

                                          Text {
                                              anchors.centerIn: parent
                                              font.pointSize: 14
                                              color:Store.keyColors[index] === "green" ? "darkblack" : Store.keyColors[index] === "red" ? "darkblack" : "gray"
                                              text:Store.keyColors[index] === "green" ? "✓" : Store.keyColors[index] === "red" ? "✗" : ""
                                          }

                        }

                    }
                }
            }

            Text {
                id: resultDisplay
                text: Store.resultText
                color: Store.resultColor
                font.pixelSize: 24
                anchors{
                    right:parent.right
                    top:parent.top
                    topMargin: (parent.height/4)
                    rightMargin: (parent.width/3)
                }
                opacity: Store.resultOpacity
                Behavior on opacity { NumberAnimation { duration: 200 } }
            }
        }
    }
}

