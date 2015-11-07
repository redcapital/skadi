#ifndef FILEBACKEND_H
#define FILEBACKEND_H

#include <list>
#include <memory>
#include <QObject>
#include <QString>
#include <QImageReader>
#include <QFileInfo>
#include <QStringList>
#include <QVariantList>
#include <file.h>

class FileBackend : public QObject
{
	Q_OBJECT
	Q_ENUMS(Status)
	Q_PROPERTY(File* file READ getCurrentFile NOTIFY currentFileChanged)
	Q_PROPERTY(Status status READ getStatus NOTIFY statusChanged)

public:
	enum Status {
		Empty,
		Loading,
		Ready
	};

	void setArguments(const QStringList& arguments);
	Q_INVOKABLE bool setArgumentsFromQml(const QVariantList& arguments);
	Q_INVOKABLE void prev();
	Q_INVOKABLE void next();
	File* getCurrentFile() const;
	Status getStatus() const;

private:
	std::list< std::unique_ptr<File> > files;
	std::list< std::unique_ptr<File> >::const_iterator currentFile;
	QImageReader reader;
	void initFromSingleFile(const QFileInfo& file);
	Status status = Status::Empty;

signals:
	void currentFileChanged();
	void statusChanged();
};

#endif // FILEBACKEND_H
