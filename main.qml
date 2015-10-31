import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import com.github.galymzhan 0.1

ApplicationWindow {
	visible: true
	width: 640
	height: 480
	title: backend.file ? backend.file.path : 'Skadi image viewer'

	Item {
		anchors.fill: parent

		Keys.onPressed: {
			switch (event.key) {
				case (Qt.Key_Right):
					backend.next()
					break
				case (Qt.Key_Left):
					backend.prev()
					break
			}
		}

		Image {
			property bool inUse: backend.file && backend.file.type === File.STATIC
			id: staticImage
			anchors.fill: parent
			focus: true
			fillMode: Image.PreserveAspectFit
			visible: inUse
			source: inUse ? 'file://' + backend.file.path : ''
		}

		AnimatedImage {
			property bool inUse: backend.file && backend.file.type === File.ANIMATED
			id: animatedImage
			anchors.fill: parent
			focus: true
			fillMode: Image.PreserveAspectFit
			visible: inUse
			source: inUse ? 'file://' + backend.file.path : ''
		}

		Text {
			text: 'Loading...'
			anchors.centerIn: parent
			visible: staticImage.status == Image.Loading || animatedImage.status == Image.Loading
		}
	}
}
