import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import '.'

Button {
	property string tooltip
	property string hotkey
	text: Awesome.file_image_o
	style: ButtonStyle {
		background: Rectangle {
			implicitWidth: 30
			implicitHeight: 30
			visible: control.hovered
			color: '#34495e'

			Rectangle {
				visible: control.tooltip !== '' || control.hotkey !== ''
				anchors.bottom: parent.top
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottomMargin: 5
				implicitWidth: tooltipText.implicitWidth + 10
				implicitHeight: tooltipText.implicitHeight + 10
				border.color: '#34495e'
				color: '#eee'
				Text {
					id: tooltipText
					anchors.centerIn: parent
					font.pointSize: 11
					textFormat: Text.StyledText
					text: {
						var txt = ''
						if (control.tooltip) {
							txt += control.tooltip
						}
						if (control.hotkey) {
							if (txt) {
								txt += '<br>'
							}
							txt += 'Hotkey: <b>' + control.hotkey + '</b>'
						}
						return txt
					}
				}
			}
		}
		label: Text {
			color: {
				if (!control.enabled) {
					return '#bdc3c7'
				}
				return control.hovered ? '#eee' : '#34495e'
			}
			font.family: 'FontAwesome'
			font.pointSize: 20
			text: control.text
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
	}
}

