import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.DownloadManager 0.1
import Ubuntu.Content 1.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "contenthub-savefile.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    Page {
        id: page
        title: i18n.tr("contenthub-savefile")

        Component {
            id: downloadDialog
            ContentSaveDialog { }
        }

        SingleDownload {
            id: downloader
            autoStart: false
            onDownloadIdChanged: {
                PopupUtils.open( downloadDialog, page, {"contentType" : ContentType.Pictures,
                                    "downloadId" : downloadId } )
            }

            onFinished: {
                print("download finished! saved path: " + path);
            }
        }


        Column {
            anchors.centerIn: parent
            spacing: units.gu(1)

            Image {
                id: image
                source: "images/sample.jpg"
                width: page.width/2
                height: page.height/2
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Save"
                onClicked: {
                    console.log("image source: " + image.source);
                    downloader.download(image.source)
                }
            }
        }
    }
}

