#include "nSoundStreamerPlaylist.h"

nSoundStreamerPlaylist::nSoundStreamerPlaylist(QObject *parent) :
    QObject(parent)
{
}

nSoundStreamerPlaylist::~nSoundStreamerPlaylist()
{
}

void nSoundStreamerPlaylist::createItem(nSoundStream * stream, bool loop)
{
    nSoundSteamerItem item;
    item.m_soundStream = stream;
    item.m_loop = loop;
    m_items.append(item);
}

nSoundSteamerItem nSoundStreamerPlaylist::item(int index)
{
    return m_items[index];
}

void nSoundStreamerPlaylist::clearItems()
{
    m_items.clear();
}
