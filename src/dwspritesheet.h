#ifndef DWSPRITESHEET_H
#define DWSPRITESHEET_H

#include <QObject>
#include <QUrl>
#include <QStringList>
#include <QMap>
#include <QRectF>
#include <QVector>

class dwSpritesheet : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool valid READ valid CONSTANT)
    Q_PROPERTY(int sequenceCount READ sequenceCount CONSTANT)
    Q_PROPERTY(QUrl textureSource READ textureSource CONSTANT)
    Q_PROPERTY(qreal scale READ scale CONSTANT)

    bool m_valid;

public:
    explicit dwSpritesheet(QUrl source);

    bool valid() const
    {
        return m_valid;
    }

    int sequenceCount() const
    {
        return m_sequences.count();
    }

    struct Frame {
        int frame;
        QRectF sourceRect;
        QSizeF size;
        qreal duration;
    };

    struct Sequence {
        QString name;
        int framecount;
        bool loop;
        QString next;
        QVector<Frame> frames;
    };

    Sequence * sequence(QString sequenceName){ return m_sequences.value(sequenceName, 0); }
    Sequence * sequence(int index){ return sequence(m_sequences.keys()[index]); }
    QUrl textureSource() const
    {
        return m_textureSource;
    }

    qreal scale() const
    {
        return m_scale;
    }

signals:

public slots:

private:

    QMap<QString, Sequence*> m_sequences;

    QUrl m_textureSource;
    qreal m_scale;
};

#endif // DWSPRITESHEET_H
