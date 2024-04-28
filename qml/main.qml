import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Dialogs

import Qt.labs.lottieqt

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
            animation.source = fileDialog.currentFile
        }
    }
}
