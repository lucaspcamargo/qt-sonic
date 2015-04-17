#include "dweveryframe.h"
#include "dwroot.h"

dwEveryFrame::dwEveryFrame(QObject *parent) :
    QObject(parent),
    m_enabled(true)
{
    changeConnection();
}

void dwEveryFrame::onUpdated(float dt){

    if(m_enabled) emit update(dt);
}

void dwEveryFrame::changeConnection()
{
    if(m_enabled)
        connect(dwRoot::singleton(), &dwRoot::update, this, &dwEveryFrame::onUpdated);
    else
        disconnect(dwRoot::singleton(), &dwRoot::update, this, &dwEveryFrame::onUpdated);

}
