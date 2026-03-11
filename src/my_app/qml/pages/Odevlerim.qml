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
        sourceComponent: odevlerimPage
    }

    Component{
        id: odevlerimPage
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

                    Rectangle {
                        width: parent.width /2
                        height: parent.height
                        color: "#f59620"
                        opacity: 0.9
                        anchors.left: parent.left
                        // Başlığı taşıyan ana grup
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
                            text: "ÖDEVLERİM"
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

                        Text {
                            text: "2. Sınıf"
                            color: "white"
                            font.family: "Montserrat"
                            font.pixelSize: 28
                            font.weight: Font.Medium
                            opacity: 0.85
                            
                            // Column içinde ortala
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    }

                    Rectangle {
                        width: parent.width /2
                        height: parent.height
                        color: '#a7cfe2'
                        anchors.right: parent.right

                        Column {
                            id: sagBaslikGrubu
                            
                            // 1. ÖNEMLİ: Bu grubun genişliğini ekranın tam yarısı yapıyoruz
                            width: parent.width / 2 
                            
                            // 2. Ekranın en soluna yaslıyoruz
                            anchors.right: parent.right
                            anchors.rightMargin: 150
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -200
                            // 3. Yukarıdan boşluk (Görseldeki hizaya göre)
                            anchors.topMargin: 50 

                            spacing: 8

                            Image{
                                source:  ASSETS_PATH + "/icons/orbit_mini.png"
                                width: 120
                                height: 173
                                

                                
                            }

                            Text {
                                id: saganaBaslik
                                text: "AKTİF ÖDEVLERİM"
                                color: '#325689'
                                font.family: "Montserrat"
                                font.pixelSize: 25
                                font.bold: true
                                
                                // 4. KRİTİK NOKTA: Column'ın içinde kendi genişliğine göre ortala
                                anchors.horizontalCenter: parent.horizontalCenter
                                
                                // Görseldeki derinlik için gölge efekti
                                
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
            TemelBilesenler.DersKategoriButon{
                id: turkce_dersi
                butonKonumX: 410
                butonKonumY: 270
                lessonName: "Türkçe"
                iconSource: ASSETS_PATH + "/icons/literature.png"
                color: "#f6a860"
                borderColor: "#ce7231"
                
            }
            TemelBilesenler.DersKategoriButon{
                id: matematik_dersi
                butonKonumX: 410
                butonKonumY: 330
                lessonName: "Matematik"
                iconSource: ASSETS_PATH + "/icons/math.png"
                color: "#68ade7"
                borderColor: "#437fb2"
                onTiklandi:{
                    sayfaYoneticisi.push("matematikOdevlerim.qml")
                }
            }
            TemelBilesenler.DersKategoriButon{
                id: hayat_bilgisi_dersi
                butonKonumX: 410
                butonKonumY: 390
                lessonName: "Hayat Bilgisi"
                iconSource: ASSETS_PATH + "/icons/geography.png"
                color: "#7ecc90"
                borderColor: "#52a570"
            }
            TemelBilesenler.DersKategoriButon{
                id: gorsel_sanatlar_dersi
                butonKonumX: 410
                butonKonumY: 450
                lessonName: "Görsel Sanatlar"
                iconSource: ASSETS_PATH + "/icons/palette.png"
                color: "#b790e1"
                borderColor: "#7c51ae"
            }
            TemelBilesenler.DersKategoriButon{
                id: muzik_dersi
                butonKonumX: 410
                butonKonumY: 510
                lessonName: "Müzik"
                iconSource: ASSETS_PATH + "/icons/sol_anahtari.png"
                color: "#d76684"
                borderColor: "#aa4260"
            }
    }

    
    
    
}
}