ZBiM SDK Cordova Plugin
=======

## Table of Contents
---
1. [Overview](#Overview)
2. [Requirements](#Requirements)
3. [Creating a Sample App](#CreatingSampleApp)
4. [ZBiM Plugin API](#ZBiMPluginAPI)
5. [Dependencies](#Dependencies)


<a id="Overview"/>
## Overview

This document provides an overview of ZBiM SDK Cordova Plugin. For more details on ZBiM SDK please see: https://github.com/zumobi/zbim-sdk-ios.

<a id="Requirements"/>
## Requirements
The ZBiM SDK Cordova plugin currently supports iOS only. To use it you will need the following:

1. Xcode 7 or later
2. iOS 7 or later

<a id="CreatingSampleApp"/>
## Creating a Sample App

To integrate ZBiM SDK into a sample Cordova app, follow these steps:

1. If you haven't already, set up the Cordova CLI. See the following for details: https://cordova.apache.org/docs/en/latest/guide/cli/index.html.

2. Clone the plugin:

  ```
  git clone https://github.com/zumobi/cordova-plugin-zbim.git <local path for plugin>
  ```

3. Create a new Cordova project:

  ```
  $ cordova create ZBiMCordovaDemo com.example.zbimCordovaDemo ZBiMCordovaDemo
  ```

4. Install iOS platform and verify all prerequisites are in place:

  ```
  $ cd ZBiMCordovaDemo
  $ cordova platform add ios
  $ cordova requirements
  ```

5. Install the plugin:

  ```
  $ cordova plugin add <local path for plugin>
  ```

6. Update your Cordova application to use the new plugin. Inside www/js/index.js you can add the following at the end of onDeviceReady:

  ```javascript
  onDeviceReady: function() {
      // ...
      zbimPlugin.getActiveUser(function(userId) {
          if (!userId) {
              zbimPlugin.generateDefaultUserId(function(userId) {
                  zbimPlugin.createUser(userId, [],  function() {
                      zbimPlugin.setActiveUser(userId, function() {
                          zbimPlugin.presentHub(function() {
                              console.log("Successfully presented Content Hub.");
                          }, function(error) {
                              console.error("Failed presenting Content Hub. Error: " + error);
                          });
                      }, function(error) {
                          console.error("Failed setting active user. Error: " + error);
                      });
                  }, function() {
                      console.error("Failed creating user.");
                  });
              });
          } else {
              zbimPlugin.presentHub(function() {
                  console.log("Successfully presented Content Hub.");
              }, function(error) {
                  console.error("Failed presenting Content Hub. Error: " + error);
              });
          }
      });
  },
  ```
  The above code aims to concisely showcase the minimum work needed to present a Content Hub. In a regular application you will typically have the code that creates and/or sets an active user as early as possible, e.g. in the onDeviceReady method, but the code to present a Content Hub will be separate, e.g. as part of a given UI control's event handler.

7. Add the two Zumobi-provided files (zbimconfig.plist and pubkey.der) to Xcode project. You will have to use Xcode to open the project file (e.g. platforms/ios/ZBiMCordovaDemo.xcodeproj) and add the files manually, e.g. in the Project Navigator, choose a container, right-click and select Add Files to "ZBiMCordovaDemo"...

8. Run the application:
  ```
  $ cordova run
  ```

<a id="ZBiMPluginAPI"/>
## ZBiM Plugin API

See www/zbimPlugin.js for details on individual APIs.

<a id="Dependencies"/>
## Dependencies

The ZBiM Cordova plugin includes the following dependencies:

1. ZBiM SDK 1.3 (https://github.com/zumobi/zbim-sdk-ios)
2. AWS SDK 2.3.6 (http://sdk-for-ios.amazonwebservices.com/aws-ios-sdk-2.3.6.zip)
3. FMDB 2.6 (https://github.com/ccgus/fmdb)
