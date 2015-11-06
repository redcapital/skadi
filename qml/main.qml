import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import com.github.galymzhan 0.1
import '.'

ApplicationWindow {
	visible: true
	width: 640
	height: 480
	title: App.title
	visibility: App.fullScreen ? Window.FullScreen : Window.Windowed

	FontLoader {
		source: 'fontawesome-webfont.woff'
	}

	Viewport {
		anchors.fill: parent
		visible: backend.file
	}

	Connections {
		target: backend
		onFileChanged: App.scaleToFit()
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

	Column {
		anchors.centerIn: parent
		visible: !backend.file
		spacing: 20

		Text {
			text: 'Drop an image file, folder or a selection of those here'
			wrapMode: Text.WordWrap
			font.pointSize: 20
		}
		Text {
			anchors.horizontalCenter: parent.horizontalCenter
			font.family: 'FontAwesome'
			font.pointSize: 100
			color: '#bdc3c7'
			text: Awesome.file_image_o
		}
	}
}
