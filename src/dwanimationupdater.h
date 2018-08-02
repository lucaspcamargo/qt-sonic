#ifndef DWANIMATIONUPDATER_H
#define DWANIMATIONUPDATER_H

#include <QObject>
#include <QMap>
#include <QVector>
#include <QSet>

#include "dwanimatable.h"

class dwAnimationUpdater : public QObject
{
    Q_OBJECT
    Q_ENUMS(Domains)
public:

    enum Domains {
        FieldDomain = 0x01,
        UiDomain    = 0x02,
        OtherDomain = 0x04
    };

    explicit dwAnimationUpdater(QObject *parent = 0);

    inline static dwAnimationUpdater * singleton(){ return ms_singleton; }

    QVector<dwAnimatable*>* animatablesInDomain(int d)
    {
        QVector<dwAnimatable*> *animatables = m_animatables.value(d, 0);
        if(!animatables)
        {
            animatables = new QVector<dwAnimatable*>();
            m_animatables[d]  =  animatables;
            m_domainFactor[d] = 1.0;
        }
        return animatables;
    }




signals:

public slots:
    void registerAnimatable(dwAnimatable * a)
    {
        Q_ASSERT(a);
        animatablesInDomain(a->domain())->push_back(a);
    }

    void unregisterAnimatable(dwAnimatable * a)
    {
        Q_ASSERT(a);
        animatablesInDomain(a->domain())->removeOne(a);
    }

    void enableDomain(int i)
    {
        m_enabledDomains.insert(i);
    }

    void disableDomain(int i)
    {
        m_enabledDomains.remove(i);
    }

    qreal domainTimeFactor(int i) const
    {
        return m_domainFactor.value(i, 1.0);
    }

    void setDomainTimeFactor(int i, qreal fac)
    {
        m_domainFactor[i] = fac;
    }


    void update(qreal dt);

private:
    static dwAnimationUpdater * ms_singleton;

    QMap<int, QVector<dwAnimatable*>*> m_animatables;
    QMap<int, qreal> m_domainFactor;
    QSet<int> m_enabledDomains;

};

#endif // DWANIMATIONUPDATER_H
