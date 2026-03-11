import QtQuick
import QtMultimedia

Item {
    id: root
    property alias source: mediaPlayer.source
    property alias oynatici: mediaPlayer

    function oynat(){
        root.visible = true
        mediaPlayer.play()
    }

    function durdur() {
        root.visible = true
        mediaPlayer.stop()
    }
    width: 700
    height: 600

    MediaPlayer {
        id: mediaPlayer
        videoOutput: videoOutput
        audioOutput: AudioOutput {}

    } 
    VideoOutput{
        id: videoOutput
        anchors.fill: parent

        
    }
}