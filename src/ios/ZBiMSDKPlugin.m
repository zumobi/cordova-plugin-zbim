/*
 * ZBiMSDKPlugin.m
 *
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

#import "ZBiMSDKPlugin.h"

@implementation ZBiMSDKPlugin

- (void)pluginInitialize
{
    [ZBiM start];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pluginReset:) name:CDVPluginResetNotification object:nil];
}

- (void) pluginReset:(NSNotification *)notification
{
    NSLog(@"ZBiM pluging detected that it's being reset while presenting a Content Hub. This is not supported. Forcing Content Hub to be dismissed.");
    NSError *error;
    if (![[ZBiM getCurrentContentHub] dismiss:&error])
    {
        NSLog(@"Failed forcefully dismissing Content Hub due to plugin reset. Error: %@", error);
    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) getSeverityLevel:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[self severityEnumToString:[ZBiM severityLevel]]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setSeverityLevel:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString:@"Logging severity level is a required parameter."];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        return;
    }
    
    [self.commandDelegate runInBackground:^{
        NSString *severityLevel = (command.arguments)[0];

        [ZBiM setSeverityLevel:[self severityFromStringToEnum:severityLevel]];

        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                    callbackId:command.callbackId];
    }];
}

- (void) getVerbosityLevel:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[self verbosityEnumToString:[ZBiM verbosityLevel]]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setVerbosityLevel:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString:@"Logging verbosity level is a required parameter."];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        return;
    }
    
    [self.commandDelegate runInBackground:^{
        NSString *verbosityLevel = (command.arguments)[0];

        [ZBiM setVerbosityLevel:[self verbosityFromStringToEnum:verbosityLevel]];

        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                    callbackId:command.callbackId];
    }];
}

- (void) generateDefaultUserId:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[ZBiM generateDefaultUserId]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) createUser:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString:@"User ID is a required parameter."];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        return;
    }

    [self.commandDelegate runInBackground:^{
        NSString *userId = (command.arguments)[0];
        NSArray *tags;
        NSError *error;

        if ([command.arguments count] == 2)
        {
            tags = (command.arguments)[1] != [NSNull null] ? (command.arguments)[1] : nil;
        }

        BOOL result = [ZBiM createUser:userId withTags:tags error:&error];
        if (result)
        {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                        callbackId:command.callbackId];
        }
        else
        {
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                              messageAsString:error.description];
    
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void) getActiveUser:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[ZBiM activeUser]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setActiveUser:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString:@"User ID is a required parameter."];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        return;
    }
    
    [self.commandDelegate runInBackground:^{

        NSString *activeUserId = (command.arguments)[0];
        NSError *error;

        BOOL result = [ZBiM setActiveUser:activeUserId error:&error];
        if (result)
        {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                        callbackId:command.callbackId];
        }
        else
        {
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                              messageAsString:error.description];
            
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void) getAllUsers:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsArray:[ZBiM getAllUsers]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) tagsForUser:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString:@"User ID is a required parameter."];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        return;
    }
    
    [self.commandDelegate runInBackground:^{

        NSString *userId = (command.arguments)[0];
        NSError *error;
        CDVPluginResult *pluginResult;
        
        NSArray *result = [ZBiM tagsForUser:userId error:&error];
        if (result)
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                              messageAsArray:result];
        }
        else
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                             messageAsString:error.description];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void) setContentHubEntryPoint:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString:@"Content Hub entry point is a required parameter."];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        return;
    }
    
    [self.commandDelegate runInBackground:^{
        NSString *entryPoint = (command.arguments)[0];
        
        [ZBiM setContentHubEntryPoint:entryPoint];
        
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                    callbackId:command.callbackId];
    }];
}

- (void) presentHub:(CDVInvokedUrlCommand *)command
{
    [ZBiM presentHub:^(BOOL success, NSError *error) {
        CDVPluginResult* pluginResult;
        if (!success)
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                             messageAsString:error.description];
        }
        else
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void) presentHubWithTags:(CDVInvokedUrlCommand *)command
{
    NSArray *tags;
    
    if ([command.arguments count] > 0)
    {
        tags = command.arguments[0] != [NSNull null] ? command.arguments[0] : nil;
    }

    [ZBiM presentHubWithTags:tags completion:^(BOOL success, NSError *error) {
        CDVPluginResult* pluginResult;
        if (!success)
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                             messageAsString:error.description];
        }
        else
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void) presentHubWithUri:(CDVInvokedUrlCommand *)command
{
    NSString *uri;
    
    if ([command.arguments count] > 0)
    {
        uri = command.arguments[0] != [NSNull null] ? command.arguments[0] : nil;
    }
    
    [ZBiM presentHubWithUri:uri completion:^(BOOL success, NSError *error) {
        CDVPluginResult* pluginResult;
        if (!success)
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                             messageAsString:error.description];
        }
        else
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void) getShowingZBILogo:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                  messageAsBool:[ZBiM showZBILogo]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setShowingZBILogo:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString:@"Invalid argument."];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        return;
    }
    
    [self.commandDelegate runInBackground:^{
        BOOL show = [(command.arguments)[0] boolValue];

        [ZBiM setShowZBILogo:show];

        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                    callbackId:command.callbackId];
    }];
}

- (void) isDownloadingContent:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                        messageAsBool:[ZBiM isDownloadingContent]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) isDisplayingContentHub:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                        messageAsBool:[ZBiM isDisplayingContentHub]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) isReady:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                        messageAsBool:[ZBiM isReady]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) isDisabled:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                        messageAsBool:[ZBiM isDisabled]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) isExcludedFromPilotProgram:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                        messageAsBool:[ZBiM notPartOfPilotProgram]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) getInitialContentDownloadMode:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[self initialContentDownloadModeEnumToString:[ZBiM initialContentDownloadMode]]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) getContentRefreshMode:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[self contentRefreshModeEnumToString:[ZBiM contentRefreshMode]]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) getContentRefreshInterval:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[NSString stringWithFormat:@"%f", [ZBiM contentRefreshInterval]]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) getColorScheme:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[self colorSchemeEnumToString:[ZBiM colorScheme]]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setColorScheme:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString:@"Color scheme is a required parameter."];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        return;
    }
    
    [self.commandDelegate runInBackground:^{
        NSString *colorScheme = (command.arguments)[0];
        
        [ZBiM setColorScheme:[self colorSchemeFromStringToEnum:colorScheme]];
        
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                    callbackId:command.callbackId];
    }];
}

#pragma mark Private Methods

- (NSString *) severityEnumToString:(ZBiMSeverityLevel)enumItem
{
    switch (enumItem)
    {
        case ZBiMLogSeverityCriticalError:
            return @"ZBiMLogSeverityCriticalError";
            
        case ZBiMLogSeverityError:
            return @"ZBiMLogSeverityError";
            
        case ZBiMLogSeverityWarning:
            return @"ZBiMLogSeverityWarning";
            
        case ZBiMLogSeverityInfo:
            return @"ZBiMLogSeverityInfo";
            
        case ZBiMLogSeverityNone:
            return @"ZBiMLogSeverityNone";
        default:
            return @"ZBiMLogSeverityError";
    }
}

- (ZBiMSeverityLevel) severityFromStringToEnum:(NSString *)enumString
{
    if ([enumString isEqualToString:@"ZBiMLogSeverityCriticalError"])
    {
        return ZBiMLogSeverityCriticalError;
    }
    
    if ([enumString isEqualToString:@"ZBiMLogSeverityError"])
    {
        return ZBiMLogSeverityError;
    }
    
    if ([enumString isEqualToString:@"ZBiMLogSeverityWarning"])
    {
        return ZBiMLogSeverityWarning;
    }
    
    if ([enumString isEqualToString:@"ZBiMLogSeverityInfo"])
    {
        return ZBiMLogSeverityInfo;
    }

    return [enumString isEqualToString:@"ZBiMLogSeverityNone"] ? ZBiMLogSeverityNone : ZBiMLogSeverityError;
}

- (NSString *) verbosityEnumToString:(ZBiMVerbosityLevel)enumItem
{
    switch (enumItem)
    {
        case ZBiMLogVerbosityDebug:
            return @"ZBiMLogVerbosityDebug";
            
        case ZBiMLogVerbosityInfo:
            return @"ZBiMLogVerbosityInfo";
            
        case ZBiMLogVerbosityNone:
            return @"ZBiMLogVerbosityNone";
            
        default:
            return @"ZBiMLogVerbosityDebug";
    }
}

- (ZBiMVerbosityLevel) verbosityFromStringToEnum:(NSString *)enumString
{
    if ([enumString isEqualToString:@"ZBiMLogVerbosityDebug"])
    {
        return ZBiMLogVerbosityDebug;
    }

    if ([enumString isEqualToString:@"ZBiMLogVerbosityInfo"])
    {
        return ZBiMLogVerbosityInfo;
    }

    return [enumString isEqualToString:@"ZBiMLogVerbosityNone"] ? ZBiMLogVerbosityNone : ZBiMLogVerbosityDebug;
}

- (NSString *) initialContentDownloadModeEnumToString:(ZBiMInitialContentDownloadMode)enumItem
{
    switch (enumItem) {
        case ZBiMInitialContentDownloadModeImmediate:
            return @"ZBiMInitialContentDownloadModeImmediate";
    
        case ZBiMInitialContentDownloadModeOnDemand:
            return @"ZBiMInitialContentDownloadModeOnDemand";
            
        default:
            return @"ZBiMInitialContentDownloadModeOnDemand";
    }
}

- (NSString *) contentRefreshModeEnumToString:(ZBiMContentRefreshMode)enumItem
{
    switch (enumItem)
    {
        case ZBiMContentRefreshModeDontShowStale:
            return @"ZBiMContentRefreshModeDontShowStale";
            
        case ZBiMContentRefreshModeStaleOK:
            return @"ZBiMContentRefreshModeStaleOK";
            
        case ZBiMContentRefreshModeRecurring:
            return @"ZBiMContentRefreshModeRecurring";
            
        default:
            return @"ZBiMContentRefreshModeStaleOK";
    }
}

- (NSString *) colorSchemeEnumToString:(ZBiMColorScheme)enumItem
{
    switch (enumItem)
    {
        case ZBiMColorSchemeDark:
            return @"ZBiMColorSchemeDark";
            
        case ZBiMColorSchemeLight:
            return @"ZBiMColorSchemeLight";

        default:
            return @"ZBiMColorSchemeDark";
    }
}

- (ZBiMColorScheme) colorSchemeFromStringToEnum:(NSString *)enumString
{
    if ([enumString isEqualToString:@"ZBiMColorSchemeDark"])
    {
        return ZBiMColorSchemeDark;
    }
    
    if ([enumString isEqualToString:@"ZBiMColorSchemeLight"])
    {
        return ZBiMColorSchemeLight;
    }
    
    return ZBiMColorSchemeDark;
}

- (NSString *) contentSourceEnumToString:(ZBiMContentSource)enumItem
{
    switch (enumItem)
    {
        case ZBiMContentSourceLocalOnly:
            return @"ZBiMContentSourceLocalOnly";
    
        case ZBiMContentSourceExternalAllowed:
            return @"ZBiMContentSourceExternalAllowed";
            
        default:
            return @"ZBiMContentSourceExternalAllowed";
    }
}

- (ZBiMContentSource) contentSourceFromStringToEnum:(NSString *)enumString
{
    if ([enumString isEqualToString:@"ZBiMContentSourceLocalOnly"])
    {
        return ZBiMContentSourceLocalOnly;
    }
    
    if ([enumString isEqualToString:@"ZBiMContentSourceExternalAllowed"])
    {
        return ZBiMContentSourceExternalAllowed;
    }
    
    return ZBiMContentSourceExternalAllowed;
}


@end
