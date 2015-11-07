import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import '.'

Button {
	text: Awesome.file_image_o
	style: ButtonStyle {
		background: Rectangle {
			implicitWidth: 30
			implicitHeight: 30
			visible: control.hovered
			color: '#34495e'
		}
		label: Text {
			color: {
				if (!control.enabled) {
					return '#bdc3c7'
				}
				return control.hovered ? '#fff' : '#34495e'
			}

			font.family: 'FontAwesome'
			font.pointSize: 20
			text: control.text
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
	}
}

