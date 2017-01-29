//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Oleg Kokhtenko on 29/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import ClockKit
import WatchKit

class ComplicationController: NSObject, CLKComplicationDataSource {

    // MARK: - Timeline Configuration

    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }

    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }

    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }

    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population

    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {

        let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
        let value = 15537//myDelegate.coinValue

        var entry : CLKComplicationTimelineEntry?
        let now = Date()
        let imageProvider = CLKImageProvider(onePieceImage: UIImage(named:"coin")!)
        let valueProvider = CLKSimpleTextProvider(text: value != nil ? "\(value)" : "--")

        switch complication.family {
        case .modularSmall:
            let textTemplate = CLKComplicationTemplateModularSmallStackImage()
            textTemplate.line1ImageProvider = imageProvider
            textTemplate.line2TextProvider = valueProvider
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: textTemplate)
            break
        case .modularLarge:
            let textTemplate = CLKComplicationTemplateModularLargeStandardBody()
            textTemplate.headerTextProvider = CLKSimpleTextProvider(text: "GreenChain")
            textTemplate.body1TextProvider = valueProvider
            textTemplate.headerImageProvider = imageProvider
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: textTemplate)
            break
        case .extraLarge:

            break
        case .circularSmall:

            break
        case .utilitarianLarge:

            break
        case .utilitarianSmall:

            break
        case .utilitarianSmallFlat:

            break
        }



        handler(entry)
    }

    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }

    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }

    // MARK: - Placeholder Templates

    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
