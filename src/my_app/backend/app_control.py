from importlib.resources import files
import json
import pygame
import threading
from PyQt6.QtCore import QObject, pyqtSlot, pyqtSignal, pyqtProperty

LESSONS_PATH = files("my_app").joinpath("data/lessons.json")
AUDIO_PATH = files("my_app").joinpath("assets/audios")
VIDEO_PATH = files("my_app").joinpath("assets/videos")


class AppControl(QObject):
    lesson_changed = pyqtSignal()
    startVideo = pyqtSignal(str)
    videoFinished = pyqtSignal()

    def __init__(self):
        super().__init__()
        self._data = {}
        self.load_lessons()

    def load_lessons(self):
        with open(LESSONS_PATH, "r") as f:
            self._data = json.load(f)
        self.lesson_changed.emit()

    @pyqtProperty("QVariantMap", notify=lesson_changed)
    def lessons(self):
        return self._data

    @pyqtSlot(str)
    def play_sound(self, sound_file):
        pygame.mixer.init()
        sound = pygame.mixer.Sound(AUDIO_PATH.joinpath(sound_file))
        sound.play()

    @pyqtSlot()
    def stop_sound(self):
        if pygame.mixer.get_init():  # ← önce başlatılmış mı kontrol et
            pygame.mixer.stop()

    @pyqtSlot(str)
    def trigger_video(self, video_file):
        self.stop_sound()
        self.startVideo.emit(video_file)
