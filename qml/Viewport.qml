import QtQuick 2.0
import '.'

Item {
	property real scaleFactor: 1
	id: viewport
	focus: true

	Component.onCompleted: App.setViewport(viewport)

	Flickable {
		anchors.fill: parent
		contentWidth: image.width
		contentHeight: image.height
		boundsBehavior: Flickable.StopAtBounds
		flickableDirection: Flickable.HorizontalAndVerticalFlick

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
				backend.next()
				break
			case (Qt.Key_Left):
				backend.prev()
				break
			case (Qt.Key_F):
				App.toggleFullScreen()
				break
			case (Qt.Key_0):
				App.scaleToOriginalSize()
		}
	}
}
