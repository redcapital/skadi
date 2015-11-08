import QtQuick 2.0
import '.'

Item {
	id: viewport
	focus: true

	Component.onCompleted: App.setViewport(viewport)

	Flickable {
		anchors.fill: parent
		contentWidth: image.width
		contentHeight: image.height
		boundsBehavior: Flickable.StopAtBounds
		flickableDirection: Flickable.HorizontalAndVerticalFlick
		clip: true

		AnimatedImage {
			id: image
			asynchronous: true
			fillMode: Image.Stretch
			onStatusChanged: playing = (status == AnimatedImage.Ready)
			source: backend.file ? 'file://' + backend.file.path : ''
			width: backend.file ? backend.file.size.width * App.scaleFactor : 0
			height: backend.file ? backend.file.size.height * App.scaleFactor : 0
			x: (viewport.width < image.width) ? 0 : (viewport.width - image.width) / 2
			y: (viewport.height < image.height) ? 0 : (viewport.height - image.height) / 2

			MouseArea {
				x: 0
				y: 0
				width: Math.max(viewport.width, image.width)
				height: Math.max(viewport.height, image.height)
				onWheel: {
					if (wheel.angleDelta.y > 0) {
						App.zoom(true)
					} else if (wheel.angleDelta.y < 0) {
						App.zoom(false)
					}
				}
			}
		}
	}

	Text {
		text: 'Loading...'
		anchors.centerIn: parent
		visible: image.status == Image.Loading
	}

	Keys.onPressed: {
		switch (event.key) {
			case (Qt.Key_Right):
			case (Qt.Key_L):
				backend.next()
				break
			case (Qt.Key_Left):
			case (Qt.Key_H):
				backend.prev()
				break
			case (Qt.Key_F):
				App.toggleFullScreen()
				break
			case (Qt.Key_I):
				App.scaleToFit()
				break
			case (Qt.Key_0):
			case (Qt.Key_O):
				App.scaleToOriginalSize()
				break
			case (Qt.Key_Plus):
				App.zoom(true)
				break
			case (Qt.Key_Minus):
				App.zoom(false)
				break
			case (Qt.Key_P):
				App.togglePanel()
				break
		}
	}
}
