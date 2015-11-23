//
//  PasteboardService.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 03/11/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa
import VinceRP

class PasteboardService {

    let pasteboard = NSPasteboard.generalPasteboard()
    let pasteboardItems = reactive([AnyObject]())
    let changeCount = reactive(0)

    @objc func pollPasteboardItems() {

        if (changeCount* != pasteboard.changeCount) {
            guard let items = pasteboard.readObjectsForClasses([NSString.self, NSImage.self, NSURL.self], options: nil)
                where items.count > 0 else {
                return
            }
            guard let item = items.first else {
                return
            }

            pasteboardItems <- pasteboardItems*
                .filter { pbItem in
                    return pbItem as! String != item as! String
                }
                .arrayByPrepending(item)
            changeCount <- pasteboard.changeCount
        }
    }

    func addItemToPasteboard(item: NSString) {
        pasteboard.clearContents()
        pasteboard.writeObjects([item])
        pollPasteboardItems()
    }

}
