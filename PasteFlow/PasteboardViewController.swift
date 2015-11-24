//
//  PasteboardViewController.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa

class PasteboardViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {

    let textItemCellID = "TextItemCell"
    let imageItemCellID = "ImageItemCell"
    let pasteViewModel = PasteViewModel()
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var countLabel: NSTextField!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)!
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        let textItemNib = NSNib(nibNamed: textItemCellID, bundle: nil)
        let imageItemNib = NSNib(nibNamed: imageItemCellID, bundle: nil)

        collectionView.registerNib(textItemNib, forItemWithIdentifier: textItemCellID)
        collectionView.registerNib(imageItemNib, forItemWithIdentifier: imageItemCellID)

        pasteViewModel.pasteboardItems.dispatchOnMainQueue().onChange { _ in self.collectionView.reloadData() }
        countLabel.reactiveText = self.pasteViewModel.pasteboardItems.map { ("\($0.count) items") }
    }

    // MARK: NSCollectionViewDataSource

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return pasteViewModel.items.count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        var cell = NSCollectionViewItem()
        let content = pasteViewModel.itemAtIndex(indexPath.item).content

        if let item = content as? String {
            cell = collectionView.makeItemWithIdentifier(textItemCellID, forIndexPath: indexPath)
            cell.textField!.stringValue = item
        } else if let item = content as? NSImage {
            cell = collectionView.makeItemWithIdentifier(imageItemCellID, forIndexPath: indexPath)
            cell.imageView!.image = item
        }
        return cell
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        let items = pasteViewModel.items
        return sizeForItem(items[indexPath.item])
    }

    // MARK: NSCollectionViewDelegate
    
    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        pasteViewModel.selectItemAtIndex(indexPaths.first!.item)
    }
    
    // MARK: Helper functions
    
    func sizeForItem(item: PasteboardItem) -> NSSize {
        var height:CGFloat = 50.0
        if item.kind == .Image {
            height = item.content.size.height > 200.0 ? 200.0 : item.content.size.height
        }
        return NSSize(width: collectionView.frame.size.width, height: height)
    }
    
}
