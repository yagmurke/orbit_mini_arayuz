import QtQuick 
import QtQuick.Window 
import QtQuick.Effects
import QtQuick.Controls 
import "../" as TemelBilesenler
Item{
    visible: true
    width: 800
    height: 800

    Loader {
        anchors.fill: parent
        sourceComponent: odevlerimMatematikPage
    }

    Component{
        id: odevlerimMatematikPage
        Item{
            id: daireMerkez
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            Rectangle {
                id: daireCerceve
                anchors.fill: parent
                radius: width / 2
                layer.enabled: true
                visible:false
            }

            Item{
                    id : icerik
                    anchors.fill: parent
                    layer.enabled: true
                    visible: false

                    Image {
                        id: solTarafResmi
                        source: ASSETS_PATH + "/icons/background-5.png"
                        width: parent.width /2
                        height: parent.height
                        anchors.left: parent.left
                        fillMode: Image.PreserveAspectCrop
                    }
                    Column {
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 2
                        z: 10
                        Text { text: "MATEMATİK"; font.pixelSize: 38; font.bold: true; color: "#1e88e5"; anchors.horizontalCenter: parent.horizontalCenter }
                        Text { text: "ÖDEVİ"; font.pixelSize: 38; font.bold: true; color: "#4caf50"; anchors.horizontalCenter: parent.horizontalCenter }

                    }
                    
                    Rectangle {
                        width: parent.width /2
                        height: parent.height
                        color: '#e3e1de'
                        opacity: 0.9
                        anchors.left: parent.left
                       
                    

                    }

                    Rectangle {
                        width: parent.width /2
                        height: parent.height
                        color: '#c2d7e1'
                        anchors.right: parent.right

                       
                      
                    }

        
        }
        MultiEffect {    
            anchors.fill: parent
            source: icerik
            maskSource: daireCerceve
            maskEnabled: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
            }
        Image {
            id: odevGorseli
            source: ASSETS_PATH + "/icons/verilen_odev.png" // Yolun doğruluğundan emin ol
            anchors.centerIn: parent
            width: 650  // Tasarıma göre genişliği ayarlayabilirsin
            fillMode: Image.PreserveAspectFit
            z: 100 // En üstte kalmasını garanti eder
        }
        Rectangle {
            id: checkBolumu
            width: 500 // Beyaz panelin genişliğiyle uyumlu
            height: 70
            color: "#f8f9fa"
            radius: 15
            border.color: "#eeeeee"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 160
            // anchors.bottom: odevGorseli.bottom
            anchors.bottomMargin: 40 // Görselin içindeki alt boşluğa hizalamak için
            z: 101 // Görselin de üstünde durması için

            Row {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                Column {
                    width: parent.width - 70
                    anchors.verticalCenter: parent.verticalCenter
                    Text { 
                        text: "TAMAMLANDI MI?"; 
                        font.pixelSize: 18; 
                        font.bold: true; 
                        color: "#333333" 
                    }
                    Text { 
                        text: "Ödevi Bitirdim!"; 
                        font.pixelSize: 14; 
                        color: "#777777" 
                    }
                }

                // TİK KUTUSU
                Rectangle {
                    width: 45; height: 45
                    radius: 8
                    border.color: "black"
                    border.width: 2
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Text {
                        text: "✔"
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        color: "#4caf50"
                        visible: tapHandler.checked
                    }

                    TapHandler {
                        id: tapHandler
                        property bool checked: false
                        onTapped: checked = !checked
                    }
                }
            }
        }
        TemelBilesenler.OzelButon {
                id: geri_butonu
                butonKonumX: 250
                butonKonumY: 620
                arkaPlanResmi:ASSETS_PATH + "/icons/geri_butonu.png"
                butonRengi: '#fafafa'
                onClicked: {
                    sayfaYoneticisi.pop()
                }
                z:3
            }
        Rectangle {
            id: tamamlaBtn
            width: 220
            height: 70
            radius: 35 // Tam oval olması için height'ın yarısı
            color: "white"
            border.color: "#e0e0e0" // İnce gri çerçeve
            border.width: 2
            anchors.left: geri_butonu.right      // Geri butonunun sağından başla
            anchors.leftMargin: 20               // İki buton arası boşluk
            anchors.verticalCenter: geri_butonu.verticalCenter // Geri butonuyla aynı hizada tut

            Row {
                anchors.centerIn: parent
                spacing: 12
                
                // Yeşil Tik İkonu
                Text {
                    text: "✅" 
                    font.pixelSize: 22
                    verticalAlignment: Text.AlignVCenter
                }

                Text {
                    text: "TAMAMLA"
                    color: "#4caf50" // Yeşil metin
                    font.pixelSize: 20
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                }
            }

            TapHandler {
                onTapped: {
                    console.log("Ödev Tamamlandı!")
                    // Buraya tamamlandığında gidecek sayfa veya işlem gelebilir
                }
                onPressedChanged: tamamlaBtn.opacity = pressed ? 0.7 : 1.0 // Tıklama hissi
            }
    }
       
    }

    
    
    
}
}