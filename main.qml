import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import NameForRegistrationImport 1.0

Window {
    id: windos
    visible: true
    width: 640
    height: 640
    title: qsTr("TICK-TACK-TOE")

    Rectangle {
        id: base
        anchors.fill: parent;

        Image {
            id: background_image
            source: "file://Users/sprotsen/tick-tack-toe/background.jpg"
        }

        Row {
            id: block_text
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 100
            Text {
                font.pointSize: 36
                text: "Player 1: 'X'";
                color: "green"
            }
            Text {
                font.pointSize: 36
                text: "Player 2: 'O'";
                color: "green"
            }
        }
        Button {
            id: button_repeat
            anchors.top: block_text.bottom
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Repeat"
            width: 120
            height: 50
            style: ButtonStyle {
                background: Rectangle {
                    opacity: 0
                }
                label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    font.pointSize: 36
                    text: control.text
                    color: "yellow"
                }
            }
            onClicked: {
                dataModel.repeatPressed();
            }
        }

        MyModel {
            id: dataModel
        }

        Grid {
            id: grid
            columns: 3
            spacing: 5
            anchors.top: button_repeat.bottom
            anchors.topMargin: 15;
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: dataModel
                Button {
                   width: 120;
                   height: 120;

                   style: ButtonStyle {
                       background: Rectangle {
                           opacity: 0.2
                       }
                   }

                   Text {
                       anchors.fill: parent;
                       verticalAlignment: Text.AlignVCenter
                       horizontalAlignment: Text.AlignHCenter
                       font.pointSize: 40
                       font.bold: true
                       text: model.text
                   }

                   MouseArea {
                       anchors.fill: parent
                       onClicked: {
                           dataModel.buttonPressed(index);
                       }
                   }
                }
            }
        }
    }

    Item {
        anchors.fill: parent
        Item
        {
            id: rect
            width: 300
            height: 100
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 50

            Text
            {
                id: tmpText
                anchors.fill: parent
                font.pointSize: 36
                color: "red"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: dataModel.winner
            }
        }
    }
    Connections
    {
        target: dataModel
        onWinnerChanged:
        {
            tmpText.text = dataModel.winner;
        }
    }
}
