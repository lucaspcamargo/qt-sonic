#ifndef DWANIMATABLE_H
#define DWANIMATABLE_H


class dwAnimatable
{

public:
    virtual void updateTime(qreal dt) = 0;
    virtual int domain() = 0;
};

#endif // DWANIMATABLE_H
