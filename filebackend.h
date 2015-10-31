#ifndef FILEBACKEND_H
#define FILEBACKEND_H

#include <list>
#include <memory>
#include <QObject>
#include <QString>
#include <QImageReader>
#include <QFileInfo>
#include <file.h>

class FileBackend : public QObject
{
	Q_OBJECT
	Q_PROPERTY(File* file READ getCurrentFile NOTIFY currentFileChanged)

private:
	std::list< std::unique_ptr<File> > files;
	std::list< std::unique_ptr<File> >::const_iterator currentFile;
	QImageReader reader;
	void initFromSingleFile(const QFileInfo& file);

public:
	bool setArguments(int argc, char* argv[]);
	Q_INVOKABLE void prev();
	Q_INVOKABLE void next();
	File* getCurrentFile() const;

signals:
	void currentFileChanged();
};

#endif // FILEBACKEND_H
