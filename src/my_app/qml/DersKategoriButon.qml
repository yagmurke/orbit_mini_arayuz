import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Rectangle{
    id: root
    property string lessonName: ""
    property string iconSource: ""
    property color baseColor: "#a7cfe2"
    property alias butonKonumX: root.x
    property alias butonKonumY: root.y
    property color borderColor: "#a7cfe2"

    signal tiklandi()

    width: 300
    height: 50
    radius: 25
    color: mouseArea.pressed ? Qt.darker(baseColor, 1.1) : baseColor
    border.color: borderColor
    border.width:1.5
    
    Behavior on color { ColorAnimation { duration:100 } }
    Row{
        anchors.centerIn: parent
        spacing: 50
        Image{
            source: iconSource
            width: 45
            height: 45
        
        }
        Text {
            text: lessonName
            font.pixelSize: 25
            color: "#333"

        }
    }
    MouseArea{
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            root.tiklandi()
            console.log(lessonName + " detayına gidiliyor...")
        }
    }

}
