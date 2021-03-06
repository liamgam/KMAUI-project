//
//  KMAUIPropertyTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 19.03.2020.
//  Copyright © 2020 Stanislav Rastvorov. All rights reserved.
//

import UIKit
import QuickLook

public class KMAUIPropertyTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet public weak var typeLabel: KMAUIBoldTextLabel!
    @IBOutlet public weak var ownershipLabel: KMAUIRegularTextLabel!
    @IBOutlet public weak var circleViewOne: UIView!
    @IBOutlet public weak var residentsLabel: KMAUIRegularTextLabel!
    @IBOutlet public weak var circleViewTwo: UIView!
    @IBOutlet public weak var addressLabel: KMAUIRegularTextLabel!
    @IBOutlet public weak var documentsButton: UIButton!
    
    // MARK: - Variables
    public static let id = "KMAUIPropertyTableViewCell"
    public var property = KMACitizenProperty() {
        didSet {
            setupCell()
        }
    }
    lazy var previewItem = NSURL()
    public var openFiles: ((KMAPropertyDocument) -> Void)?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Type label
        typeLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(18)
        
        // Ownership label
        ownershipLabel.font = KMAUIConstants.shared.KMAUIRegularFont.withSize(16)
        
        // Circle views
        circleViewOne.layer.cornerRadius = 2.5
        circleViewOne.clipsToBounds = true
        circleViewTwo.layer.cornerRadius = 2.5
        circleViewTwo.clipsToBounds = true
        
        // Documents button
        documentsButton.setImage(KMAUIConstants.shared.attachmentIcon.withRenderingMode(.alwaysTemplate), for: .normal)
        
        // No selection required
        selectionStyle = .none
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setupCell() {
        // Property type
        if property.apartment > 0 {
            typeLabel.text = "Apartment"
        } else {
            typeLabel.text = "Private house"
        }
        
        // Ownership form
        ownershipLabel.text = property.ownershipForm
        
        // Residents count
        if property.residentsCount == 1 {
            residentsLabel.text = "1 resident"
        } else {
            residentsLabel.text = "\(property.residentsCount) residents"
        }
        
        // Address
        if property.formattedAddress.isEmpty {
            addressLabel.text = "No address"
        } else {
            addressLabel.text = property.formattedAddress
            let addressArray = property.formattedAddress.components(separatedBy: ",")
            
            if !addressArray.isEmpty {
                addressLabel.text = property.city + ", " + addressArray[0]
            }
        }
        
        // Documents
        if property.documents.isEmpty {
            documentsButton.tintColor = KMAUIConstants.shared.KMAUIGreyLineColor.withAlphaComponent(0.5)
            documentsButton.setTitleColor(KMAUIConstants.shared.KMAUIGreyLineColor.withAlphaComponent(0.5), for: .normal)
            documentsButton.setTitleColor(KMAUIConstants.shared.KMAUIGreyLineColor.withAlphaComponent(0.5), for: .highlighted)
            documentsButton.isEnabled = false
        } else {
            documentsButton.tintColor = KMAUIConstants.shared.KMABrightBlueColor
            documentsButton.setTitleColor(KMAUIConstants.shared.KMABrightBlueColor, for: .normal)
            documentsButton.setTitleColor(KMAUIConstants.shared.KMABrightBlueColor, for: .highlighted)
            documentsButton.isEnabled = true
        }
        
        
    }
    
    @IBAction func documentsButtonPressed(_ sender: Any) {                
        if !property.documents.isEmpty {
            let document = property.documents[0]
            let files = KMAUIUtilities.shared.getItemsFrom(uploadBody: document.files)
            
            if !files.isEmpty {
                if files.count == 1 {
                    let file = files[0]
                    previewItem(item: file, propertyId: property.objectId)
                } else if files.count > 0 {
                    openFiles?(document)
                }
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

extension KMAUIPropertyTableViewCell: QLPreviewControllerDataSource {
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItem as QLPreviewItem
    }
}
