#include "dwspritesheet.h"

#include "dwutil.h"
#include <QIODevice>

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

dwSpritesheet::dwSpritesheet(QUrl source) : QObject(0)
{
    m_valid = false;

    QIODevice * dev = dwUtil::singleton()->getDeviceFromUrl(source);
    QByteArray data = dev->readAll();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    if(!doc.isObject())
    {
        qDebug("[dwSpritesheet] Could not open spritesheet from JSON:");
        qDebug(data.data());
    }

    //PARSE BEGIN

    QJsonObject root = doc.object();
    m_scale = (qreal) root["scale"].toDouble(1.0);

    QJsonArray seqArray = root["sequences"].toArray();

    foreach(QJsonValue seqval, seqArray)
    {
        QJsonObject seqobj = seqval.toObject();

        if(!seqobj.isEmpty())
        {
            Sequence * seq = new Sequence();

            seq->name = seqobj["name"].toString();
            QString type = seqobj["type"].toString();

            if(type == "strip")
            {
                qreal frameX = m_scale * (qreal) seqobj["frameX"].toDouble();
                qreal frameY = m_scale * (qreal) seqobj["frameY"].toDouble();
                qreal frameW = m_scale * (qreal) seqobj["frameW"].toDouble();
                qreal frameH = m_scale * (qreal) seqobj["frameH"].toDouble();
                qreal frameDuration = (qreal) seqobj["frameDuration"].toDouble();

                int frameCount = seqobj["frameCount"].toInt();

                for (int i = 0; i < frameCount; i++) {

                    seq->frames.push_back(Frame{ i, QRectF(frameX + frameW*i,frameY,frameW,frameH), QSizeF(frameW/m_scale,frameH/m_scale), frameDuration });

                }

                seq->framecount = seq->frames.size();
            }

            if(seq)
                m_sequences[seq->name] = seq;
        }
    }

    /*
    Sequence *seq = new Sequence();
    seq->framecount = 2;
    seq->loop = true;
    seq->name = "ring";
    seq->next = "";

    seq->frames.push_back(Frame{ 0, QRectF(0,0,64,64), QSizeF(16,16), 0.1 });
    seq->frames.push_back(Frame{ 1, QRectF(64,0,64,64), QSizeF(16,16), 0.1 });

    m_sequences[seq->name] = (seq);

    Sequence *seq2 = new Sequence();
    seq2->framecount = 2;
    seq2->loop = true;
    seq2->name = "ring-sparkle";
    seq2->next = "";

    seq2->frames.push_back(Frame{ 0, QRectF(8*64,0,64,64), QSizeF(16,16), 0.05 });
    seq2->frames.push_back(Frame{ 1, QRectF(9*64,0,64,64), QSizeF(16,16), 0.05 });

    m_sequences[seq2->name] = (seq2);
*/

    m_valid = true;

    //PARSE END

    m_textureSource = source.toString().replace(".dws", ".png");

}
