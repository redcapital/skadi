import QtQuick 2.0
import com.github.galymzhan 0.1
import '.'

Row {
	spacing: 5

	PanelButton {
		text: Awesome.arrow_left
		enabled: backend.status == FileBackend.Ready
		onClicked: backend.prev()
	}
	PanelButton {
		text: Awesome.arrow_right
		enabled: backend.status == FileBackend.Ready
		onClicked: backend.next()
	}
	PanelButton {
		text: Awesome.arrows_alt
		enabled: backend.status == FileBackend.Ready
		onClicked: App.scaleToFit()
	}
	PanelButton {
		text: Awesome.search
		enabled: backend.status == FileBackend.Ready
		onClicked: App.scaleToOriginalSize()
	}
	PanelButton {
		text: Awesome.search_minus
		enabled: backend.status == FileBackend.Ready
		onClicked: App.zoom(false)
	}
	PanelButton {
		text: Awesome.search_plus
		enabled: backend.status == FileBackend.Ready
		onClicked: App.zoom(true)
	}
	PanelButton {
		text: Awesome.desktop
		onClicked: App.toggleFullScreen()
	}
}
