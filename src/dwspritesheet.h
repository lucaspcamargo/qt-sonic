#ifndef DWSPRITESHEET_H
#define DWSPRITESHEET_H

#include <QObject>
#include <QUrl>


class dwSpritesheet : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool valid READ valid CONSTANT)
    Q_PROPERTY(int sequenceCount READ sequenceCount CONSTANT)


    bool m_valid;

    int m_sequenceCount;

public:
    explicit dwSpritesheet(QUrl filename, QObject *parent = 0);

bool valid() const
{
    return m_valid;
}

int sequenceCount() const
{
    return m_sequenceCount;
}

signals:

public slots:
};

#endif // DWSPRITESHEET_H
