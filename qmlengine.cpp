#include <QQmlContext>
#include <QQmlEngine>
#include <QtQml>
#include <QUrl>
#include <QFile>
#include <QString>
#include <QTextStream>
#include "qmlengine.h"
#include "file.h"

void QmlEngine::initialize(FileBackend &backend)
{
#ifdef QT_DEBUG
	this->rootContext()->setContextProperty("DEBUG", true);
#else
	this->rootContext()->setContextProperty("DEBUG", false);
#endif
	QString aboutContents;
	QFile about(":/about.html");
	if (about.open(QIODevice::ReadOnly | QIODevice::Text)) {
		QTextStream in(&about);
		aboutContents = in.readAll();
	}
	this->rootContext()->setContextProperty("aboutContents", aboutContents);
	this->rootContext()->setContextProperty("backend", &backend);
	qmlRegisterType<File>("com.github.galymzhan", 0, 1, "File");
	qmlRegisterType<FileBackend>("com.github.galymzhan", 0, 1, "FileBackend");
	this->load(QUrl("qrc:/main.qml"));
}
