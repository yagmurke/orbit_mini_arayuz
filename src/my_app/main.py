import os
import sys

import signal
from PyQt6.QtGui import QGuiApplication, QCursor
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import Qt
from PySide6.QtGui import QGuiApplication
from importlib.resources import files

from my_app.backend.app_control import AppControl
# PyQt5'in yüklü olduğu dizini bulalım
# signal.signal(signal.SIGINT, signal.SIG_DFL)


def main():
    if sys.platform == "win32":
        vlc_path = r"C:\Program Files\VideoLAN\VLC"
        if os.path.exists(vlc_path):
            os.environ["PATH"] = vlc_path + \
                os.pathsep + os.environ.get("PATH", "")
            os.add_dll_directory(vlc_path)
    app = QGuiApplication(sys.argv)
    # app.setOverrideCursor(QCursor(Qt.BlankCursor))
    engine = QQmlApplicationEngine()

    assets_path = files("my_app").joinpath("assets")

    engine.rootContext().setContextProperty(
        "ASSETS_PATH",
        assets_path.as_uri()
    )

    app_control = AppControl()
    engine.rootContext().setContextProperty("appControl", app_control)

    qml_dir = files("my_app").joinpath("qml")
    print(qml_dir)
    engine.load(str(qml_dir / "Main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    window = engine.rootObjects()[0]
    # window.showFullScreen()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
