#ifndef NSOUNDSTREAMERPLAYLIST_H
#define NSOUNDSTREAMERPLAYLIST_H

#include <QObject>
#include <QList>

class nSoundStream;

typedef struct _nSoundStreamerItem
{
    nSoundStream * m_soundStream;
    bool m_loop;
} nSoundSteamerItem;

class nSoundStreamerPlaylist : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool loopPlaylist READ loopPlaylist WRITE setLoopPlaylist)
public:
    explicit nSoundStreamerPlaylist(QObject *parent = 0);
    virtual ~nSoundStreamerPlaylist();

    void createItem(nSoundStream * stream, bool loop);
    nSoundSteamerItem item(int index);
    void clearItems();

    bool loopPlaylist(){return m_loopPlaylist;}
    void setLoopPlaylist(bool b){m_loopPlaylist = b;}

    QList<nSoundSteamerItem> m_items;
signals:

public slots:

private:
    bool m_loopPlaylist;

};

#endif // NSOUNDSTREAMERPLAYLIST_H
