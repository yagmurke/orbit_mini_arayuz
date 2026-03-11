import QtQuick
import QtQuick.Window
import QtQuick.Effects
import QtQuick.Controls
import "../" as TemelBilesenler
Item {
    visible: true
    width: 800
    height: 800

    Loader {
        anchors.fill: parent
        sourceComponent: dersProgramiPage
    }

    Component{

        id: dersProgramiPage
        

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
                    source: ASSETS_PATH + "/icons/background2.jpeg"
                    width: parent.width /2
                    height: parent.height
                    anchors.left: parent.left
                    fillMode: Image.PreserveAspectCrop

                }
                Rectangle {
                    width: parent.width /2
                    height: parent.height
                    color: "#f59620"
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
                            text: "DERS PROGRAMI"
                            color: '#fafafa'
                            font.family: "Montserrat"
                            font.pixelSize: 35
                            font.bold: true
                            
                            // 4. KRİTİK NOKTA: Column'ın içinde kendi genişliğine göre ortala
                            anchors.horizontalCenter: parent.horizontalCenter
                            
                            // Görseldeki derinlik için gölge efekti
                            style: Text.Outline
                            styleColor: "#e67e22" 
                        }
                    }
            
                }
                
            
                Rectangle {
                    width: parent.width /2
                    height: parent.height
                    color: "#273a40"
                    anchors.right: parent.right

                    Column {
                        spacing: 0

                        property int yaziBoyu : 20
                        property int solBosluk: 20

                        ListModel{
                            id: derslerModel
                            ListElement { gun: "Pazartesi"; dersler: "Matematik\nHayat Bilgisi\nGörsel sanatlar\n" }
                            ListElement { gun: "Salı"; dersler: "Türkçe\nİngilizce\nMatematik\n" }
                            ListElement { gun: "Çarşamba"; dersler: "Hayat Bilgisi\nResim Dersi\nSerbest Etkinlik\n" }
                            ListElement { gun: "Perşembe"; dersler: "Türkçe\nMatematik\nBeden Eğitimi\n" }
                            ListElement { gun: "Cuma"; dersler: "Oyun ve Fiziki Etkinlikler\nTürkçe\nTürkçe\n" }
                        }

                        Item{ height: 100; width:1 } 

                        Repeater {
                            model: derslerModel
                            delegate: Column {
                                spacing: 0

                                Text {
                                    text: model.gun + ":"
                                    font.pixelSize: parent.parent.yaziBoyu
                                    color: "#f59620"
                                    leftPadding: parent.parent.solBosluk
                                }
                                Text {
                                    text: model.dersler
                                    font.pixelSize: parent.parent.yaziBoyu
                                    color: "white"
                                    leftPadding: parent.parent.solBosluk
                                }
                            }
                        }
                     
                    }
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
                z:3
                onClicked: {
                    sayfaYoneticisi.pop("qrc/Main.qml")
                }
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
            
            
        }

    
}
}

            