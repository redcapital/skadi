import QtQuick 2.0

pragma Singleton

/**
 * Encapsulates app state and provides functions
 */
QtObject {
	id: app
	readonly property string title: backend.file ? backend.file.path : 'skadi image viewer'
	property bool fullScreen: false
	property bool panelVisible: true
	property real scaleFactor: baseScale * Math.pow(1.2, zoomLevel)

	// private properties
	property var viewport
	property var aboutDialog
	property real baseScale: 1
	property int zoomLevel: 0

	function toggleFullScreen() {
		fullScreen = !fullScreen
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
}
