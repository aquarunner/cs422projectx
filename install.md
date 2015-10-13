# Project X Install Instructions #

## Step 1 - Download / unpack the application ##

The latest version of the application may be downloaded from the project's downloads area, or via [this direct link](http://cs422projectx.googlecode.com/files/People.zip).

Save the ZIP file to a folder location on your computer, and open it.  The ZIP handling program on your computer should allow you to unzip it.

Make note of the unzipped "People" folder location.

If you do not have a ZIP file program, or your computer responds that the file type is unrecognized, you may obtain a free zip program from [WinZip](http://www.winzip.com).

## Step 2 - Install Qt SDK ##

Running the application requires the presence of the Qt SDK development environment.  If this is already installed on your system, you may proceed to step 3.

To obtain Qt SDK, visit the install page on Nokia's website for the most up to date install instructions: http://www.developer.nokia.com/Develop/Qt/Getting_started/.

Once Qt SDK is installed, you can use Qmlviewer to launch the program.


## Step 3 - Launching from Qmlviewer ##

Qmlviewer (qmlviewer.exe) is a tool that is installed along with the Qt SDK.  Locate and run this.  There are two ways:

  1. The location of qmlviewer is dependent on the location of the Qt SDK installation on your system, as [described by Nokia on their website](http://doc.qt.nokia.com/4.7-snapshot/qmlviewer.html).  On a typical Windows environment, it may be located at `C:\QtSDK\Desktop\Qt\4.7.4\mingw\bin\qmlviewer.exe`.  On your system the location may differ by the version of the SDK.
  1. Alternatively you may open a development environment console for Qt SDK.  On Windows a shortcut for this may be located in the Start menu within the Qt SDK > Desktop folder, as depicted below.  Once any console is open, enter "qmlviewer.exe" at the prompt to start Qmlviewer.

![http://cs422projectx.googlecode.com/files/Clipboard01.png](http://cs422projectx.googlecode.com/files/Clipboard01.png)

![http://cs422projectx.googlecode.com/files/Clipboard02.png](http://cs422projectx.googlecode.com/files/Clipboard02.png)


Once Qmlviewer is started, choose File > Open, to start the open file dialogue.  Navigate to the "People" folder location and open the Vendor.qml file.

![http://cs422projectx.googlecode.com/files/Clipboard03.png](http://cs422projectx.googlecode.com/files/Clipboard03.png)

Then program will then start.