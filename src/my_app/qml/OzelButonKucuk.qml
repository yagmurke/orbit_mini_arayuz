import QtQuick
import QtQuick.Controls
import QtQuick.Effects
Button {
    id: root

    property alias butonRengi: arkaPlan.color
    property alias butonYazisi: butonMetni.text
    property alias arkaPlanResmi: butonResmi.source
    property alias butonKonumX: root.x
    property alias butonKonumY: root.y


    width: 40
    height: 40

    hoverEnabled: false
    scale: down ? 0.95 : 1.0

    // Geri büyümenin yumuşak olması için bu şart:
    Behavior on scale {
        NumberAnimation { duration: 100 }
    }
    
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onPressed: {
            mouse.accepted = false
                
        }
    }
    background: Rectangle {
        id: arkaPlan
        color: "#fcb040"
        radius: 10
        anchors.fill: parent
        clip: true
        Image{
            id: butonResmi
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            visible: false
        }
        MultiEffect {
            anchors.fill: butonResmi
            source: butonResmi
            maskSource: arkaPlan
        }

    }

    contentItem: Text {
        id: butonMetni
        text: root.text
        color: "white"
        font.bold: true

    }
}