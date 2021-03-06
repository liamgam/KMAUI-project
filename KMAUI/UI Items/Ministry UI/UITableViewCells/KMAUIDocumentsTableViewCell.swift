//
//  KMAUIDocumentsTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 19.03.2020.
//  Copyright © 2020 Stanislav Rastvorov. All rights reserved.
//

import UIKit
import QuickLook

public class KMAUIDocumentsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet public weak var collectionView: UICollectionView!
    // MARK: - Variables
    public static let id = "KMAUIDocumentsTableViewCell"
    public var documents = [KMAPropertyDocument]() {
        didSet {
            setupCell()
        }
    }
    lazy var previewItem = NSURL()
    public var openFiles: ((KMAPropertyDocument) -> Void)?

    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // No selection  required
        selectionStyle = .none
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    public func setupCell() {
        // Register collection view cells
        let bundle = Bundle(for: KMAUIDocumentCollectionViewCell.self)
        collectionView.register(UINib(nibName: KMAUIDocumentCollectionViewCell.id, bundle: bundle), forCellWithReuseIdentifier: KMAUIDocumentCollectionViewCell.id)
        
        let cellSize = CGSize(width: 289, height: 291)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: false)
                            
        // Propery horizontal collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView Data Source and Delegate methods

extension KMAUIDocumentsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let documentCell = collectionView.dequeueReusableCell(withReuseIdentifier: KMAUIDocumentCollectionViewCell.id, for: indexPath) as? KMAUIDocumentCollectionViewCell {
            let document = documents[indexPath.row]
            documentCell.document = document
            return documentCell
        }
        
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let document = documents[indexPath.row]
        let files = KMAUIUtilities.shared.getItemsFrom(uploadBody: document.files)
        
        if !files.isEmpty {
            if files.count == 1 {
                let file = files[0]
                previewItem(item: file, propertyId: document.objectId)
            } else if files.count > 0 {
                openFiles?(document)
            }
        }
    }
    
    // MARK: - Image / Video preview
    
    func previewItem(item: KMADocumentData, propertyId: String) {
        KMAUIUtilities.shared.quicklookPreview(urlString: item.fileURL, fileName: item.name, uniqueId: propertyId) { (previewItemValue) in
            self.previewItem = previewItemValue
            // Display file
            let previewController = QLPreviewController()
            previewController.dataSource = self
            KMAUIUtilities.shared.displayAlert(viewController: previewController)
        }
    }
}

// MARK: - QLPreviewController Datasource

extension KMAUIDocumentsTableViewCell: QLPreviewControllerDataSource {
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItem as QLPreviewItem
    }
}
