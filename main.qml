import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import com.github.galymzhan 0.1

ApplicationWindow {
	visible: true
	width: 640
	height: 480
	title: backend.file ? backend.file.path : 'Skadi image viewer'

	Flickable {
		id: imageView
		anchors.fill: parent
		contentWidth: image.width
		contentHeight: image.height
		boundsBehavior: Flickable.StopAtBounds
		flickableDirection: Flickable.HorizontalAndVerticalFlick

		property real scaleFactor: 1

		function scaleToFit() {
			if (!backend.file) {
				return
			}
			var size = backend.file.size
			scaleFactor = Qt.binding(function() {
				if (size.width <= imageView.width && size.height <= imageView.height) {
					return 1
				}
				return Math.min(imageView.width / size.width, imageView.height / size.height)
			})
		}

		Component.onCompleted: imageView.scaleToFit()

		Connections {
			target: backend
			onFileChanged: imageView.scaleToFit()
		}

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

		AnimatedImage {
			id: image
			focus: true
			fillMode: Image.Stretch
			visible: backend.file
			onStatusChanged: playing = (status == AnimatedImage.Ready)
			source: backend.file ? 'file://' + backend.file.path : ''
			width: backend.file ? backend.file.size.width * imageView.scaleFactor : 0
			height: backend.file ? backend.file.size.height * imageView.scaleFactor : 0
			x: (imageView.width < image.width) ? 0 : (imageView.width - image.width) / 2
			y: (imageView.height < image.height) ? 0 : (imageView.height - image.height) / 2

			MouseArea {
				x: 0
				y: 0
				width: Math.max(imageView.width, image.width)
				height: Math.max(imageView.height, image.height)
				onWheel: {
					if (!backend.file) {
						return
					}
					var newScale = imageView.scaleFactor
					if (wheel.angleDelta.y > 0) {
						newScale += 0.06
						if (newScale * backend.file.size.width < 16000 && newScale * backend.file.size.height < 16000) {
							imageView.scaleFactor = newScale
						}
					} else if (wheel.angleDelta.y < 0) {
						newScale -= 0.06
						if (newScale > 0 && newScale * backend.file.size.width > 10 && newScale * backend.file.size.height > 10) {
							imageView.scaleFactor = newScale
						}
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
}
