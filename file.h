#ifndef FILE_H
#define FILE_H

#include <QObject>
#include <QString>

class File : public QObject
{
	Q_OBJECT
	Q_ENUMS(Type)
	Q_PROPERTY(Type type READ getType)
	Q_PROPERTY(QString path READ getPath)

public:
	enum Type {
		STATIC,
		ANIMATED
	};
	Type getType() const { return type; }
	QString getPath() const { return path; }

	File() {}
	File(const File& other) : path(other.getPath()), type(other.getType()) {}
	File(const QString& _path, const Type& _type) : path(_path), type(_type) {}

private:
	QString path;
	Type type;
};

#endif // FILE_H
