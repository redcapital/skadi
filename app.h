#ifndef APP_H
#define APP_H

#include <memory>
#include <QGuiApplication>
#include "qmlengine.h"
#include "filebackend.h"

class App : public QGuiApplication
{
	Q_OBJECT
private:
	std::unique_ptr<QmlEngine> engine;
	std::unique_ptr<FileBackend> backend;

public:
	App(int argc, char* argv[]);
	QmlEngine& getQmlEngine() const { return *this->engine; }
	static App* instance() { return static_cast<App*>(QCoreApplication::instance()); }
};

#endif // APP_H
