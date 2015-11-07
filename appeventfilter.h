#ifndef APPEVENTFILTER_H
#define APPEVENTFILTER_H

#include <QObject>
#include <QEvent>
#include "filebackend.h"

class AppEventFilter : public QObject
{
	Q_OBJECT
public:
	AppEventFilter(FileBackend& _backend) : backend(_backend) {}
protected:
	bool eventFilter(QObject *object, QEvent *event);
private:
	FileBackend& backend;
};

#endif // APPEVENTFILTER_H
