    import QtQuick
    import QtQuick.Window
    import QtQuick.Effects
    import QtQuick.Controls
    import QtMultimedia
    import "../" as TemelBilesenler

    Item{
        visible: true
        width: 800
        height: 800

        Loader {
            anchors.fill: parent
            sourceComponent: matematikPage
        }

        Component{
            id: matematikPage
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

                        Rectangle{
                            anchors.fill: parent
                            color: '#224e8c'
                            opacity: 0.95
                        }
                        
                
                        Text {
                            id: anaBaslik
                            text: "KONU ANLATIMI VİDEOSU"
                            color: '#fafafa'
                            font.family: "Montserrat"
                            font.pixelSize: 25
                            font.bold: true
                                    
                            // 4. KRİTİK NOKTA: Column'ın içinde kendi genişliğine göre ortala
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -300 // daireden biraz aşağı

                            // Görseldeki derinlik için gölge efekti
                            style: Text.Outline
                            styleColor: "#224e8c"
                            z:20 
                        }
                            
                        
                        Rectangle {
                            id: videoKutusu
                            width: 600
                            height: 500
                            color: "#224e8c"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.horizontalCenterOffset: 0
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -60 // daireden biraz aşağı

                            Component.onCompleted: {
                                appControl.trigger_video("carpma-islemi.mp4")
                            }
                            TemelBilesenler.VideoOynatici {
                                id: anaVideoOynatici
                                anchors.fill: parent
                            }
                            Connections{
                                target: appControl
                                function onStartVideo(videoFile){
                                    anaVideoOynatici.source =  ASSETS_PATH + "/videos/" + videoFile
                                    anaVideoOynatici.oynat()
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
                MouseArea {
                    id: videoDenetleyici
                    // Video kutusunun tam üzerini kapla
                    anchors.fill: videoKutusu 
                    // MultiEffect ve butonların en üstünde olduğundan emin olalım
                    z: 20 

                    onClicked: {
                        // Log atarak tıklamanın gelip gelmediğini kontrol edebilirsin
                        
                        
                        if (anaVideoOynatici.oynatici.playbackState === MediaPlayer.PlayingState) {
                            anaVideoOynatici.oynatici.pause()
                        } else {
                            anaVideoOynatici.oynatici.play()
                        }
                    }
                }
            
                // TemelBilesenler.OzelButon {
                //     id: okul_sistemi
                //     butonKonumX: 94
                //     butonKonumY: 545
                //     arkaPlanResmi: ASSETS_PATH + "/icons/okul_sistemi.png"
                //     butonRengi: '#fafafa'
                //     onClicked: {
                //         sayfaYoneticisi.pop("qrc/Main.qml")
                //     }
                //     z:3
                // }
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
                TemelBilesenler.OzelButonKucuk {
                    id: durdur_butonu
                    butonKonumX: 100
                    butonKonumY: 460
                    butonRengi: '#e4e4e4'

                    arkaPlanResmi: (anaVideoOynatici && anaVideoOynatici.oynatici && anaVideoOynatici.oynatici.playbackState === 1) 
                        ? ASSETS_PATH + "/icons/pause.png" 
                        : ASSETS_PATH + "/icons/play.png"

                    onClicked: {
                        if (anaVideoOynatici && anaVideoOynatici.oynatici) {
        
                            // 2. PlaybackState kontrolü: 1 = Playing (Oynuyor)
                            if (anaVideoOynatici.oynatici.playbackState === 1) { 
                                anaVideoOynatici.oynatici.pause();
                                console.log("Video Durduruldu");
                            } else {
                                anaVideoOynatici.oynatici.play();
                                console.log("Video Devam Ediyor");
                            }
                        } else {
                            console.log("Hata: Video nesnesine ulaşılamıyor!");
                        }
                        

                    }
                    z:3
                }

            }
        }
    }