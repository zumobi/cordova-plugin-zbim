/*
 * ZBiM SDK Cordova Plugin
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2014-2016 Zumobi Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

var exec = require('cordova/exec');
var platform = require('cordova/platform');

var zbimPlugin = {
    ZBiMColorScheme: {
        ZBiMColorSchemeDark: "ZBiMColorSchemeDark",
        ZBiMColorSchemeLight: "ZBiMColorSchemeLight"
    },

    ZBiMSeverityLevel: {
        ZBiMLogSeverityNone: "ZBiMLogSeverityNone",
        ZBiMLogSeverityCriticalError: "ZBiMLogSeverityCriticalError",
        ZBiMLogSeverityError: "ZBiMLogSeverityError",
        ZBiMLogSeverityWarning: "ZBiMLogSeverityWarning",
        ZBiMLogSeverityInfo: "ZBiMLogSeverityInfo"
    },

    ZBiMVerbosityLevel: {
        ZBiMLogVerbosityNone: "ZBiMLogVerbosityNone",
        ZBiMLogVerbosityDebug: "ZBiMLogVerbosityDebug",
        ZBiMLogVerbosityInfo: "ZBiMLogVerbosityInfo"
    },

    ZBiMContentSource: {
        ZBiMContentSourceLocalOnly: "ZBiMContentSourceLocalOnly",
        ZBiMContentSourceExternalAllowed: "ZBiMContentSourceExternalAllowed"
    },

    ZBiMInitialContentDownloadMode: {
        ZBiMInitialContentDownloadModeImmediate: "ZBiMInitialContentDownloadModeImmediate",
        ZBiMInitialContentDownloadModeOnDemand: "ZBiMInitialContentDownloadModeOnDemand"
    },

    ZBiMContentRefreshMode: {
        ZBiMContentRefreshModeDontShowStale: "ZBiMContentRefreshModeDontShowStale",
        ZBiMContentRefreshModeStaleOK: "ZBiMContentRefreshModeStaleOK",
        ZBiMContentRefreshModeRecurring: "ZBiMContentRefreshModeRecurring"
    }
};

/**
 * @description Gets the current logging severity level.
 *
 * @return One of the following:
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityNone
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityCriticalError
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityError
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityWarning
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityInfo
 *
 * Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.getSeverityLevel = function (successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getSeverityLevel", []);
};

/**
 * @description Sets the logging severity level for the ZBiM SDK.
 *
 * @param severityLevel Indicates minimum severity level to be logged. Allowed
 * values are:
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityNone
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityCriticalError
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityError
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityWarning
 *   zbimPlugin.ZBiMSeverityLevel.ZBiMLogSeverityInfo
 *
 * Setting minimum severity level to ZBiMLogSeverityError will result in messages
 * with severity level of ZBiMLogSeverityError and ZBiMLogSeverityCriticalError
 * being logged. Setting minimum severity level to ZBiMLogSeverityInfo will result
 * in all messages being logged. Setting it to ZBiMLogSeverityNone will result in
 * no messages being logged. The default is ZBiMLogSeverityError.
 */
zbimPlugin.setSeverityLevel = function (severity, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "setSeverityLevel", [severity]);
};

/**
 * @description Gets the current logging verbosity level.
 *
 * @return One of the following:
 *   zbimPlugin.ZBiMVerbosityLevel.ZBiMLogVerbosityNone
 *   zbimPlugin.ZBiMVerbosityLevel.ZBiMLogVerbosityDebug
 *   zbimPlugin.ZBiMVerbosityLevel.ZBiMLogVerbosityInfo
 *
 * Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.getVerbosityLevel = function (successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getVerbosityLevel", []);
};

/**
 * @description Sets the logging verbosity level for the ZBiM SDK.
 *
 * @param verbosityLevel Indicates minimum verbosity level to be logged. Allowed
 * values are:
 *   zbimPlugin.ZBiMVerbosityLevel.ZBiMLogVerbosityNone
 *   zbimPlugin.ZBiMVerbosityLevel.ZBiMLogVerbosityDebug
 *   zbimPlugin.ZBiMVerbosityLevel.ZBiMLogVerbosityInfo
 *
 * Setting minimum verbosity level to ZBiMLogVerbosityInfo will result in all messages
 * being logged. Setting it to ZBiMLogVerbosityNone will result in
 * no messages being logged. The default is ZBiMLogVerbosityDebug.
 */
