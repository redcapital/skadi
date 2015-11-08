import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import com.github.galymzhan 0.1
import '.'

ApplicationWindow {
	visible: true
	width: 800
	height: 600
	title: App.title
	visibility: App.fullScreen ? Window.FullScreen : Window.Windowed

	FontLoader {
		source: 'fontawesome-webfont.woff'
	}

	DropArea {
		anchors.fill: parent
		onDropped: {
			if (drop.hasUrls) {
				var urls = []
				for (var i = 0; i < drop.urls.length; i++) {
					urls.push(drop.urls[i])
				}
				if (backend.setArgumentsFromQml(urls)) {
					drop.accept()
				}
			}
		}
	}

	Connections {
		target: backend
		onFileChanged: App.scaleToFit()
	}

	AboutDialog {}

	ColumnLayout {
		anchors.fill: parent
		spacing: 0

		Viewport {
			visible: backend.status == FileBackend.Ready
			Layout.fillHeight: true
			Layout.fillWidth: true
		}

		Panel {
			id: panel
			anchors.horizontalCenter: parent.horizontalCenter
			Layout.alignment: Qt.AlignBottom
			Layout.topMargin: App.panelVisible ? 10 : 0
			Layout.bottomMargin: App.panelVisible ? 10 : 0
			Layout.maximumHeight: App.panelVisible ? implicitHeight : 0

			Behavior on Layout.maximumHeight {
				NumberAnimation {
					duration: 100
				}
			}
			Behavior on Layout.topMargin {
				NumberAnimation {
					duration: 100
				}
			}
			Behavior on Layout.bottomMargin {
				NumberAnimation {
					duration: 100
				}
			}
		}
	}

	StartScreen {
		anchors.centerIn: parent
		visible: backend.status == FileBackend.Empty
	}
}
