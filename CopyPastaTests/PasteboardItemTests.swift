//
//  PasteboardItemTests.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 06/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
@testable import CopyPasta

class PasteboardItemTests: XCTestCase {

    func testTextItem() {
        let textItem = PasteboardItem.Text("copy")
        XCTAssert(textItem == .Text("copy"), "should handle equal operator")
        XCTAssert(textItem != .Text("copy pasta"), "should handle not equal operator")
    }

    func testImageItem() {
        let imageItem = PasteboardItem.Image(NSImage(named: "NSAdvanced")!)
        XCTAssert(imageItem == .Image(NSImage(named: "NSAdvanced")!), "should handle equal operator")
        XCTAssert(imageItem != .Image(NSImage(named: "NSApplicationIcon")!), "should handle not equal operator")
    }
    
    func testURLItem() {
        let urlItem = PasteboardItem.URL(NSURL(string: "http://url.com")!)
        XCTAssert(urlItem == .URL(NSURL(string: "http://url.com")!), "should handle equal operator")
        XCTAssert(urlItem != .URL(NSURL(string: "http://url.co.uk")!), "should handle not equal operator")
    }
}
