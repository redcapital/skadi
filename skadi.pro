TEMPLATE = app

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp \
	qmlengine.cpp \
	filebackend.cpp \
    file.cpp

HEADERS += \
	qmlengine.h \
	filebackend.h \
	file.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
