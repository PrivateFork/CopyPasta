//
//  PasteboardServiceTests.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 06/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
import VinceRP
@testable import CopyPasta

class PasteboardServiceTests: XCTestCase {

    func addItemToPasteboard() {
        let pasteboardService = PasteboardService()
        pasteboardService.addItemToPasteboard(.Text("pasta"))
        XCTAssertTrue(pasteboardService.pasteboardItems.value()[0] == .Text("pasta"), "it should add new items")
    }

    func testpollPasteboardItems() {
        let pasteboardService = PasteboardService()
        pasteboardService.pasteboard.writeObjects(["pasta" as NSPasteboardWriting])
        pasteboardService.pollPasteboardItems()

        XCTAssertTrue(pasteboardService.pasteboardItems.value()[0] == .Text("pasta"), "it should poll new items")
    }

}
