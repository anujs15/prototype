
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts  1.15

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true
    title: "Mouseless"
    color: "black"

    StackView{
        id:stackView
        anchors.fill: parent
        initialItem: mainPage
    }

    Component{
        id:mainPage

     FocusScope{
         id:focusScope
         anchors.fill: parent
         focus: true

         // handling enter KeyEvent

         Keys.onPressed: function(event){
             if((event.key===Qt.Key_Return || event.key===Qt.Key_Enter) && vscode.activeFocus)
             {
                  stackView.push("playground.qml", {"stackView": stackView})
                 event.accepted=true
             }
         }

    Rectangle {
        id: tool
        anchors.fill: parent
        color: "black"

        GridLayout {
            id: gridLayout
            columns: 2
            anchors.centerIn: parent
            columnSpacing: 20
            rowSpacing: 20

            Rectangle {
                id: vscode
                Layout.preferredWidth: 280
                Layout.preferredHeight: 170

                focus:true
                radius: 20

                color: focus ? Qt.lighter("#696969", 1.5) : "#696969"

                border.width:focus?3:0
                border.color:"white"

                KeyNavigation.tab: vim

                Keys.onPressed: {
                    if(event.key===Qt.Key_Return || event.key===Qt.Key_Enter)
                    {
                        stackView.push("playground.qml", {"stackView": stackView})
                        event.accepted=true
                    }
                }

                Image {
                    id: image1
                    source: "qrc:~/../Documents/images/vscode.png"
                    width: parent.width/2
                    height: parent.height/2
                }

                Text {
                    id: vskey
                    text: "VsCode"
                    color: "white"
                     font { pixelSize: 24; bold: true }
                    anchors{
                        bottom: parent.bottom
                        left: parent.left
                        leftMargin: 20
                        bottomMargin: 20
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        forceActiveFocus()
                        stackView.push("playground.qml", {"stackView": stackView})
                    }
                }

            }
            Rectangle {
                id: vim
                Layout.preferredWidth: 280
                Layout.preferredHeight: 170
                radius: 20

                color: focus ? Qt.lighter("#696969", 1.5) : "#696969"

                border.width:focus?3:0
                border.color:"white"

                KeyNavigation.tab: Figma
                KeyNavigation.backtab: vscode

                Image {
                    id: image2
                    source: "qrc:~/../Documents/images/vim.png"
                    width: parent.width/2
                    height: parent.height/2
                }

                Text {
                    id: vimkey
                    text: "Vim"
                    color: "white"
                     font { pixelSize: 24; bold: true }
                    anchors{
                        bottom: parent.bottom
                        left: parent.left
                        leftMargin: 20
                        bottomMargin: 20
                    }
                }

            }

            Rectangle {
                id: figma
                Layout.preferredWidth: 280
                Layout.preferredHeight: 170
                radius: 20

                color: focus ? Qt.lighter("#696969", 1.5) : "#696969"

                border.width:focus?3:0
                border.color:"white"

                KeyNavigation.tab: webflow
                KeyNavigation.backtab: vim

                Image {
                    id: image3
                    source: "qrc:~/../Documents/images/figma.png"
                    width: parent.width/2
                    height: parent.height/2
                    anchors{
                        top: parent.top
                        topMargin: 10
                    }
                }

                Text {
                    id: figmakey
                    text: "Figma"
                    color: "white"
                     font { pixelSize: 24; bold: true }
                    anchors{
                        bottom: parent.bottom
                        left: parent.left
                        leftMargin: 20
                        bottomMargin: 20
                    }
                }
            }

            Rectangle {
                id: webflow
                Layout.preferredWidth: 280
                Layout.preferredHeight: 170
                radius: 20

                color: focus ? Qt.lighter("#696969", 1.7) : "#696969"

                border.width:focus?3:0
                border.color:"white"

                KeyNavigation.tab: vscode
                KeyNavigation.backtab: figma

                Image {
                    id: image4
                    source: "qrc:~/../Documents/images/webflow.png"
                    width: parent.width/2
                    height: parent.height/2
                }

                Text {
                    id: webflowkey
                    text: "Webflow"
                    color: "white"
                     font { pixelSize: 24; bold: true }
                    anchors{
                        bottom: parent.bottom
                        left: parent.left
                        leftMargin: 20
                        bottomMargin: 20
                    }
                }
            }
        }

         Component.onCompleted: vscode.forceActiveFocus()
    }
   }
 }
}


