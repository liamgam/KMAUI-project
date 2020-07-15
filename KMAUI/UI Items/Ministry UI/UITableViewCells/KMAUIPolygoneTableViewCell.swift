//
//  KMAUIGooglePlacePolygoneTableViewCell.swift
//  KMA
//
//  Created by Stanislav Rastvorov on 06.07.2020.
//  Copyright © 2020 Office Mac. All rights reserved.
//

import UIKit
import KMAUI
import QuickLook
import Kingfisher
import SafariServices

public class KMAUIPolygoneTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var bgView: KMAUIRoundedCornersView!
    @IBOutlet weak var bgViewTop: NSLayoutConstraint!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var placeImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var placeImageViewLeft: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: KMAUIBoldTextLabel!
    @IBOutlet weak var locationLabel: KMAUIRegularTextLabel!
    @IBOutlet weak var locationLabelTop: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var ratingLabel: KMAUIBoldTextLabel!
    @IBOutlet weak var ratingLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var ratingLabelLeft: NSLayoutConstraint!
    
    // MARK: - Variables
    public static let id = "KMAUIPolygoneTableViewCell"
    public var mapCallback: ((Bool) -> Void)?
    public var isFirst = false
    public var polygone = KMAUIPolygoneDataStruct() {
        didSet {
            setupCell()
        }
    }
    public var rowViews = [UIView]()
    public lazy var previewItem = NSURL()
    public var attachmentURLString = ""
    public var uniqueId = ""
    public var name = ""

    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Background color
        contentView.backgroundColor = KMAUIConstants.shared.KMAUIViewBgColorReverse
        
        // Larger shadow for bgView
        bgView.backgroundColor = KMAUIConstants.shared.KMAUIViewBgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 4)
        bgView.layer.shadowRadius = 12
        
        // Title label
        titleLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(18)
        
        // Rating label
        ratingLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(14)
        ratingLabel.textColor = UIColor.white
        ratingLabel.layer.cornerRadius = 8
        ratingLabel.clipsToBounds = true
        
        // Location label
        locationLabel.font = KMAUIConstants.shared.KMAUIRegularFont.withSize(14)
        
        // Place imageView
        placeImageView.layer.borderWidth = 1
        placeImageView.layer.borderColor = KMAUIConstants.shared.KMAUIGreyLineColor.withAlphaComponent(0.2).cgColor
        placeImageView.layer.cornerRadius = 8
        placeImageView.clipsToBounds = true
        
        // No selection required
        selectionStyle = .none
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell() {
        // Top offset
        if isFirst {
            bgViewTop.constant = 32
        } else {
            bgViewTop.constant = 0
        }
        
        // Attachment
        attachmentURLString = ""

        // Check type
        if polygone.polygoneType == "custom" {
            // Location label top offset
            locationLabelTop.constant = -4
            // Setup the custom polygone details
            setupCustomPolygone()
        } else if polygone.polygoneType == "googlePlace" {
            // Location label top offset
            locationLabelTop.constant = 6
            // Setup the Google Places details
            setupGooglePlacePolygone()
        }
    }

    func setupCustomPolygone() {
        // Title
        titleLabel.text = polygone.title
        name = polygone.title
        name = polygone.id
        
        // Id
        locationLabel.text = ""
        
        // Prepare rows
        var rows = [KMAUIRowData]()
        
        // Value
        if !polygone.value.isEmpty, polygone.type != "image" {
            rows.append(KMAUIRowData(rowName: "Value", rowValue: polygone.value))
        }
        
        if !polygone.valueArray.isEmpty {
            rows.append(KMAUIRowData(rowName: "Values", rowValue: ""))
            for item in polygone.valueArray {
                rows.append(KMAUIRowData(rowName: item.title, rowValue: item.value))
            }
        }
            
        // Type
        if !polygone.type.isEmpty {
            if polygone.type != "image", polygone.value.starts(with: "http") {
                rows.append(KMAUIRowData(rowName: "Type", rowValue: "Website"))
            } else {
                rows.append(KMAUIRowData(rowName: "Type", rowValue: polygone.type.capitalized))
            }
        }
        
        // Comment
        if !polygone.comment.isEmpty {
            rows.append(KMAUIRowData(rowName: "Comment", rowValue: polygone.comment))
        } else {
            rows.append(KMAUIRowData(rowName: "Comment", rowValue: "No comments"))
        }
        
        // Setup attachments
        if polygone.type == "image" {
            setupAttachments(url: polygone.value, name: polygone.title, id: polygone.title)
        } else {
            setupAttachments(url: "", name: "", id: "")
        }
        
        // Setup stack view
        setupStackView(rows: rows)
        
        // Hide rating
        ratingLabel.text = ""
        ratingLabelLeft.constant = 0
        ratingLabelWidth.constant = 0
    }
    
    func setupGooglePlacePolygone() {
        // Place name
        titleLabel.text = polygone.googlePlaceName
        name = polygone.googlePlaceName
        name = polygone.googlePlaceId

        // Rating
        if polygone.googlePlaceRating == 0 {
            ratingLabel.text = ""
            ratingLabelLeft.constant = 0
            ratingLabelWidth.constant = 0
        } else {
            ratingLabel.text = "\(polygone.googlePlaceRating)"
            ratingLabelLeft.constant = 12
            ratingLabelWidth.constant = 44
            
            if polygone.googlePlaceRating >= 4.5 {
                ratingLabel.backgroundColor = KMAUIConstants.shared.KMAUIGreenProgressColor
            } else if polygone.googlePlaceRating >= 3 {
                ratingLabel.backgroundColor = KMAUIConstants.shared.KMAUIYellowProgressColor
            } else {
                ratingLabel.backgroundColor = KMAUIConstants.shared.KMARedColor
            }
        }
        
        // Place address
        if !polygone.googlePlaceAddress.isEmpty {
            // Location label top offset
            locationLabel.text = polygone.googlePlaceAddress
        } else { // Location
            let latitude = CGFloat(Int(polygone.googlePlaceLocation.latitude * 1000000)) / 1000000
            let longitude = CGFloat(Int(polygone.googlePlaceLocation.longitude * 1000000)) / 1000000
            locationLabel.text = "\(latitude), \(longitude)"
        }
        
        // Setup attachments
        var imageURL = ""
        
        if polygone.googlePlaceImage.starts(with: "http") {
            imageURL = polygone.googlePlaceImage
        } else if !polygone.googlePlaceImage.isEmpty {
            imageURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(polygone.googlePlaceImage)&key=\(KMAUIConstants.shared.googlePlacesAPIKey)"
        }
        
        setupAttachments(url: imageURL, name: polygone.googlePlaceName, id: polygone.googlePlaceId)
        
        // Prepare rows
        var rows = [KMAUIRowData]()
        
        // Open now
        if !polygone.googlePlaceOpenNow.isEmpty {
            rows.append(KMAUIRowData(rowName: "Open now", rowValue: polygone.googlePlaceOpenNow))
        }

        // Categores
        if !polygone.googlePlaceTypes.isEmpty {
            rows.append(KMAUIRowData(rowName: "Category", rowValue: polygone.googlePlaceTypesString))
        }
        
        // Working hours
        if !polygone.googlePlaceWorkingHours.isEmpty {
            rows.append(KMAUIRowData(rowName: "Working hours", rowValue: polygone.googlePlaceWorkingHours))
        }
        
        // Business status
        if !polygone.googlePlaceBusinessStatus.isEmpty {
            rows.append(KMAUIRowData(rowName: "Business status", rowValue: polygone.googlePlaceBusinessStatus.lowercased().capitalized))
        }
        
        // Setup stack view
        setupStackView(rows: rows)
    }
    
    func setupAttachments(url: String, name: String, id: String) {
        var imageWidth: CGFloat = 200
        
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isPortrait {
            imageWidth = 100
        }
        
        placeImageViewWidth.constant = imageWidth
        
        if !url.isEmpty, let urlString = URL(string: url) {
            attachmentURLString = url
            placeImageView.kf.indicatorType = .activity
            placeImageView.kf.setImage(with: urlString)
            placeImageViewLeft.constant = 20
            placeImageView.alpha = 1
        } else {
            placeImageView.image = UIImage()
            placeImageView.alpha = 1
            placeImageViewLeft.constant = -imageWidth
            placeImageView.alpha = 0
        }
    }
    
    func setupStackView(rows: [KMAUIRowData]) {
        // Clear existing subviews
        for subview in stackView.subviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        // Clear the row views
        rowViews = [UIView]()
        
        // Prepare the rows
        for (index, row) in rows.enumerated() {
            let itemView = UIStackView()
            itemView.axis = .horizontal
            itemView.distribution = UIStackView.Distribution.fill
            itemView.alignment = UIStackView.Alignment.center
            itemView.spacing = 8
            
            itemView.layoutMargins = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
            itemView.isLayoutMarginsRelativeArrangement = true

            // Row name label
            let rowNameLabel = KMAUIRegularTextLabel()
            rowNameLabel.textAlignment = .left
            rowNameLabel.text = row.rowName
            
            if row.rowName == "Values", row.rowValue.isEmpty {
                rowNameLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(14)
            }
            
            rowNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
            itemView.addArrangedSubview(rowNameLabel)
            
            // Row value label
            let rowValueLabel = KMAUIBoldTextLabel()
            rowValueLabel.textAlignment = .right
            rowValueLabel.text = row.rowValue
            rowValueLabel.setLineSpacing(lineSpacing: 1.2, lineHeightMultiple: 1.2, alignment: .right)
            rowValueLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
            itemView.addArrangedSubview(rowValueLabel)
            
            let rowView = UIView()
            rowView.backgroundColor = UIColor.clear
                            
            itemView.backgroundColor = UIColor.clear
            rowView.addSubview(itemView)
            rowView.tag = index + 300
            rowView.layer.cornerRadius = KMAUIConstants.shared.KMACornerRadius
            rowView.clipsToBounds = true
            KMAUIUtilities.shared.setConstaints(parentView: rowView, childView: itemView, left: 0, right: 0, top: 0, bottom: 0)
            
            stackView.addArrangedSubview(rowView)
            rowView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
            
            if index < rows.count - 1 {
                // Line view
                let lineView = UIView()
                lineView.backgroundColor = KMAUIConstants.shared.KMAUIGreyLineColor.withAlphaComponent(0.2)
                lineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
                stackView.addArrangedSubview(lineView)
                lineView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
                lineView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
            }
            
            rowViews.append(rowView)
        }
        
        // Setup the image height
        var imageHeight = 36 * CGFloat(rowViews.count) + 21 + 20
        
        if let infoText = locationLabel.text, !infoText.isEmpty {
            imageHeight += 21 + 6
        }
        
        placeImageViewHeight.constant = imageHeight
    }
    
    @IBAction func showOnMapButtonPressed(_ sender: Any) {
        if polygone.type != "image", polygone.value.starts(with: "http") {
            if let url = URL(string: polygone.value) {
                KMAUIConstants.shared.popupOpened = true
                let safariVC = SFSafariViewController(url: url)
                KMAUIUtilities.shared.displayAlert(viewController: safariVC)
            }
        } else {
            mapCallback?(true)
        }
    }
    
    @IBAction func previewAttachment(_ sender: Any) {
        if !attachmentURLString.isEmpty {
            KMAUIUtilities.shared.quicklookPreview(urlString: attachmentURLString, fileName: name + ".jpg", uniqueId: uniqueId) { (previewItemValue) in
                KMAUIConstants.shared.popupOpened = true
                self.previewItem = previewItemValue
                // Display file
                let previewController = QLPreviewController()
                previewController.dataSource = self
                KMAUIUtilities.shared.displayAlert(viewController: previewController)
            }
        }
    }
}

// MARK: - QLPreviewController Datasource

extension KMAUIPolygoneTableViewCell: QLPreviewControllerDataSource {
    
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItem as QLPreviewItem
    }
}