zbimPlugin.setVerbosityLevel = function (verbosity, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "setVerbosityLevel", [verbosity]);
};

/**
 * @description Gets the current active user ID.
 *
 * @return Current active user ID. Return value is passed as a parameter to the
 * successCallback function.
 */
zbimPlugin.getActiveUser = function (successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getActiveUser", []);
};

/**
 * @description Sets current active user ID.
 *
 * @param userId A string identifying the user.
 */
zbimPlugin.setActiveUser = function (activeUserId, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "setActiveUser", [activeUserId]);
};

/**
 * @description Helper method generating a default user ID. To be used in
 * the case where the client application has no concept of user ID and needs
 * the SDK to generate one on its behalf.
 *
 * @return userId Newly generated user ID. Return value is passed as a parameter
 * to the successCallback function.
 */
zbimPlugin.generateDefaultUserId = function (successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "generateDefaultUserId", []);
};

/**
 * @description Gets the list of tags associated with a given user ID. Tags are
 * sorted by usage count, with the most frequently used one being at index 0.
 *
 * @param userId User ID to retrieve tagging data for.
 *
 * @return An array of tags associated with given user ID. Return value is passed
 * as a parameter to the successCallback function.
 */
zbimPlugin.tagsForUser = function (userId, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "tagsForUser", [userId]);
};

/**
 * @description Creates a new user and associates it with the set of tags. There
 * can be multiple users per app instance, but only one can be set as the active
 * user at any point in time. Before a Content Hub can be shown an active user
 * must be set.
 *
 * @param userId A string identifying the user. It can be app-specific or a default
 * one can be generated by ZBiM SDK.
 * @param tags A list of tags that describe the user's preferences. Used for content tailoring.
 */
zbimPlugin.createUser = function (userId, tags, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "createUser", [userId, tags]);
};

/**
 * @description Gets the list of all previously created users.
 *
 * @return Array of user IDs. Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.getAllUsers = function (successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getAllUsers", []);
};

/**
 * @description A Content Hub entry point identifies the part of a client application
 * that triggered presenting the Content Hub. The entry point should be set immediately
 * before requesting a Content Hub to be presented. The value will be reset as soon as
 * it has been used, so it does not affect subsequent attempts at presenting a Content Hub.
 * The application needs to set the value explicitly every time it is needed.
 *
 * @param entryPoint A string value that identifies the part of the client application
 * that triggered presenting the Content Hub. Used for metrics reporting.
 */
zbimPlugin.setContentHubEntryPoint = function (entryPoint, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "setContentHubEntryPoint", [entryPoint]);
};

/**
 * @description Displays the Content Hub UI in a modal view mode. The content to be
 * loaded is selected based on an internal ordering scheme, as specified in the
 * content's source.
 */
zbimPlugin.presentHub = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "presentHub", []);
};

/**
 * @description Displays the Content Hub UI in a modal view mode. The content to
 * be loaded is the one that best matches the set of tags passed as a parameter.
 *
 * @param tags A set of tags to be used when selecting a hub page to load.
 */
zbimPlugin.presentHubWithTags = function(tags, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "presentHubWithTags", [tags]);
};

/**
 * @description Displays the Content Hub UI in a modal view mode, loading a specific
 * piece of content identified by the URI parameter.
 *
 * @param uri A URI identifying the content to be loaded. This is a Zumobi-provided string.
 */
zbimPlugin.presentHubWithUri = function(uri, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "presentHubWithUri", [uri]);
};

/**
 * @description Gets a flag indicating whether Content Hubs presented by ZBiM SDK
 * are to be branded with Zumobi's logo.
 *
 * @return Boolean value indicating whether Zumobi's logo is to be shown. Return
 * value is passed as a parameter to the successCallback function.
 */
zbimPlugin.getShowingZBILogo = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getShowingZBILogo", []);
};

/**
 * @description Sets a flag controlling whether Content Hubs presented by ZBiM SDK
 * are to be branded with Zumobi's logo.
 */
zbimPlugin.setShowingZBILogo = function(newValue, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "setShowingZBILogo", [newValue]);
};

/**
 * @description Gets ZBiM SDK status indicating whether it is currently downloading content.
 *
 * @return Boolean value indicating whether content is currently being downloaded. Return value
 * is passed as a parameter to the successCallback function.
 */
zbimPlugin.isDownloadingContent = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "isDownloadingContent", []);
};

