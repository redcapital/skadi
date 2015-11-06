TEMPLATE = app

QT += qml quick widgets svg

CONFIG += c++11

SOURCES += main.cpp \
	qmlengine.cpp \
	filebackend.cpp \
	file.cpp

HEADERS += \
	qmlengine.h \
	filebackend.h \
	file.h

RESOURCES += qml/qml.qrc

ICON = skadi.icns

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml/

# Default rules for deployment.
include(deployment.pri)
