

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.5
import QtQuick.Controls 6.5
import QToDo
import QtQuick.Layouts 1.0

Rectangle {
    id: rectangle
    width: 400
    height: 800
    color: "#112715"
    property bool is_dialog_open: false

    Text {
        id: app_title
        color: "#ffffff"
        text: qsTr("QToDo")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 28
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Semibold"
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10
    }

    Button {
        id: add_todo_button
        y: 374
        text: qsTr("Add To Do")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        highlighted: false
        flat: false

        Connections {
            target: add_todo_button
            onClicked: rectangle.is_dialog_open = !rectangle.is_dialog_open
        }
    }

    Rectangle {
        id: add_todo_dialog
        x: 10
        y: 571
        width: 382
        height: 161
        visible: rectangle.is_dialog_open
        color: "#87ca62"
        radius: 30

        TextField {
            id: todo_text_input
            height: 60
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            placeholderText: "Add To Do"
            selectionColor: "#112715"
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            anchors.topMargin: 25
        }

        RowLayout {
            y: 94
            height: 52
            anchors.left: parent.left
            anchors.right: parent.right
            layer.enabled: false
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            spacing: 50
            Button {
                id: cancel_button
                text: qsTr("Cancel")
                Layout.fillWidth: true

                Connections {
                    target: cancel_button
                    onClicked: rectangle.is_dialog_open = false
                }

                Connections {
                    target: cancel_button
                    onClicked: todo_text_input.text = ""
                }
            }

            Button {
                id: add_button
                text: qsTr("Add")
                Layout.fillWidth: true

                Connections {
                    target: add_button
                    onClicked: rectangle.is_dialog_open = false
                }

                Connections {
                    target: add_button
                    onClicked: my_list_model.append(my_list_model.create_list_element())
                }
            }
        }
    }

    Column {
        id: column
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 20
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 100
        anchors.topMargin: 100

        Repeater {
            id: repeater
            anchors.fill: parent

            model: ListModel{
                id: my_list_model
                ListElement {
                    name: "My To Do"
                }
                function create_list_element(){
                    return{
                        "name": todo_text_input.text
                    }
                }
            }

            Rectangle {
                id: todo_item
                y: 0
                width: 340
                height: 60
                visible: true
                color: "#87ca62"
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter

                CheckBox {
                    id: checkBox
                    width: 162
                    visible: true
                    text: name
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    icon.color: "#ffffff"
                    autoRepeat: false
                    autoExclusive: false
                    checked: false
                    tristate: false
                    font.pointSize: 22
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                }
            }
        }
    }
}