/**
 * @description Gets ZBiM SDK status indicating whether a Content Hub is currently being displayed.
 *
 * @return Boolean value indivating whether the Content Hub is currently being displayed. Return
 * value is passed as a parameter to the successCallback function.
 */
zbimPlugin.isDisplayingContentHub = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "isDisplayingContentHub", []);
};

/**
 * @description Gets ZBiM SDK status indicating whether content has been successfully downloaded
 * and is ready to be presented inside a Content Hub.
 *
 * @return Boolean value indicating whether a Content Hub is ready to serve content.
 * Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.isReady = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "isReady", []);
};

/**
 * @description Gets ZBiM SDK status indicating whether the SDK has entered lockdown mode.
 * Once it has, the SDK will stop responding to any requests from the client for presenting
 * a new Content Hub.
 *
 * @return Boolean value indicating whether the ZBiM SDK is in a lockdown mode.
 * Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.isDisabled = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "isDisabled", []);
};

/**
 * @description Gets ZBiM SDK status indicating whether the SDK has been denied
 * access to an existing pilot program, either because the pilot program's limit
 * has been reached before the SDK ever tried to join or because the SDK lost its
 * place as part of a pilot program update.
 *
 * @return Boolean value indicating whether the ZBiM SDK has been denied access
 * to an existing pilot program. Return value is passed as a parameter to the
 * successCallback function.
 */
zbimPlugin.isExcludedFromPilotProgram = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "isExcludedFromPilotProgram", []);
};

/**
 * @description Gets the value of the initial content download mode, which specifies
 * whether to download new content immediately upon SDK being initialized
 * or to wait until the user expresses explicit interest in consuming content.
 * The latter, i.e. on-demand, is the default. This property is applicable
 * only when there's no previously downloaded content, hence "initial".
 * There is no programmatic way to set this value. Changing it can only
 * be done via the ZBiM portal.
 *
 * @return One of the following:
 *   zbimPlugin.ZBiMInitialContentDownloadMode.ZBiMInitialContentDownloadModeImmediate
 *   zbimPlugin.ZBiMInitialContentDownloadMode.ZBiMInitialContentDownloadModeOnDemand
 *
 * Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.getInitialContentDownloadMode = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getInitialContentDownloadMode", []);
};

/**
 * @description Gets the value of the content refresh mode, which specifies
 * how content is to be updated after the initial download completes
 * successfully. The default is to show previously downloaded content
 * and kick off an asynchronous refresh. There is no programmatic way
 * to set this value. Changing it can only be done via the ZBiM portal
 * and passed through to the SDK via the content bundle itself.
 *
 * @return One of the following:
 *   zbimPlugin.ZBiMContentRefreshMode.ZBiMContentRefreshModeDontShowStale
 *   zbimPlugin.ZBiMContentRefreshMode.ZBiMContentRefreshModeStaleOK
 *   zbimPlugin.ZBiMContentRefreshMode.ZBiMContentRefreshModeRecurring
 *
 * Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.getContentRefreshMode = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getContentRefreshMode", []);
};

/**
 * @description Gets the time interval between content refreshes. Applicable only
 * when content refresh mode has a value of ZBiMContentRefreshModeRecurring.
 * There is no programmatic way to set this value. Changing it can only be done
 * via the ZBiM portal.
 *
 * @return A floating point number indicating refresh interval (in seconds).
 * Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.getContentRefreshInterval = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getContentRefreshInterval", []);
};

/**
 * @description Gets the value of the Content Hub's color scheme.
 *
 * @return The following are allowed values, the former being the default:
 *   zbimPlugin.ZBiMColorScheme.ZBiMColorSchemeDark
 *   zbimPlugin.ZBiMColorScheme.ZBiMColorSchemeLight
 *
 * Return value is passed as a parameter to the successCallback function.
 */
zbimPlugin.getColorScheme = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "getColorScheme", []);
};

/**
 * @description Sets the color scheme for all future Content Hub. If a Content Hub
 * has already been loaded, it will not be affected by changes to the color scheme.
 * Supported parameter values are:
 *   zbimPlugin.ZBiMColorScheme.ZBiMColorSchemeDark
 *   zbimPlugin.ZBiMColorScheme.ZBiMColorSchemeLight
 */
zbimPlugin.setColorScheme = function(colorScheme, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "ZBiMSDKPlugin", "setColorScheme", [colorScheme]);
};

module.exports = zbimPlugin;
