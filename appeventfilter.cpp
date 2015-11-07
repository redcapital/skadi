#include <QFileOpenEvent>
#include "appeventfilter.h"

bool AppEventFilter::eventFilter(QObject *object, QEvent *event)
{
	if (event->type() == QEvent::FileOpen) {
		QFileOpenEvent *e = static_cast<QFileOpenEvent *>(event);
		backend.setArguments(QStringList(e->file()));
		return true;
	}
	return QObject::eventFilter(object, event);
}
