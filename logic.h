#ifndef LOGIC_H
#define LOGIC_H

#include <QAbstractListModel>
#include <QVector>

class logic: public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString winner READ getWinner WRITE setWinner NOTIFY winnerChanged)
public:
    explicit logic(QObject *parent = 0);

    enum Roles {
        TextRole = Qt::UserRole + 1
    };

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void    buttonPressed(int index);
    Q_INVOKABLE void    repeatPressed();

    bool    cheking();

    QString getWinner() const;
    void setWinner(const QString &winner);

private:
    QVector<QString> vData;
    bool             player;
    QString          m_winner;
signals:
    void winnerChanged();
};

#endif // LOGIC_H
