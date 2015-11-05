#ifndef FILE_H
#define FILE_H

#include <QObject>
#include <QString>
#include <QSize>

class File : public QObject
{
	Q_OBJECT
	Q_ENUMS(Type)
	Q_PROPERTY(Type type READ getType CONSTANT)
	Q_PROPERTY(QString path READ getPath CONSTANT)
	Q_PROPERTY(QSize size READ getSize CONSTANT)

public:
	enum Type {
		STATIC,
		ANIMATED
	};
	Type getType() const { return type; }
	QString getPath() const { return path; }
	QSize getSize() const { return size; }

	void loadMetadata();

	File() {}
	File(const File& other) : path(other.getPath()) {}
	File(const QString& _path) : path(_path) {}

private:
	QString path;
	Type type;
	QSize size;
	bool metadataLoaded = false;
};

#endif // FILE_H
