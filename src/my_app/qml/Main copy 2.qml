import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes 
import "."
import "SoruVerisi.js" as Veri

import "pages"
ApplicationWindow {
    visible: true
    width: 800
    height: 800
    
    property int mevcutSoruIndex: 0
    property var aktifSoru: Veri.sorular[mevcutSoruIndex]
    property int dogruSkor: 0
    property int yanlisSkor: 0
    property bool oyunBitti: false // 10 soru bitince sonucu göstermek için
    property bool quizBasladi: false // Sorular başlamadan önce başlangıç ekranı için
    property int kalanSure: 20
    property int varsayilanSure: 20
    Timer {
        id: soruZamanlayici
        interval: 1000 
        repeat: true
        // Sadece oyun aktifken ve animasyonlar çalışmıyorken sayar [cite: 13, 15, 20]
        running: !oyunBitti && !animasyon.running && !shakeAnimasyonu.running 

        onTriggered: {
            if (kalanSure > 0) {
                kalanSure--;
            } else {
                yanlisSkor++; // Süre biterse yanlış say [cite: 3, 5]
                shakeAnimasyonu.start(); // Soru resmini salla [cite: 20, 27]
            }
        }
    }+

    function cevapKontrolEt(index) {
        if (oyunBitti) return;

        if (index === aktifSoru.dogruCevap) {
            dogruSkor++;
            animasyon.start(); // Doğruysa yeşil tik animasyonu çalışır, bitince sonraki soruya geçer
        } else {
            yanlisSkor++;
            // Yanlışta animasyon beklemek istemiyorsan direkt geçebiliriz
            // Veya kısa bir kırmızı efekt ekleyebiliriz. Şimdilik direkt geçirelim:
            shakeAnimasyonu.start();
        }
    }
    function sonrakiSoruyaGec() {
        kalanSure = varsayilanSure; // Süreyi sıfırla
        zamanCizgisi.update(); // Zaman çizgisini güncelle
        if (mevcutSoruIndex < Veri.sorular.length - 1) {
            mevcutSoruIndex++;
            soruZamanlayici.start(); // Yeni soru için zamanlayıcıyı başlat
        } else {
            oyunBitti = true;
            console.log("Tüm sorular tamamlandı!");
        }
    }
    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"

        Rectangle {
            width: parent.width
            height: parent.height
            color: "white"
            radius: width /2
            anchors.centerIn: parent
            border.color: "#d0d0d0"

            // İçerik alanı
            

            Rectangle {
                id: basariEfekti
                width: 200; height: 200
                color: "#2ecc71" // Yeşil renk
                radius: 100
                anchors.centerIn: parent
                z: 100 // En üstte görünsün
                opacity: 0
                scale: 0

                Text {
                    text: "✔"
                    color: "white"
                    font.pixelSize: 100
                    anchors.centerIn: parent
                }
                

        SequentialAnimation {
            id: animasyon
            // 1. Parlayarak ve büyüyerek gel
            ParallelAnimation {
                NumberAnimation { target: basariEfekti; property: "opacity"; to: 1; duration: 250 }
                NumberAnimation { target: basariEfekti; property: "scale"; to: 1.2; duration: 250; easing.type: Easing.OutBack }
            }
            PauseAnimation { duration: 600 } // Ekranda kalma süresi
            // 2. Küçülerek kaybol
            ParallelAnimation {
                NumberAnimation { target: basariEfekti; property: "opacity"; to: 0; duration: 200 }
                NumberAnimation { target: basariEfekti; property: "scale"; to: 0; duration: 200 }
            }
            // 3. Bittikten sonra sonraki soruya geç
            onFinished: {
                sonrakiSoruyaGec()
            }
        }
        SequentialAnimation {
            id: shakeAnimasyonu
            
            // 1. Sağa git
            NumberAnimation { 
                target: anaSoruResmi; property: "anchors.horizontalCenterOffset"
                to: 20; duration: 200; easing.type: Easing.InOutQuad 
            }
            // 2. Sola git
            NumberAnimation { 
                target: anaSoruResmi; property: "anchors.horizontalCenterOffset"
                to: -20; duration: 200; easing.type: Easing.InOutQuad 
            }
            // 3. Tekrar sağa git
            NumberAnimation { 
                target: anaSoruResmi; property: "anchors.horizontalCenterOffset"
                to: 10; duration: 200; easing.type: Easing.InOutQuad 
            }
            // 4. Merkeze dön (Sıfırla)
            NumberAnimation { 
                target: anaSoruResmi; property: "anchors.horizontalCenterOffset"
                to: 0; duration: 200; easing.type: Easing.InOutQuad 
            }

            // Animasyon biter bitmez beklemeden sonraki soruya geç
            onFinished: {
                sonrakiSoruyaGec()
            }
        }
    }

    // --- ARAYÜZ ---
    Rectangle {
        width: 750; height: 750
        radius: 375
        color: "white"
        anchors.centerIn: parent
        Shape {
            id: zamanCizgisi
            anchors.fill: parent
            z: 1 // Resim ve butonların arkasında kalsın
            
            ShapePath {
                fillColor: "transparent"
                strokeColor: kalanSure < 4 ? "#e74c3c" : '#cf5dad' // Kritik sürede kırmızı olur
                strokeWidth: 10
                capStyle: ShapePath.RoundCap

                PathAngleArc {
                    centerX: 375; centerY: 375
                    radiusX: 365; radiusY: 365 // Dairenin tam iç sınırında
                    startAngle: -90 
                    sweepAngle: (kalanSure / varsayilanSure) * 360
                    Behavior on sweepAngle {
                        NumberAnimation { duration: 150 } 
                    }
                                        
                }
                    }
                }
                
                // Altında Image (Soru Resmi) ve Grid (Butonlar) devam eder... 
        }
        // Üstteki Soru Görseli
        Image {
            id: anaSoruResmi
            source: "../assets/icons/" + aktifSoru.SoruGorseli
            width: 350; height: 250
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Şıklar (Grid)
        Grid {
            columns: 2
            spacing: 20
            anchors.top: anaSoruResmi.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter

            // 4 Buton da veriden besleniyor
            CevapButonu { 
                imageSource: "../assets/icons/" + aktifSoru.secenekler[0]
                onClicked: cevapKontrolEt(0)
            }
            CevapButonu { 
                imageSource: "../assets/icons/" + aktifSoru.secenekler[1]
                onClicked: cevapKontrolEt(1)
            }
            CevapButonu { 
                imageSource: "../assets/icons/" + aktifSoru.secenekler[2]
                onClicked: cevapKontrolEt(2)
            }
            CevapButonu { 
                imageSource: "../assets/icons/" + aktifSoru.secenekler[3]
                onClicked: cevapKontrolEt(3)
            }
        }
    }

    

    // NEXT (SONRAKİ) BUTONU (Sağ Alt)
    Rectangle {
        id: nextButon
        width: 160; height: 50
        color: "#3498db"
        radius: 25
        
        // Köşeye değil, alt merkeze hizalıyoruz
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60 // Dairenin alt kavisinden yukarı çıkardık
        
        visible: !oyunBitti 
        z: 50 // Diğer öğelerin üzerinde kalsın

        Text {
            text: "Sonraki ➡"
            color: "white"
            font.pixelSize: 18
            font.bold: true
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: sonrakiSoruyaGec()
        }
    }
    // Oyun Bittiğinde Görünen Panel - ZENGINLEŞTIRILMIŞ
    Rectangle {
            id: sonucEkrani
            anchors.fill: parent
            radius: parent.radius
            color: "white"
            visible: oyunBitti
            z: 9999

            // Arka plan gradyanı
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                clip: true
                
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#f8f9fa" }
                    GradientStop { position: 0.5; color: "#ffffff" }
                    GradientStop { position: 1.0; color: "#f0f4f8" }
                }
            }

            // Üstte Başarı İkonu - Animasyon ile
            Rectangle {
                id: tamamlanmaIkonu
                width: 120
                height: 120
                radius: 60
                // color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40
                opacity: 0
                scale: 0
                
                SequentialAnimation {
                    running: oyunBitti
                    SequentialAnimation {
                        ParallelAnimation {
                            NumberAnimation { target: tamamlanmaIkonu; property: "opacity"; to: 1; duration: 600; easing.type: Easing.OutCubic }
                            NumberAnimation { target: tamamlanmaIkonu; property: "scale"; to: 1.0; duration: 600; easing.type: Easing.OutBounce }
                        }
                    }
                }
                
                Text {
                    text: ""
                    font.pixelSize: 70
                    anchors.centerIn: parent
                }
            }

            // Ana içerik
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: tamamlanmaIkonu.bottom
                anchors.topMargin: 20
                anchors.bottom: yenidenboslaDugmesi.top
                anchors.bottomMargin: 30
                width: 600
                spacing: 25
                clip: true

                // Başlık
                Text {
                    text: "Tebrikler!"
                    font.pixelSize: 36
                    font.bold: true
                    color: "#2c3e50"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    SequentialAnimation {
                        running: oyunBitti
                        PauseAnimation { duration: 400 }
                        PropertyAnimation { target: parent; property: "opacity"; from: 0; to: 1; duration: 500 }
                    }
                }

                // Puan Kutuları
                Rectangle {
                    width: parent.width
                    height: 160
                    color: "transparent"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    Row {
                        anchors.fill: parent
                        spacing: 20
                        
                        // Doğru Cevaplar Kutusu
                        Rectangle {
                            width: parent.width / 2 - 10
                            height: 160
                            radius: 15
                            color: "#d4edda"
                            border.color: "#28a745"
                            border.width: 2
                            
                            Column {
                                anchors.centerIn: parent
                                spacing: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                                
                                Text {
                                    text: "✅"
                                    font.pixelSize: 40
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                
                                Text {
                                    text: "Doğru"
                                    font.pixelSize: 14
                                    color: "#28a745"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                
                                Text {
                                    text: dogruSkor 
                                    font.pixelSize: 32
                                    font.bold: true
                                    color: "#27ae60"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                        }
                        
                        // Yanlış Cevaplar Kutusu
                        Rectangle {
                            width: parent.width / 2 - 10
                            height: 160
                            radius: 15
                            color: "#f8d7da"
                            border.color: "#dc3545"
                            border.width: 2
                            
                            Column {
                                anchors.centerIn: parent
                                spacing: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                                
                                Text {
                                    text: "❌"
                                    font.pixelSize: 40
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                
                                Text {
                                    text: "Yanlış"
                                    font.pixelSize: 14
                                    color: "#dc3545"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                
                                Text {
                                    text: yanlisSkor 
                                    font.pixelSize: 32
                                    font.bold: true
                                    color: "#c0392b"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                        }
                    }
                }

                // Başarı Yüzdesini Gösteren Çubuk
                Rectangle {
                    width: parent.width - 40
                    height: 40
                    radius: 20
                    color: "#e9ecef"
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.color: "#dee2e6"
                    border.width: 1
                    
                    Rectangle {
                        id: ilerlemeBar
                        height: parent.height
                        radius: 20
                        
                        // toplam cevap sayısı dikkate alınsın
                        property int cevapSayisi: dogruSkor + yanlisSkor
                        
                        color: {
                            var yuzde = cevapSayisi > 0 ? (dogruSkor / cevapSayisi) * 100 : 0;
                            return yuzde >= 70 ? "#28a745" : (yuzde >= 50 ? "#ffc107" : "#dc3545");
                        }
                        width: cevapSayisi > 0 ? (dogruSkor / cevapSayisi) * parent.width : 0
                        
                        Behavior on width {
                            NumberAnimation { duration: 1000; easing.type: Easing.OutCubic }
                        }
                        
                        Text {
                            text: cevapSayisi > 0 ? Math.round((dogruSkor / cevapSayisi) * 100) + "%" : "0%"
                            color: "white"
                            font.pixelSize: 16
                            font.bold: true
                            anchors.centerIn: parent
                        }
                    }
                }

                // Başarı Mesajı (cevap sayısına göre dinamik)
                Text {
                    text: {
                        var cevapSayisi = dogruSkor + yanlisSkor;
                        var basariYuzdesi = cevapSayisi > 0 ? (dogruSkor / cevapSayisi) * 100 : 0;
                        
                        if (basariYuzdesi >= 90) return "Harika! Mükemmel sonuç!";
                        else if (basariYuzdesi >= 70) return "Çok iyi! Başarılı oldun!";
                        else if (basariYuzdesi >= 50) return "Ortalamanın üstünde! Daha iyi yap!";
                        else return "Tekrar dene, gelişeceksin!";
                    }
                    font.pixelSize: 16
                    color: "#555"
                    anchors.horizontalCenter: parent.horizontalCenter
                    wrapMode: Text.WordWrap
                    width: parent.width - 40
                    horizontalAlignment: Text.AlignHCenter
                    
                    SequentialAnimation {
                        running: oyunBitti
                        PauseAnimation { duration: 800 }
                        PropertyAnimation { target: parent; property: "opacity"; from: 0; to: 1; duration: 500 }
                    }
                }
            }

            // Yeniden Başla Butonu
            Rectangle {
                id: yenidenboslaDugmesi
                width: 220
                height: 60
                radius: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#3498db" }
                    GradientStop { position: 1.0; color: "#2980b9" }
                }
                
                DropShadow {
                    anchors.fill: parent
                    source: parent
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 8
                    color: "#00000033"
                }
                
                Text {
                    text: "Yeniden Başla"
                    color: "white"
                    font.pixelSize: 18
                    font.bold: true
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mevcutSoruIndex = 0
                        dogruSkor = 0
                        yanlisSkor = 0
                        oyunBitti = false
                        tamamlanmaIkonu.scale = 0
                        tamamlanmaIkonu.opacity = 0
                    }
                    
                    onPressed: {
                        yenidenboslaDugmesi.scale = 0.95
                    }
                    
                    onReleased: {
                        yenidenboslaDugmesi.scale = 1.0
                    }
                }
                
                Behavior on scale {
                    NumberAnimation { duration: 100 }
                }
            }
        }
        }
       
    }


