#include <QApplication>
#include <QPushButton>

int main(int argc, char **argv)
{
    QApplication app (argc, argv);

    QFont font ("Courier");
    //QFont (const Qstring & family, int pointSize = -1, int weight = -1, bool italic = false);

    QPushButton button;
    button.setFont(font);
    button.setText("Snoopz is the greatest ever!");
    button.setToolTip("This shit don't lie");
    button.show();

    return app.exec();

}
