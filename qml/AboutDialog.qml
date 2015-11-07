import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import '.'

Dialog {
	title: 'About skadi'
	modality: Qt.NonModal
	Component.onCompleted: App.setAboutDialog(this)

	contentItem: ColumnLayout {
		TextArea {
			Layout.preferredWidth: 500
			Layout.preferredHeight: 340
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.margins: 3
			textFormat: Text.RichText
			text: aboutContents // set by C++
			readOnly: true
			selectByKeyboard: true
			selectByMouse: true
			onLinkActivated: {
				Qt.openUrlExternally(link)
			}
		}

		Button {
			anchors.horizontalCenter: parent.horizontalCenter
			Layout.bottomMargin: 3
			text: 'Close'
			onClicked: App.closeAbout()
		}
	}
}
