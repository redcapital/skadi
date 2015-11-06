import QtQuick 2.0

pragma Singleton

/**
 * Encapsulates app state and provides functions
 */
QtObject {
	id: app
	readonly property string title: backend.file ? backend.file.path : 'skadi image viewer'
	property bool fullScreen: false
	property real scaleFactor: 1
	property var viewport

	function toggleFullScreen() {
		fullScreen = !fullScreen
	}

	function scaleToFit() {
		if (!backend.file || !viewport) {
			return
		}
		var size = backend.file.size
		scaleFactor = Qt.binding(function() {
			if (size.width <= app.viewport.width && size.height <= app.viewport.height) {
				return 1
			}
			return Math.min(app.viewport.width / size.width, app.viewport.height / size.height)
		})
	}

	function zoomIn() {
		var newScale = scaleFactor * 1.2
		if (newScale * backend.file.size.width < 16000 && newScale * backend.file.size.height < 16000) {
			scaleFactor = newScale
		}
	}

	function zoomOut() {
		var newScale = scaleFactor * 0.8
		if (newScale > 0 && newScale * backend.file.size.width > 10 && newScale * backend.file.size.height > 10) {
			scaleFactor = newScale
		}
	}

	function setViewport(newViewport) {
		viewport = newViewport
		scaleFactor = 1
	}
}
