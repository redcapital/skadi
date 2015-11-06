import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import com.github.galymzhan 0.1
import '.'

ApplicationWindow {
	property bool fullScreen: false

	id: appWindow
	visible: true
	width: 640
	height: 480
	title: backend.file ? backend.file.path : 'skadi image viewer'
	visibility: fullScreen ? Window.FullScreen : Window.Windowed

	FontLoader {
		source: 'fontawesome-webfont.woff'
	}

	Flickable {
		id: imageView
		visible: backend.file
		focus: true
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

		AnimatedImage {
			id: image
			asynchronous: true
			fillMode: Image.Stretch
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

		Keys.onPressed: {
			switch (event.key) {
				case (Qt.Key_Right):
					backend.next()
					break
				case (Qt.Key_Left):
					backend.prev()
					break
				case (Qt.Key_F):
					appWindow.fullScreen = !appWindow.fullScreen
					break
			}
		}
	}

	Text {
		text: 'Loading...'
		anchors.centerIn: parent
		visible: image.status == Image.Loading
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
