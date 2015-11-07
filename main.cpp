#include <QGuiApplication>
#include "filebackend.h"
#include "qmlengine.h"
#include "appeventfilter.h"

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);
	QGuiApplication::setApplicationName("skadi");
	QGuiApplication::setApplicationDisplayName("skadi image viewer");
	QGuiApplication::setOrganizationName("skadi");

	FileBackend backend;
	AppEventFilter filter(backend);
	app.installEventFilter(&filter);
	QmlEngine engine;
	engine.addImportPath("qrc:/");
	engine.initialize(backend);

	QStringList arguments = QGuiApplication::arguments();
	if (arguments.size() > 1) {
		arguments.removeFirst();
		backend.setArguments(arguments);
	}

	return app.exec();
}
