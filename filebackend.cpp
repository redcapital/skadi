#include <QDebug>
#include <QFileInfo>
#include <QDir>
#include "filebackend.h"

bool FileBackend::setArguments(int argc, char *argv[])
{
	this->files.clear();
	if (argc > 1) {
		QFileInfo info(argv[1]);
		reader.setFileName(info.absoluteFilePath());
		if (info.exists() && info.isFile() && reader.canRead()) {
			this->initFromSingleFile(info);
			return true;
		}
	}
	return false;
}

void FileBackend::initFromSingleFile(const QFileInfo &file)
{
	bool foundCurrent = false;
	for (const QFileInfo& entry : file.absoluteDir().entryInfoList(QDir::NoFilter, QDir::Name | QDir::LocaleAware)) {
		if (!entry.isFile()) {
			continue;
		}
		reader.setFileName(entry.absoluteFilePath());
		if (!reader.canRead()) {
			// Not an image or file type not supported
			continue;
		}
		File::Type type = reader.supportsAnimation() ? File::ANIMATED : File::STATIC;

		files.push_back(std::unique_ptr<File>(new File(entry.absoluteFilePath(), type)));
		if (!foundCurrent && entry == file) {
			foundCurrent = true;
			auto last = this->files.end();
			last--;
			this->currentFile = last;
		}
	}
	if (!foundCurrent) {
		this->currentFile = this->files.begin();
	}
}

File* FileBackend::getCurrentFile() const
{
	if (!files.empty()) {
		return this->currentFile->get();
	}
	return nullptr;
}

void FileBackend::next()
{
	if (files.size() > 1) {
		this->currentFile++;
		if (this->currentFile == this->files.end()) {
			this->currentFile = this->files.begin();
		}
		emit currentFileChanged();
	}
}

void FileBackend::prev()
{
	if (files.size() > 1) {
		if (this->currentFile == this->files.begin()) {
			this->currentFile = this->files.end();
		}
		this->currentFile--;
		emit currentFileChanged();
	}
}