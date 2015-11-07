import QtQuick 2.0
import '.'

Column {
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
