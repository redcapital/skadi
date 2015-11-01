#include <QImage>
#include <QImageReader>
#include "file.h"

void File::loadMetadata()
{
	if (this->metadataLoaded) {
		return;
	}
	this->metadataLoaded = true;
	QImageReader reader(this->path);
	this->type = reader.supportsAnimation() ? File::ANIMATED : File::STATIC;
	QImage img;
	reader.read(&img);
	this->size = img.size();
}
