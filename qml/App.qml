import QtQuick 2.0

pragma Singleton

/**
 * Encapsulates app state and provides functions
 */
QtObject {
	id: app
	readonly property string title: {
		if (!backend.file) {
			return 'skadi image viewer'
		}
		var title = backend.file.path
		if (rotation > 0) {
			title += ', ' + rotation + '°'
		}
		return title
	}

	property bool fullScreen: false
	property bool panelVisible: true
	property real scaleFactor: baseScale * Math.pow(1.2, zoomLevel)
	property real rotation: 0

	// private properties
	property var viewport
	property var aboutDialog
	property real baseScale: 1
	property int zoomLevel: 0

	function toggleFullScreen() {
		fullScreen = !fullScreen
	}

	function fileChanged() {
		rotation = 0
		scaleToFit()
	}

	function scaleToFit() {
		if (!backend.file || !viewport) {
			return
		}
		var size = backend.file.size
		baseScale = Qt.binding(function() {
			if (!app.viewport) {
				return 1
			}
			if (size.width <= app.viewport.width && size.height <= app.viewport.height) {
				return 1
			}
			return Math.min(app.viewport.width / size.width, app.viewport.height / size.height)
		})
		zoomLevel = 0
	}

	function scaleToOriginalSize() {
		baseScale = 1
		zoomLevel = 0
	}

	function zoom(zoomingIn) {
		var newLevel = zoomLevel + (zoomingIn ? 1 : -1)
		var newScale = baseScale * Math.pow(1.2, newLevel)
		if (zoomingIn) {
			if (newScale * backend.file.size.width > 16000 || newScale * backend.file.size.height > 16000) {
				return
			}
		} else {
			if (newScale * backend.file.size.width < 2 || newScale * backend.file.size.height < 2) {
				return
			}
		}
		zoomLevel = newLevel
	}

	function showAbout() {
		aboutDialog.open()
	}

	function closeAbout() {
		aboutDialog.close()
	}

	function setViewport(newViewport) {
		viewport = newViewport
	}

	function setAboutDialog(dialog) {
		aboutDialog = dialog
	}

	function togglePanel() {
		panelVisible = !panelVisible
	}

	function showInFinder() {
		backend.showInFinder()
	}

	function rotateClockwise() {
		rotation = (rotation + 90) % 360
	}

	function rotateCounterClockwise() {
		rotation = (rotation + 270) % 360
	}
}
