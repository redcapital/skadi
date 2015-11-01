#include <QDebug>
#include <QFileInfo>
#include <QDir>
#include <QUrl>
#include <QDebug>
#include "filebackend.h"

void FileBackend::setArguments(const QStringList& arguments)
{
	this->files.clear();
	if (!arguments.empty()) {
		QFileInfo info(arguments.at(0));
		reader.setFileName(info.absoluteFilePath());
		if (info.exists() && info.isFile() && reader.canRead()) {
			this->initFromSingleFile(info);
		}
	}
	emit currentFileChanged();
}

bool FileBackend::setArgumentsFromQml(const QVariantList& arguments)
{
	QStringList list;
	for (auto &item : arguments) {
		QUrl url(item.toString());
		if (url.isLocalFile()) {
			list.append(url.toLocalFile());
		}
	}
	if (!list.empty()) {
		this->setArguments(list);
		return true;
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
		files.push_back(std::unique_ptr<File>(new File(entry.absoluteFilePath())));
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
		(*this->currentFile)->loadMetadata();
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
