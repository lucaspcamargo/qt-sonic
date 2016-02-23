#include "dwspritesheet.h"

dwSpritesheet::dwSpritesheet(QUrl filename, QObject *parent) : QObject(parent)
{

    // set m_valid
    m_valid = false;
}
