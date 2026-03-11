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
        sourceComponent: derslerimPage
    }

    Component{
        id: derslerimPage
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
                visible: false
                layer.enabled : true

                Image {
                    id: solTarafResmi
                    source: ASSETS_PATH + "/icons/background3.png"
                    width: parent.width /2
                    height: parent.height
                    anchors.left: parent.left
                    fillMode: Image.PreserveAspectCrop
                }

                Rectangle {
                    id: solPanel
                    width: parent.width /2
                    height: parent.height
                    color: '#224e8c'
                    opacity: 0.9
                    anchors.left: parent.left
                    Column {
                        id: solBaslikGrubu
                            
                            // 1. ÖNEMLİ: Bu grubun genişliğini ekranın tam yarısı yapıyoruz
                        width: parent.width / 2 
                            
                            // 2. Ekranın en soluna yaslıyoruz
                        anchors.centerIn: parent
                            
                            // 3. Yukarıdan boşluk (Görseldeki hizaya göre)
                        anchors.top: parent.top
                        anchors.topMargin: 100 

                        spacing: 8

                        Text {
                            id: anaBaslik
                            text: "DERSLERİM"
                            color: '#fafafa'
                            font.family: "Montserrat"
                            font.pixelSize: 35
                            font.bold: true
                                
                            // 4. KRİTİK NOKTA: Column'ın içinde kendi genişliğine göre ortala
                            anchors.horizontalCenter: parent.horizontalCenter
                                
                            // Görseldeki derinlik için gölge efekti
                            style: Text.Outline
                            styleColor: "#224e8c" 
                            }
                        }
                }
                Rectangle {
                    id: sagPanel    
                    width: parent.width * 0.5
                    height: parent.height
                    color: '#bcc6cb'
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
            TemelBilesenler.OzelButon {
                id: okul_sistemi
                butonKonumX: 94
                butonKonumY: 545
                arkaPlanResmi: ASSETS_PATH + "/icons/okul_sistemi.png"
                butonRengi: '#fafafa'
                onClicked: {
                    sayfaYoneticisi.pop("qrc/Main.qml")
                }
                z:3
            }
            TemelBilesenler.OzelButon {
                id: geri_butonu
                butonKonumX: 250
                butonKonumY: 590
                arkaPlanResmi:ASSETS_PATH + "/icons/geri_butonu.png"
                butonRengi: '#fafafa'
                onClicked: {
                    sayfaYoneticisi.pop()
                }
                z:3
            }
            
            Column {
                id: butonSutunu
                width: parent.width * 0.5
                anchors.right: parent.right
                anchors.rightMargin: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 30 // Dikeyde milimetrik kaydırma için
                spacing: 15 // Satırlar arası boşluk

                // 1. SATIR: Tek Buton (Türkçe)
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    DersButonuComponent { 
                        ad: "Türkçe"; ikon: "turkce.png"; renk: "#4A90E2" 
                        onTiklandi: {
                            
                        }
                    }
                }

                // 2. SATIR: İki Buton (Matematik - Hayat Bilgisi)
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 40
                    DersButonuComponent { ad: "Matematik"; ikon: "matematik.png"; renk: "#FFD700"
                    onTiklandi:{
                        sayfaYoneticisi.push("matematik.qml")
                    }
                    }
                    DersButonuComponent { ad: "Hayat Bilgisi"; ikon: "hayat_bilgisi.png"; renk: "#5DBB63" }
                }

                // 3. SATIR: İki Buton (Oyun ve Fiziki - Görsel Sanatlar)
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 40
                    DersButonuComponent { ad: "Oyun ve Fiziki\nEtkinlikler"; ikon: "oyun_fiziki.png"; renk: "#FF8C00" }
                    DersButonuComponent { ad: "Görsel Sanatlar"; ikon: "resim.png"; renk: "#9370DB" }
                }

                // 4. SATIR: Tek Buton (Müzik)
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    DersButonuComponent { ad: "Müzik"; ikon: "muzik.png"; renk: "#FF4D4D" }
                }
            }

            // --- BUTON TASARIM ŞABLONU (Component) ---
            // Bunu dosyanın en altına veya dışına koyabilirsin
            component DersButonuComponent: Rectangle {
                property string ad: ""
                property string ikon: ""
                property color renk: "white"
                signal tiklandi()
                // BOYUT AYARI: Görseldeki o toplu hali yakalamak için sabit boyutlar
                width: 110 
                height: 140 
                radius: 25
                color: renk

                Column {
                    anchors.centerIn: parent
                    spacing: 8
                    width: parent.width

                    Rectangle {
                        width: 100; height: 100
                        radius: 50
                        color: "white"
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            source: ASSETS_PATH + "/icons/" + ikon
                            anchors.fill: parent; anchors.margins: 10
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    Text {
                        text: ad
                        color: "white"
                        font.pixelSize: 10; font.bold: true
                        width: parent.width * 0.9
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.scale = 0.95
                    onReleased: parent.scale = 1.0
                    onClicked: {
                        parent.tiklandi()
                    }
                }
            }
        }
        
    }
}
