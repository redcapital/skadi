#include <QGuiApplication>
#include "filebackend.h"
#include "qmlengine.h"
#include "appeventfilter.h"

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);
	app.setApplicationName("skadi");
	app.setApplicationDisplayName("skadi image viewer");
	app.setOrganizationName("skadi");
	app.setOrganizationDomain("redcapital.github.com");

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
