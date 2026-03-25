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
        sourceComponent: matematikSayfa2Page
    }

    Component{
        id: matematikSayfa2Page
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
                            anchors.left: parent.left
                            anchors.leftMargin: 150
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -200
                            // 3. Yukarıdan boşluk (Görseldeki hizaya göre)
                            anchors.topMargin: 50 

                            spacing: 8

                            Text {
                                id: anaBaslik
                                text: "MATEMATİK:\n ÇAPRMA"
                                color: '#fafafa'
                                font.family: "Montserrat"
                                font.pixelSize: 25
                                font.bold: true
                                
                                // 4. KRİTİK NOKTA: Column'ın içinde kendi genişliğine göre ortala
                                anchors.horizontalCenter: parent.horizontalCenter
                                
                                // Görseldeki derinlik için gölge efekti
                                style: Text.Outline
                                styleColor: "#224e8c" 
                            }
                            
                        }
                        AnimatedImage {
                            id: carpmaGifi
                            source: ASSETS_PATH + "/videos/carpma-islemi-gif.gif"
                            anchors.top: parent.top
                            anchors.topMargin: 230
                            anchors.left: parent.left
                            anchors.leftMargin: 50
                            width: 340
                            height: 300
                            
                            // Boyut ayarı: Mavi alana sığması için
                    
                            // Görselin kendi içinde ortalanması
                            fillMode: Image.PreserveAspectFit
                            playing: true // GIF'in otomatik oynamasını sağlar
                            paused: false // Durdurmak istersen true yapabilirsin
                            onStatusChanged: {
                                if (status === AnimatedImage.Error) {
                                    console.log("Hata: GIF dosyası yüklenemedi! Yol: " + source)
                                } else if (status === AnimatedImage.Ready) {
                                    console.log("GIF başarıyla yüklendi.")
                                }
                            }
                        }
                     
                    }
                    Rectangle {
                        id: sagPanel    
                        width: parent.width * 0.5
                        height: parent.height
                        color: '#bcc6cb'
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

                            Text {
                                id: saganaBaslik
                                text: "ÇARPMA İŞLEMİ:"
                                color: '#224e8c'
                                font.family: "Montserrat"
                                font.pixelSize: 25
                                font.bold: true
                                
                                // 4. KRİTİK NOKTA: Column'ın içinde kendi genişliğine göre ortala
                                anchors.horizontalCenter: parent.horizontalCenter
                                
                                // Görseldeki derinlik için gölge efekti
                                
                            }
                            
                        }
                        Image {
                            id: carpmaGorseli2
                            source: ASSETS_PATH + "/icons/carpma2.png"
                            anchors.top: parent.top
                            anchors.topMargin: 250
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            width: 350
                            height: 250
                            // Boyut ayarı: Mavi alana sığması için
                    
                            // Görselin kendi içinde ortalanması
                            fillMode: Image.PreserveAspectFit
                        }
                        Rectangle {
                            id: toplamKutusu
                            
                            // --- BOYUTLAR ---
                            // Yazının uzunluğuna göre kutunun genişlemesini sağlar
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                            anchors.topMargin: 20
                            width: toplamMetni.implicitWidth + 40 
                            height: 45
                            
                            anchors.top: carpmaGorseli2.bottom
                            
                            // --- TASARIM ---
                            color: "white"          // İç dolgu rengi
                            radius: 15              // Köşelerin yuvarlaklığı
                            
                            // Çerçeve (Border) Ayarları
                            border.color: "#1a2a44" // Lacivert çerçeve rengi
                            border.width: 2         // Çerçevenin kalınlığı

                            // --- METİN ---
                            Text {
                                id: toplamMetni
                                text: "TOPLAM: 12 ELMA"
                                anchors.centerIn: parent // Metni kutunun tam ortasına hizalar
                                
                                color: "#1a2a44"        // Metin rengi (Çerçeve ile aynı lacivert)
                                font.family: "Montserrat" // Eğer font yüklü değilse Arial veya sans-serif kullanır
                                font.pixelSize: 18
                                font.bold: true         // Kalın yazı tipi
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
            Rectangle {
                id: ikonlumetinliButon
                width: 200
                height: 50
                property bool sesCaliniyor: false
                z: 10  // MultiEffect'ın önünde


                // Pozisyonu manuel ayarla (daireMerkez'e göre)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width / 4  -60 // sağ yarıya kaydır
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 200 // daireden biraz aşağı
                // anchors.top: toplamKutusu.bottom
                color: sesCaliniyor ? (mouseArea.pressed ? '#c12828' : '#ce0e0e') 
                        : (mouseArea.pressed ? "#6da030" : (mouseArea.containsMouse ? "#9cd64f" : "#8ec63f"))
                radius: 20
                scale: pressed ? 0.95 : (hovered ? 1.05 : 1.0)
                Behavior on scale {
                    NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
                }
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
                        text: "Konuyu Dinle"
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
                            appControl.play_sound("carpma_konu.wav")
                        } else {
                            appControl.stop_sound()
                        }
                    }
                }
            }
            Rectangle {
                id: canliDers
                width: 200
                height: 50
                property bool botAktif: false
                z: 10  // MultiEffect'ın önünde


                // Pozisyonu manuel ayarla (daireMerkez'e göre)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width / 4  -60 // sağ yarıya kaydır
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 255 // daireden biraz aşağı
                // anchors.top: toplamKutusu.bottom
                color: botAktif ? (canliButonMouse.pressed ? '#c12828' : '#ce0e0e') 
                        : (canliButonMouse.pressed ? '#3d30a0' : (canliButonMouse.containsMouse ? '#5a4fd6' : '#5c3fc6'))
                radius: 20
                scale: pressed ? 0.95 : (hovered ? 1.05 : 1.0)
                Behavior on scale {
                    NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
                }
                Behavior on color { ColorAnimation { duration: 150 } }
                

                Row {
                    anchors.centerIn: parent
                    spacing: 12
                    Image {
                        source: ASSETS_PATH + "/icons/chatbot.png"
                        width: 30
                        height: 30
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "Canlı Dinle"
                        font.family: "Montserrat"
                        font.pixelSize: 20
                        color: '#ffffff'
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
            

                MouseArea {
                    id: canliButonMouse
                    anchors.fill: parent
                    hoverEnabled: true // containsMouse çalışması için şart
                    onClicked: {
                        
                        
                    }
                }
            }
           Rectangle {
            id: ileriOku
            width: 80
            height: 80
            z: 10
            radius: 40
            color: "#f9f8f3" 
            
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter

            Image {
                source: ASSETS_PATH + "/icons/ileri.png"
                fillMode: Image.PreserveAspectFit
                // EKSİK OLAN: Resmi kutunun içine yay
                anchors.fill: parent 
                anchors.margins: 15
            }

            MouseArea {
                id: ileriButonMouse
                anchors.fill: parent
                hoverEnabled: true 
                // cursorShape eklemek butona tıklandığını hissettirir
                cursorShape: Qt.PointingHandCursor 
                
                onClicked: {
                    console.log("Sayfa geçişi tetiklendi");
                    sayfaYoneticisi.push("matematikSayfa2.qml");
                    appControl.stop_sound()
                }
            }
        }
           
        }
    }
}