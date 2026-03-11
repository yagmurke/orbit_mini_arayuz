import QtQuick 

Rectangle {
    id: root
    width: 250
    height: 80
    color: "transparent"
    border.color: "#686767"
    radius: 10

    // DIŞARIDAN GELECEK ÖZELLİKLER (Properties)
    // Bu özellik sayesinde her butonun resmini Main.qml içinden değiştirebileceğiz
    property alias imageSource: butonResmi.source
    
    // Butona tıklandığında dışarıya (Main.qml'e) haber uçuracak sinyal
    signal clicked()

    Image {
        id: butonResmi
        anchors.centerIn: parent
        width: 75
        height: 50
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        
        // Kullanıcı buraya tıkladığında, bizim oluşturduğumuz 'clicked' sinyalini ateşle
        onClicked: {
            root.clicked()
        }
        
        // Görsel efekt: Basıldığında buton hafif şeffaflaşsın
        onPressed: root.opacity = 0.5
        onReleased: root.opacity = 1.0
    }
}