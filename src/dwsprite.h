#ifndef DWSPRITE_H
#define DWSPRITE_H

#include "dwimageitem.h"

#include <QUrl>

class DWSprite : public dwImageItem
{
    Q_OBJECT
    Q_PROPERTY(QUrl spritesheet READ spritesheet WRITE setSpritesheet NOTIFY spritesheetChanged)
    Q_PROPERTY(QString sequence READ sequence WRITE setSequence NOTIFY sequenceChanged)


public:
    DWSprite(QQuickItem * parent = 0);
    
    QUrl spritesheet() const
    {
        return m_spritesheet;
    }

    QString sequence() const
    {
        return m_sequence;
    }

signals:
    
    void spritesheetChanged(QUrl spritesheet);

    void sequenceChanged(QString sequence);

public slots:
void setSpritesheet(QUrl spritesheet)
{
    if (m_spritesheet == spritesheet)
        return;

    m_spritesheet = spritesheet;
    emit spritesheetChanged(spritesheet);
}
void setSequence(QString sequence)
{
    if (m_sequence == sequence)
        return;

    m_sequence = sequence;
    emit sequenceChanged(sequence);
}

private:

QUrl m_spritesheet;
QString m_sequence;

};

#endif // DWSPRITE_H
