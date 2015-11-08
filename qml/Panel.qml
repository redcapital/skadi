import QtQuick 2.0
import com.github.galymzhan 0.1
import '.'

Row {
	spacing: 5

	PanelButton {
		text: Awesome.arrow_left
		tooltip: 'Previous file'
		hotkey: '←,H'
		enabled: backend.status == FileBackend.Ready
		onClicked: backend.prev()
	}
	PanelButton {
		text: Awesome.arrow_right
		tooltip: 'Next file'
		hotkey: '→,L'
		enabled: backend.status == FileBackend.Ready
		onClicked: backend.next()
	}

	PanelSeparator {}

	PanelButton {
		text: Awesome.arrows_alt
		tooltip: 'Scale to fit the window'
		hotkey: 'I'
		enabled: backend.status == FileBackend.Ready
		onClicked: App.scaleToFit()
	}
	PanelButton {
		text: Awesome.search
		tooltip: 'Show in original size'
		hotkey: 'O,0'
		enabled: backend.status == FileBackend.Ready
		onClicked: App.scaleToOriginalSize()
	}
	PanelButton {
		text: Awesome.search_minus
		tooltip: 'Zoom out'
		hotkey: '-'
		enabled: backend.status == FileBackend.Ready
		onClicked: App.zoom(false)
	}
	PanelButton {
		text: Awesome.search_plus
		tooltip: 'Zoom in'
		hotkey: '+'
		enabled: backend.status == FileBackend.Ready
		onClicked: App.zoom(true)
	}

	PanelSeparator {}

	PanelButton {
		text: Awesome.desktop
		tooltip: 'Toggle full screen mode'
		hotkey: 'F'
		onClicked: App.toggleFullScreen()
	}
	PanelButton {
		text: Awesome.angle_double_down
		tooltip: 'Toggle panel visibility'
		hotkey: 'P'
		onClicked: App.togglePanel()
	}
	PanelButton {
		text: Awesome.question
		onClicked: App.showAbout()
	}
}
