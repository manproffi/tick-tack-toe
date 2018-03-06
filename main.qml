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
        color: "green"

        Row {
            id: block_text
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 100
            Text {
                font.pointSize: 24
                text: "Player 1: 'X'";
            }
            Text {
                font.pointSize: 24
                text: "Player 2: 'O'";
            }
        }
        Button {
            id: button_repeat
            anchors.top: block_text.bottom
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Repeat"
            width: 100
            height: 34
            style: ButtonStyle {
                label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    font.pointSize: 20
                    text: control.text
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
                Rectangle {
                   width: 120;
                   height: 120;

                   Text {
                       anchors.fill: parent;
                       verticalAlignment: Text.AlignVCenter
                       horizontalAlignment: Text.AlignHCenter
                       font.pointSize: 30
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
        Rectangle
        {
            id: rect
            color: base.color
            width: 300
            height: 100
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 50

            Text
            {
                id: tmpText
                anchors.fill: parent
                font.pointSize: 24
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
