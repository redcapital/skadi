#include "app.h"

App::App(int argc, char* argv[]) :
QGuiApplication(argc, argv)
{
	this->setApplicationName("skadi");
	this->setApplicationDisplayName("Skadi image viewer");
	this->setOrganizationName("skadi");
	this->backend.reset(new FileBackend);
	this->backend->setArguments(argc, argv);
	this->engine.reset(new QmlEngine);
	this->engine->addImportPath("qrc:/");
	this->engine->initialize(*this->backend);
}
