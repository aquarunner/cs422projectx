/*
 * File:
 * Description:
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */


//http://jryannel.wordpress.com/2010/02/09/slider-component/#more-70
import QtQuick 1.1

Rectangle {
  id: slider;
  width: 620; height: 40;
  anchors.centerIn: parent
  property int value: Math.round(handle.x*50/(slider.width-handle.width))
  color: "green"
  Rectangle {
    id: handle; width: 40; height: 40
    color: "red"
    MouseArea {
      anchors.fill: parent
      drag.target: parent; drag.axis: "XAxis"
      drag.minimumX: 0; drag.maximumX: slider.width - handle.width
    }

    Text {
        //id: name
        text: slider.value
        anchors.centerIn: parent
    }
  }
}
