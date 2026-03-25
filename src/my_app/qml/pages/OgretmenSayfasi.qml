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
        sourceComponent: ogretmenSayfasiPage
    }

    Component{
        id:ogretmenSayfasiPage
        Item{
            id: daireMerkez
            width: parent.width
            height: parent.height
            layer.enabled: true
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
                            text: "ÖĞRETMENİM"
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
                        color: "#d97d1a"
                        anchors.right: parent.right

                        Rectangle {
                            width : 250
                            height : 250
                            radius: width / 2
                            color: "#c3b59b"
                            anchors.centerIn: parent
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -60  // biraz yukarı al
                            
                            Image {
                                source: ASSETS_PATH + "/icons/ogretmen_selin.png"
                                width: parent.width * 0.98
                                height: parent.height * 0.98
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                            }
                            Text {
                            id: ogretmenAdi
                            text: "Selin Öğretmen"
                            font.family: "Montserrat"
                            font.pixelSize: 25
                            color: '#ffffff'
                            anchors.top: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                                
                        }

                       
                        }
                        }
            }
            
            MultiEffect {
                
                anchors.fill: parent
                source: icerik
                maskSource: daireCerceve
                maskEnabled: true
                z:0
                
            }
            
            Rectangle {
                id: ikonlumetinliButon
                width: 200
                height: 50
                property bool sesCaliniyor: false
                z: 10  // MultiEffect'ın önünde


                // Pozisyonu manuel ayarla (daireMerkez'e göre)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width / 4  // sağ yarıya kaydır
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 125 // daireden biraz aşağı

                color: sesCaliniyor ? (mouseArea.pressed ? '#c12828' : '#ce0e0e') 
                        : (mouseArea.pressed ? "#6da030" : (mouseArea.containsMouse ? "#9cd64f" : "#8ec63f"))
                
                radius: 20
                scale: mouseArea.pressed ? 0.95 : (mouseArea.containsMouse ? 1.05 : 1.0)
                Behavior on scale { NumberAnimation { duration: 100 } }
                Behavior on color { ColorAnimation { duration: 150 } }
                Row {
                        anchors.centerIn: parent
                        spacing: 12
                        Image {
                            source: ASSETS_PATH + "/icons/volume-high(2).png"
                            width: 30
                            height: 30
                            fillMode: Image.PreserveAspectFit
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "Mesajı Dinle"
                            font.family: "Montserrat"
                            font.pixelSize: 20
                            color: '#ffffff'
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true // containsMouse çalışması için şart
                    onClicked: {
                        ikonlumetinliButon.sesCaliniyor = !ikonlumetinliButon.sesCaliniyor
                        if (ikonlumetinliButon.sesCaliniyor) {
                            appControl.play_sound("selin_hocanin_mesaji.wav")
                        } else {
                            appControl.stop_sound()
                        }
                    }
                }
            }
            TemelBilesenler.OzelButon {
                id: okul_sistemi
                butonKonumX: 94
                butonKonumY: 545
                arkaPlanResmi: ASSETS_PATH + "/icons/okul_sistemi.png"
                butonRengi: '#fafafa'
                onClicked: {
                    sayfaYoneticisi.pop("qrc/Main.qml")
                    appControl.stop_sound()
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
                    appControl.stop_sound()
                }
                z:3
            }


    }
}
}
