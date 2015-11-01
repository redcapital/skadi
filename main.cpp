#include <QGuiApplication>
#include "filebackend.h"
#include "qmlengine.h"

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);
	QGuiApplication::setApplicationName("skadi");
	QGuiApplication::setApplicationDisplayName("Skadi image viewer");
	QGuiApplication::setOrganizationName("skadi");

	FileBackend backend;
	backend.setArguments(QGuiApplication::arguments());
	QmlEngine engine;
	engine.addImportPath("qrc:/");
	engine.initialize(backend);

	return app.exec();
}
