#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QString>
#include <QCommandLineParser>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    parser.setApplicationDescription("Test Lottie files");
    parser.addHelpOption();
    parser.addPositionalArgument("file", "The Lottie file to display.");
    parser.process(app);

    QString lottieFile;
    if (!parser.positionalArguments().isEmpty()) {
        lottieFile = parser.positionalArguments().at(0);
    } else {
        qWarning("No Lottie file specified. Exiting.");
        //return -1;
    }

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("lottieFile", lottieFile);
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
