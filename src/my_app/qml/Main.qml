import QtQuick
import QtQuick.Window 
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes 
import "."

import "pages"
ApplicationWindow {
    visible: true
    width: 800
    height: 800

    StackView {
        id: sayfaYoneticisi
        anchors.fill: parent
        initialItem: mainPage
    }


    Component{
        id: mainPage
        Item{
            Image {
                id: background
                anchors.fill: parent
                source: ASSETS_PATH + "/icons/background1.jpeg"
                fillMode: Image.PreserveAspectCrop
                visible: false
            }       
            
            
            Rectangle {
                id: maskeDaire
                width: parent.width 
                height: parent.height
                radius: width /2
                border.color: "#686767"
                anchors.centerIn: parent
                layer.enabled: true
                visible:false
            }
            
            Canvas {
                id: noktaDeseni
                anchors.fill: maskeDaire
                z: 1.5 // Resmin üstünde, turuncu filmin altında
                opacity: 0.6 // Desenin belirginliğini buradan ayarla

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.fillStyle = "#606060"; // Nokta rengi (gri)
                    
                    var aralik = 20; // Noktalar arası mesafe
                    var yaricap = 2; // Nokta büyüklüğü

                    for (var x = aralik/2; x < width; x += aralik) {
                        for (var y = aralik/2; y < height; y += aralik) {
                            ctx.beginPath();
                            ctx.arc(x, y, yaricap, 0, 2 * Math.PI);
                            ctx.fill();
                        }
                    }
                }

                // Nokta deseninin de dairesel görünmesi için maskeliyoruz
                layer.enabled: true
                layer.effect: MultiEffect {
                    maskSource: maskeDaire
                }
            }
            Shape {
            id: solUcgen
            width: 150; height: 150
            x: 50; y: 250 // Konumu zevkine göre ayarla
            z: 2.5
            opacity: 0.6

            ShapePath {
                strokeWidth: 2
                strokeColor: "#fbb040" // Açık turuncu/sarımsı çizgi
                fillColor: "transparent"
                
                // İç içe geçmiş çizgiler efekti için başlangıç
                startX: 0; startY: 75
                PathLine { x: 150; y: 0 }
                PathLine { x: 150; y: 150 }
                PathLine { x: 0; y: 75 }
            }
        }
        MultiEffect {
                anchors.fill: maskeDaire
                source: background
                maskSource: maskeDaire
                maskEnabled: true
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0

                z:1
            }
        // 2. SAĞDAKİ İÇ İÇE ÜÇGENLER (Görseldeki gibi)
        Item {
            id: sagUcgenGrubu
            width: 120; height: 120
            x: 600; y: 200
            z: 2.5
            opacity: 0.5

            // Döngü ile iç içe 3-4 tane üçgen çizerek o "çizgili" efekti veriyoruz
            Repeater {
                model: 3
                Shape {
                    anchors.fill: parent
                    anchors.margins: index * 10 // Her birini 10px içeri büzer
                    ShapePath {
                        strokeWidth: 1.5
                        strokeColor: "white"
                        fillColor: "transparent"
                        startX: width; startY: height / 2
                        PathLine { x: 0; y: 0 }
                        PathLine { x: 0; y: height }
                        PathLine { x: width; y: height / 2 }
                    }
                }
            }
        }
        Rectangle{
            anchors.fill: maskeDaire
            color: '#e06d2c'
            width: maskeDaire.width -50
            height: maskeDaire.height -50
            radius: width /2
            anchors.centerIn: maskeDaire
            opacity: 0.8
            z:2

        }

        OzelButon {
            id: derslerim
            butonKonumX: 80
            butonKonumY: 300
            arkaPlanResmi: ASSETS_PATH + "/icons/derslerim.png"
            butonRengi: "#fcb040"
            onClicked:{
                sayfaYoneticisi.push("pages/Derslerim.qml")
            }
            z:3
        }
        OzelButon {
            id: odevlerim
            butonKonumX: 230
            butonKonumY: 170
            arkaPlanResmi: ASSETS_PATH + "/icons/odevlerim.png"
            butonRengi: "#27aae2"
            onClicked:{
                sayfaYoneticisi.push("pages/Odevlerim.qml")
            }
            z:3
        }
        OzelButon {
            id: ogretmenim
            butonKonumX: 410
            butonKonumY: 170
            arkaPlanResmi: ASSETS_PATH + "/icons/ogretmenim.png"
            butonRengi: "#00a99f"
            onClicked: {
                sayfaYoneticisi.push("pages/OgretmenSayfasi.qml")
            }
            z:3
        }
        OzelButon {
            id: ders_programi
            butonKonumX: 560
            butonKonumY: 300
            arkaPlanResmi: ASSETS_PATH + "/icons/ders_programi.png"
            butonRengi: "#92278f"
            onClicked: {
                sayfaYoneticisi.push("pages/DersProgrami.qml")
            }
            z:3
        }
        OzelButon {
            id: okul_sistemi
            butonKonumX: 320
            butonKonumY: 320
            arkaPlanResmi: ASSETS_PATH + "/icons/okul_sistemi.png"
            butonRengi: '#fafafa'
            z:3
        }
        }
        
        
    }
        

}


