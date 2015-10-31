#ifndef QMLENGINE_H
#define QMLENGINE_H

#include <memory>
#include <QQmlApplicationEngine>
#include "filebackend.h"

class QmlEngine : public QQmlApplicationEngine
{
	Q_OBJECT
public:
	void initialize(FileBackend& backend);
};

#endif // QMLENGINE_H
