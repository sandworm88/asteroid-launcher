/*
 * Copyright (C) 2022 - Timo Könnecke <github.com/eLtMosen>
 *               2022 - Darrel Griët <dgriet@gmail.com>
 *               2022 - Ed Beroset <github.com/beroset>
 *               2016 - Sylvia van Os <iamsylvie@openmailbox.org>
 *               2015 - Florent Revest <revestflo@gmail.com>
 *               2014 - Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * All rights reserved.
 *
 * You may use this file under the terms of BSD license as follows:
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the author nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick 2.15
import QtQuick.Shapes 1.15
import QtGraphicalEffects 1.15
import org.asteroid.controls 1.0
import org.asteroid.utils 1.0
import Nemo.Mce 1.0

Item {
    id: rootitem

    anchors.centerIn: parent

    width: parent.width * (dockMode.active ? .88 : 1)
    height: width

    function prepareContext(ctx) {
        ctx.reset()
        ctx.fillStyle = "white"
        ctx.textAlign = "center"
        ctx.textBaseline = 'middle';
        ctx.shadowColor = "black"
        ctx.shadowOffsetX = 0
        ctx.shadowOffsetY = 0
        ctx.shadowBlur = parent.height * .0125
    }

    Text {
        function generateTimeEn(time) {
            var minutesList = ["'o clock", "<b>five</b><br>past", "<b>ten</b><br>past", "<b>quarter</b><br>past", "<b>twenty</b>", "twenty<br>five", "<b>thirty</b>", "thirty<br>five", "<b>fourty</b>", "<b>quarter</b><br>to", "<b>ten</b><br>to", "<b>five</b><br>to", "'o clock"]
            var hoursList = ["<b>twelve</b>", "<b>one</b>", "<b>two</b>", "<b>three</b>", "<b>four</b>", "<b>five</b>", "<b>six</b>", "<b>seven</b>", "<b>eight</b>", "<b>nine</b>", "<b>ten</b>", "<b>eleven</b>"]
            var minutesFirst = [false, true, true, true, false, false, false, false, false, true, true, true, false]
            var nextHour = [false, false, false, false, false, false, false, false, false, true, true, true, true]

            var minutes = Math.round(time.getMinutes() / 5)
            var hours = (time.getHours() + (nextHour[minutes] ? 1 : 0)) % 12

            var start = "<p style=\"text-align:center\">"
            var newline = "<br>"
            var end = "</p>"

            if (minutesFirst[minutes]) {
                var generatedString = minutesList[minutes].toUpperCase() + newline + hoursList[hours].toUpperCase()
            } else {
                var generatedString = hoursList[hours].toUpperCase() + newline + minutesList[minutes].toUpperCase()
            }

            return start + generatedString + end
        }

        function generateTimeEs(time) {
            var minutesList = ["en punto", "<b>cinco</b>", "<b>diez</b>", "<b>cuarto</b>", "<b>veinte</b>", "veinticinco", "<b>media</b>", "veinticinco", "<b>veinte</b>", "<b>cuarto</b>", "<b>diez</b>", "<b>cinco</b>", "en punto"]
            var hoursList = ["<b>doce</b>", "<b>una</b>", "<b>dos</b>", "<b>tres</b>", "<b>cuatro</b>", "<b>cinco</b>", "<b>seis</b>", "<b>siete</b>", "<b>ocho</b>", "<b>nueve</b>", "<b>diez</b>", "<b>once</b>"]
            var hoursListy = ["<b>doce</b> y", "<b>una</b> y", "<b>dos</b> y", "<b>tres</b> y", "<b>cuatro</b> y", "<b>cinco</b> y", "<b>seis</b> y", "<b>siete</b> y", "<b>ocho</b> y", "<b>nueve</b> y", "<b>diez</b> y", "<b>once</b> y"]
            var hoursListmenos = ["<b>doce</b><br>menos", "<b>una</b><br>menos", "<b>dos</b><br>menos", "<b>tres</b><br>menos", "<b>cuatro</b><br>menos", "<b>cinco</b><br>menos", "<b>seis</b><br>menos", "<b>siete</b><br>menos", "<b>ocho</b><br>menos", "<b>nueve</b><br>menos", "<b>diez</b><br>menos", "<b>once</b><br>menos"]
            var nextHour = [false, false, false, false, false, false, false, true, true, true, true, true, true]
            var enPunto = [true, false, false, false, false, false, false, false, false, false, false, false, true]
            var minutes = Math.round(time.getMinutes() / 5)
            var hours = (time.getHours() + (nextHour[minutes] ? 1 : 0)) % 12

            var start = "<p style=\"text-align:center\">"
            var newline = "<br>"
            var end = "</p>"
            if (enPunto[minutes]) {
                var generatedString = hoursList[hours].toUpperCase() + newline + minutesList[minutes].toUpperCase()
            } else {
                //also use next hour to decide between y or menos
                if (nextHour[minutes]) {
                    var generatedString = hoursListmenos[hours].toUpperCase() + newline + minutesList[minutes].toUpperCase()
                } else {
                    var generatedString = hoursListy[hours].toUpperCase() + newline + minutesList[minutes].toUpperCase()
                }
            }
            return start + generatedString + end
        }

        function generateTimeDe(time) {
            var nextHour   = [false, false, false, false, false, true, true, true, true, true, true, true, true]
            var minutes = Math.round(time.getMinutes() / 5)
            var hours = (time.getHours() + (nextHour[minutes] ? 1 : 0)) % 12

            var minutesList = ["UHR", "<b>fünf</b><br>nach", "<b>zehn</b><br>nach", "<b>viertel</b><br>nach", "<b>zwanzig</b><br>nach", "<b>fünf</b><br> vor halb", "<b>halb</b>", "<b>fünf</b><br> nach halb", "<b>zwanzig</b><br>vor", "<b>viertel</b><br>vor", "<b>zehn</b><br>vor", "<b>fünf</b><br>vor", "UHR"]
            var hoursList = ["<b>zwölf</b>", minutesList[minutes] === "UHR" ? "<b>ein</b>" : "<b>eins</b>", "<b>zwei</b>", "<b>drei</b>", "<b>vier</b>", "<b>fünf</b>", "<b>sechs</b>", "<b>sieben</b>", "<b>acht</b>", "<b>neun</b>", "<b>zehn</b>", "<b>elf</b>"]
            var minutesFirst = [false, true, true, true, true, true, true, true, true, true, true, true, false]
            var hourSuffix = [false, false, false, false ,false, false, false, false, false, false, false, false, false]



            var start = "<p style=\"text-align:center\">"
            var newline = "<br>"
            var end = "</p>"

            if (hourSuffix[minutes]) {
                if (minutesFirst[minutes]) {
                    var generatedString = minutesList[minutes].toUpperCase() + newline + hoursList[hours].toUpperCase() +" UHR"
                } else {
                    var generatedString = hoursList[hours].toUpperCase()+ newline + " UHR" + newline + minutesList[minutes].toUpperCase()}
            } else {

                    if (minutesFirst[minutes]) {
                        var generatedString = minutesList[minutes].toUpperCase() + newline + hoursList[hours].toUpperCase()
                    } else {
                        var generatedString = hoursList[hours].toUpperCase() + newline + minutesList[minutes].toUpperCase()
                    }

            }
            return start + generatedString + end
        }

        function generateTimeFr(time) {
            var minutesList = ["heures<br>pile", "heures<br><b>cinq</b>", "heures<br><b>dix</b>", "heures<br>et <b>quart</b>", "heures<br><b>vingt</b>", "heures<br><b>vingt-cinq</b>", "heures<br>et <b>demie</b>", "heures<br>moins<br><b>vingt-cinq</b>", "heures<br>moins<br><b>vingt</b>", "heures<br>moins le<br><b>quart</b>", "heures<br>moins<br><b>dix</b>", "heures<br>moins<br><b>cinq</b>", "pile"]
            var hoursList = ["<b>douze</b>", "<b>une</b>", "<b>deux</b>", "<b>trois</b>", "<b>quatre</b>", "<b>cinq</b>", "<b>six</b>", "<b>sept</b>", "<b>huit</b>", "<b>neuf</b>", "<b>dix</b>", "<b>onze</b>"]
            var minutesFirst = [false, false, false, false, false, false, false, false, false, false, false, false, false]
            var nextHour = [false, false, false, false, false, false, false, true, true, true, true, true, true]

            var minutes = Math.round(time.getMinutes() / 5)
            var hours = (time.getHours() + (nextHour[minutes] ? 1 : 0)) % 12

            var start = "<p style=\"text-align:center\">"
            var newline = "<br>"
            var end = "</p>"

            if (minutesFirst[minutes]) {
                var generatedString = minutesList[minutes].toUpperCase() + newline + hoursList[hours].toUpperCase()
            } else {
                var generatedString = hoursList[hours].toUpperCase() + newline + minutesList[minutes].toUpperCase()
            }

            return start + generatedString + end
        }

        function generateTimeDa(time) {
            var minutesList = ["", "<b>fem</b><br>over", "<b>ti</b><br>over", "<b>kvart</b><br>over", "<b>tyve</b><br>over", "femog<br>tyve", "<b>halv</b>", "femog<br>tredive", "<b>fyrre</b>", "<b>kvart</b><br><b>I</b>", "<b>ti</b><br><b>I</b>", "<b>fem</b><br><b>I</b>", ""]
            var hoursList = ["<b>tolv</b>", "<b>et</b>", "<b>to</b>", "<b>tre</b>", "<b>fire</b>", "<b>fem</b>", "<b>seks</b>", "<b>syv</b>", "<b>otte</b>", "<b>ni</b>", "<b>ti</b>", "<b>elleve</b>"]
            var minutesFirst = [false, true, true, true, true, false, true, false, false, true, true, true, false]
            var nextHour = [false, false, false, false, false, false, true, false, false, true, true, true, false]

            var minutes = Math.round(time.getMinutes() / 5)
            var hours = (time.getHours() + (nextHour[minutes] ? 1 : 0)) % 12

            var start = "<p style=\"text-align:center\">"
            var newline = "<br>"
            var end = "</p>"

            if (minutesFirst[minutes]) {
                var generatedString = minutesList[minutes].toUpperCase() + newline + hoursList[hours].toUpperCase()
            } else {
                var generatedString = hoursList[hours].toUpperCase() + newline + minutesList[minutes].toUpperCase()
            }

            return start + generatedString + end
        }

        id: timeDisplay

        anchors {
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -parent.height * .019
            left: parent.left
            right: parent.right
        }
        horizontalAlignment: Text.AlignHCenter
        textFormat: Text.RichText
        lineHeight: .85
        color: "white"
        style: Text.Outline
        styleColor: "#80000000"
        font {
            pixelSize: Qt.locale().name.substring(0,2) === "fr" ?
                           parent.height * .135 :
                           Qt.locale().name.substring(0,2) === "es" ?
                               parent.height * .145 :
                               parent.height * .15
            weight: Font.Light
        }
        text: Qt.locale().name.substring(0,2) === "de" ?
                  generateTimeDe(wallClock.time) :
                  Qt.locale().name.substring(0,2) === "es" ?
                      generateTimeEs(wallClock.time) :
                      Qt.locale().name.substring(0,2) === "fr" ?
                          generateTimeFr(wallClock.time) :
                          Qt.locale().name.substring(0,2) === "da" ?
                              generateTimeDa(wallClock.time) :
                              generateTimeEn(wallClock.time)
    }

    Text {
        id: dateDisplay

        anchors {
            topMargin: parent.width * .025
            top: timeDisplay.bottom
            left: parent.left
            right: parent.right
        }
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        style: Text.Outline; styleColor: "#80000000"
        opacity: .9
        font.pixelSize: parent.height * .07
        text: wallClock.time.toLocaleString(Qt.locale(), "<b>ddd</b> d MMM")
    }

    Item {
        id: batteryInfo

        anchors {
            bottomMargin: parent.width * .09
            bottom: timeDisplay.top
            left: parent.left
            right: parent.right
        }

        Icon {
            id: batteryIcon

            name: "ios-battery-charging"
            anchors {
                right: parent.horizontalCenter
                rightMargin: rootitem.height * .004
                topMargin: rootitem.height * .005
            }
            visible: dockMode.active
            width: rootitem.width * .1
            height: rootitem.height * .1
        }

        Text {
            id: batteryPercent

            anchors {
                left: parent.horizontalCenter
                leftMargin: rootitem.height * .004
            }
            font {
                pixelSize: rootitem.width * .07
                family: "Roboto"
                styleName: "Regular"
            }
            visible: dockMode.active
            color: "#ffffffff"
            style: Text.Outline; styleColor: "#80000000"
            text: batteryChargePercentage.percent + "%"
        }
    }

    Item {
        id: dockMode

        readonly property bool active: mceCableState.connected //ready || (nightstandEnabled.value && holdoff)
        //readonly property bool ready: nightstandEnabled.value && mceCableState.connected
        property int batteryPercentChanged: batteryChargePercentage.percent

        anchors.fill: parent
        layer {
            enabled: true
            samples: 4
            smooth: true
            textureSize: Qt.size(dockMode.width * 2, dockMode.height * 2)
        }
        visible: dockMode.active

        Shape {
            id: chargeArc

            property real angle: batteryChargePercentage.percent * 360 / 100
            // radius of arc is scalefactor * height or width
            property real arcStrokeWidth: .028
            property real scalefactor: .49 - (arcStrokeWidth / 2)
            property var chargecolor: Math.floor(batteryChargePercentage.percent / 33.35)
            readonly property var colorArray: [ "red", "yellow", Qt.rgba(.318, 1, .051, .9)]

            anchors.fill: parent
            smooth: true
            antialiasing: true

            ShapePath {
                fillColor: "transparent"
                strokeColor: chargeArc.colorArray[chargeArc.chargecolor]
                strokeWidth: parent.height * chargeArc.arcStrokeWidth
                capStyle: ShapePath.FlatCap
                joinStyle: ShapePath.MiterJoin
                startX: chargeArc.width / 2
                startY: chargeArc.height * ( .5 - chargeArc.scalefactor)

                PathAngleArc {
                    centerX: chargeArc.width / 2
                    centerY: chargeArc.height / 2
                    radiusX: chargeArc.scalefactor * chargeArc.width
                    radiusY: chargeArc.scalefactor * chargeArc.height
                    startAngle: -90
                    sweepAngle: chargeArc.angle
                    moveToStart: false
                }
            }
        }
    }

    MceBatteryLevel {
        id: batteryChargePercentage
    }

    MceBatteryState {
        id: batteryChargeState
    }

    MceCableState {
        id: mceCableState
    }

    Connections {
        target: localeManager
        function onChangesObserverChanged() {
            timeDisplay.text = Qt.binding(function() { return generateTime(wallClock.time) })
            dateDisplay.text = Qt.binding(function() { return wallClock.time.toLocaleString(Qt.locale(), "<b>ddd</b> d MMM") })
        }
    }

    Component.onCompleted: {
        burnInProtectionManager.widthOffset = Qt.binding(function() { return width * (dockMode.active ? .12 : .2)})
        burnInProtectionManager.heightOffset = Qt.binding(function() { return height * (dockMode.active ? .12 : .2)})
    }
}
