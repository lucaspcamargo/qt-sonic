#include "dwanimationupdater.h"

dwAnimationUpdater * dwAnimationUpdater::ms_singleton = 0;

dwAnimationUpdater::dwAnimationUpdater(QObject *parent) : QObject(parent)
{
    ms_singleton = this;

    enableDomain(FieldDomain);
    enableDomain(UiDomain);
}

void dwAnimationUpdater::update(qreal dt)
{
    foreach(const int d, m_enabledDomains)
    {
       QVector<dwAnimatable*>* anims = animatablesInDomain(d);

       foreach(dwAnimatable *a, *anims)
       {
           a->updateTime(dt);
       }
    }
}
