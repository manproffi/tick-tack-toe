#include "logic.h"
#include <QDebug>

logic::logic(QObject * parent):
    QAbstractListModel(parent),
    vData(9, ""),
    player(true),
    m_winner("")
{
//    qDebug() << Q_FUNC_INFO << player;
}

int logic::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }
    return vData.size();
}

QVariant logic::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }
    switch (role) {
    case TextRole:
        return vData.at(index.row());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> logic::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[TextRole] = "text";
    return roles;
}

void logic::buttonPressed(int i)
{
    if (vData[i] != "" || !m_winner.isEmpty())
        return ;
    if (player) {
        player = false;
        vData[i] = "X";
    }
    else {
        player = true;
        vData[i] = "O";
    }

    QModelIndex start = index(i);
    emit dataChanged(start, start);

    if (cheking()) {
        if (player)
            setWinner("Player 2 won!");
        else
            setWinner("Player 1 won!");
    }
}

void logic::repeatPressed()
{
    player = true;
    beginResetModel();
    for (auto it = vData.begin(); it != vData.end(); ++it) {
        (*it).clear();
    }
    setWinner("");
    endResetModel();
}

bool logic::cheking()
{
    for (int i = 0; i < 7; i += 3) {
        if (vData[i] != "" && vData[i] == vData[i + 1] && vData[i] == vData[i + 2])
            return true;
    }
    for (int i = 0; i < 3; ++i) {
        if (vData[i] != "" && vData[i] == vData[i + 3] && vData[i] == vData[i + 6])
            return true;
    }
    if (vData[0] != "" && vData[0] == vData[4] && vData[0] == vData[8])
        return true;
    if (vData[6] != "" && vData[6] == vData[4] && vData[6] == vData[2])
        return true;
    for (auto it = vData.begin(); it != vData.end(); ++it) {
        if (it->isEmpty())
            return false;
    }
    setWinner("DRAW");
    return false;
}

QString logic::getWinner() const
{
    return m_winner;
}

void logic::setWinner(const QString &winner)
{
    if (m_winner != winner)
    {
        m_winner = winner;
            emit winnerChanged();
    }
}
