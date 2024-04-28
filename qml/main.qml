import QtQuick 2.3
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Dialogs 1.3

import Qt.labs.lottieqt 1.0

Window {
    visible: true
    width: 1280
    height: 720
    title: qsTr("Lottie Test")
    Column {
        anchors.fill: parent
        Row {
            Button {
                text: qsTr("Open")
                onClicked: fileDialog.open()
            }
            Label {
                id: statusText
            }
        }
        LottieAnimation {
            id: animation
            autoPlay: true
            loops: Animation.Infinite
            onStatusChanged: {
                    if (status === LottieAnimation.Error) {
                        console.log("Error loading animation")
                        statusText.text = "Error loading animation"
                    }
                }
        }
    }

    FileDialog {
        id: fileDialog
        title: qsTr("Please select a directory")
        onAccepted: {
            animation.source = fileDialog.fileUrl
        }
    }
}
