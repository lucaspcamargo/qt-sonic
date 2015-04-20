#include "dwfieldobject.h"

dwFieldObject::dwFieldObject(QQuickItem *parent)
    : QQuickItem( parent ),
      m_managerId( -1 ),
      m_active( true ),
      m_autoVisibility( true )
{
    m_sizeMatters = false;
    m_rotationMatters = false;
}

dwFieldObject::~dwFieldObject()
{

}

