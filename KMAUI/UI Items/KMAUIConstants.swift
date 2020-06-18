//
//  KMAUIConstants.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 28.11.2019.
//  Copyright © 2019 Stanislav Rastvorov. All rights reserved.
//

import UIKit
import CoreLocation

public class KMAUIConstants {
    // Access variable
    public static let shared = KMAUIConstants()
    
    // MARK: - Lightbox closed - no need to open main map
    public var popupOpened = false
    
    // MARK: - Fonts
    public let KMAUIRegularFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    public let KMAUIBoldFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
    public struct Fonts {
        public static let regularSize18 = UIFont.systemFont(ofSize: 18, weight: .regular)
        public static let weight600Size18 = UIFont.systemFont(ofSize: 18, weight: .semibold)
        public static let weight600Size16 = UIFont.systemFont(ofSize: 16, weight: .semibold)
        public static let weight600Size14 = UIFont.systemFont(ofSize: 14, weight: .semibold)
        public static let regular = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    // MARK: - KMAUIColors
    public let KMAUIMainBgColor = UIColor(named: "KMAUIMainBgColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIViewBgColor = UIColor(named: "KMAUIViewBgColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIMemberBgColor = UIColor(named: "KMAUIMemberBgColorF2F2F5", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)! //#F2F2F5
    public let KMAUITextColor = UIColor(named: "KMAUITextColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIBlueDarkColor = UIColor(named: "KMAUIBlueDarkColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIGreyLineColor = UIColor(named: "KMAUIGreyLineColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIGreyProgressColor = UIColor(named: "KMAUIGreyProgressColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIRedProgressColor = UIColor(named: "KMAUIRedProgressColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIYellowProgressColor = UIColor(named: "KMAUIYellowProgressColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIGreenProgressColor = UIColor(named: "KMAUIGreenProgressColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIBlueDarkColorBarTint = UIColor(named: "KMAUIBlueDarkColorBarTint", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!    
    // This is used for the Detail part of the UISplitViewController, where we need the white background and the Dark items are reserved
    public let KMAUIMainBgColorReverse = UIColor(named: "KMAUIMainBgColorReverse", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIViewBgColorReverse = UIColor(named: "KMAUIViewBgColorReverse", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUILightButtonColor = UIColor(named: "KMAUILightButtonColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUISubLandCommercialColor = UIColor(named: "KMAUISubLandCommercialColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUISubLandLotteryColor = UIColor(named: "KMAUISubLandLotteryColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUISubLandSaleColor = UIColor(named: "KMAUISubLandSaleColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)! // #FDFDFD
    public let KMAUISubLandServicesColor = UIColor(named: "KMAUISubLandServicesColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIParkColor = UIColor(named: "KMAUIParkColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIGreyTextColor = UIColor(named: "KMAUIGreyTextColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUILightBorderColor = UIColor(named: "KMAUILightBorderColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    
    // MARK: - Colors
    public let KMATextGrayColor = UIColor(named: "KMATextGrayColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIDarkTextColor = UIColor(named: "KMAUIDarkTextColor111538", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)! // #111538
    public let KMABgGray = UIColor(named: "KMABgGray", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMABackColor = UIColor(named: "KMABackColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMATurquoiseColor = UIColor(named: "KMATurquoiseColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)! //#00DBDC
    public let KMATitleColor = UIColor(named: "KMATitleColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMATextColor = UIColor(named: "KMATextColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMABlueColor = UIColor(named: "KMABlueColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAGreenColor = UIColor(named: "KMAGreenColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMARoseColor = UIColor(named: "KMARoseColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMARedColor = UIColor(named: "KMARedColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMALightPurpleColor = UIColor(named: "KMALightPurpleColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAPurpleColor = UIColor(named: "KMAPurpleColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMALineGray = UIColor(named: "KMALineGray", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMABrightBlueColor = UIColor(named: "KMABrightBlueColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMABuildingGray = UIColor(named: "KMABuildingGray", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAProgressGray = UIColor(named: "KMAProgressGray", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIGreyBackgroundButton = UIColor(named: "KMAUIGreyBackgroundButton", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)! // #F5F5F5
    public let KMAUIBlackTitleButton = UIColor(named: "KMAUIBlackTitleButton", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let KMAUIWhiteTitleButton = UIColor(named: "KMAUIWhiteTitleButton", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)! // #F7F7F7
    public let KMAUIMapSymbolColor = UIColor(named: "KMAUIMapSymbolColor", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)! // #2D15AC
    
    // MARK: - Images
    public let checkboxFilledIcon = UIImage(named: "checkboxFilledIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let checkboxIcon = UIImage(named: "checkboxIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let filterIcon = UIImage(named: "filterIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let filterFilledIcon = UIImage(named: "filterFilledIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let dashboardTabIcon = UIImage(named: "dashboardTabIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let mapTabIcon = UIImage(named: "mapIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let profileTabIcon = UIImage(named: "profileIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let requestsTabIcon = UIImage(named: "requestsIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let searchIcon = UIImage(named: "searchIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let settingsIcon = UIImage(named: "settingsIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let propertyIcon = UIImage(named: "propertyIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let weatherError = UIImage(named: "weatherError", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let bathIcon = UIImage(named: "bathIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let bedIcon = UIImage(named: "bedIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let receptIcon = UIImage(named: "receptIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let lowPrice = UIImage(named: "lowPrice", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let highPrice = UIImage(named: "highPrice", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let floorPlanIcon = UIImage(named: "floorPlanIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let floorsCountIcon = UIImage(named: "floorsCountIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let rightArrow = UIImage(named: "rightArrow", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let checkmarkIcon = UIImage(named: "checkmarkIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let policemanIcon = UIImage(named: "policemanIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let departmentPlaceholder = UIImage(named: "departmentPlaceholder", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let houseIcon = UIImage(named: "houseIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let apartmentIcon = UIImage(named: "apartmentIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let closeIcon = UIImage(named: "closeIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let starIcon = UIImage(named: "starIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let arrowIndicator = UIImage(named: "arrowIndicator", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let arrowUpIndicator = UIImage(named: "arrowUpIndicator", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let arrowDownIndicator = UIImage(named: "arrowDownIndicator", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let eyeIcon = UIImage(named: "eyeIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let optionsIcon = UIImage(named: "optionsIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let mapIcon = UIImage(named: "mapIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let profileIcon = UIImage(named: "profileIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let requestsIcon = UIImage(named: "requestsIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let infoIcon = UIImage(named: "infoIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let filterBarIcon = UIImage(named: "filterBarIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let playIcon = UIImage(named: "playIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let placeholderUploadImage = UIImage(named: "placeholderUploadImage", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let placeholderProfileImage = UIImage(named: "placeholderProfileImage", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let placeholderUploadImageNoir = UIImage(named: "placeholderUploadImageNoir", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let landPlanTabIcon = UIImage(named: "landPlanTabIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let disclosureArrow = UIImage(named: "disclosureArrow", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let lotteryPlaceholder = UIImage(named: "lotteryPlaceholder", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let decreaseArrow = UIImage(named: "decreaseArrow", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let citizensIcon = UIImage(named: "citizensIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let profilePlaceholder = UIImage(named: "profilePlaceholder", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let attachmentIcon = UIImage(named: "attachmentIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let propertyDocument = UIImage(named: "propertyDocument", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let threeDotVertical = UIImage(named: "threeDotVertical", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let uploadedDocument = UIImage(named: "uploadedDocument", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let exchangeIcon = UIImage(named: "exchangeIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let headerLotteryIcon = UIImage(named: "headerLotteryIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let headerSubLandIcon = UIImage(named: "headerSubLandIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let headerCitizenIcon = UIImage(named: "headerCitizenIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let dashboardTabIconC = UIImage(named: "dashboardTabIconC", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let mapTabIconC = UIImage(named: "mapTabIconC", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let landPlanTabIconC = UIImage(named: "landPlanTabIconC", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let profileTabIconC = UIImage(named: "profileTabIconC", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let requestsTabIconC = UIImage(named: "requestsTabIconC", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let notificationsBarIconC = UIImage(named: "notificationsBarIconC", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let uploadDocumentBarIconC = UIImage(named: "uploadDocumentBarIconC", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let winnerImage = UIImage(named: "winnerImage", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let arrowIndicatorFull = UIImage(named: "arrowIndicatorFull", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let paperclipIcon = UIImage(named: "paperclipIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    // Upload a document flow
    public let uploadBackground = UIImage(named: "uploadBackground", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let uploadDocumentImage = UIImage(named: "uploadDocumentImage", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let uploadDocumentBadge = UIImage(named: "uploadDocumentBadge", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let uploadDocumentBadgeGray = UIImage(named: "uploadDocumentBadgeGray", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let pendingDocumentImage = UIImage(named: "pendingDocumentImage", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let pendingDocumentBadge = UIImage(named: "pendingDocumentBadge", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let approvedDocumentBadge = UIImage(named: "approvedDocumentBadge", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    // Lotteries
    public let noLotteriesIcon = UIImage(named: "noLotteriesIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let closeImage = UIImage(named: "closeImage", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let medalIcon = UIImage(named: "medalIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let cameraIcon = UIImage(named: "cameraIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let finishedIcon = UIImage(named: "finishedIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let lotteryBackground = UIImage(named: "lotteryBackground", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let triangleIcon = UIImage(named: "triangleIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let shareIcon = UIImage(named: "shareIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    // Attachment statuses
    public let pendingAttachmentIcon = UIImage(named: "pendingAttachmentIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let approvedAttachmentIcon = UIImage(named: "approvedAttachmentIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let rejectedAttachmentIcon = UIImage(named: "rejectedAttachmentIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let mapButtonImage = UIImage(named: "mapButtonImage", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let approvementIcon = UIImage(named: "approvementIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let rejectionIcon = UIImage(named: "rejectionIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let pinIcon = UIImage(named: "pinIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let arrowDown = UIImage(named: "arrowDown", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    public let locationPinIcon = UIImage(named: "locationPinIcon", in: Bundle(for: KMAUIConstants.self), compatibleWith: nil)!
    
    // String gap
    public let stringGap = "     "
    
    // MARK: - Constants
    public let KMACornerRadius: CGFloat = 6
    public let KMAScreenWidth = UIScreen.main.bounds.size.width
    public let KMSScreenHeight = UIScreen.main.bounds.size.height
    public let KMABorderWidthLight: CGFloat = 0.5
    public let KMABorderWidthRegular: CGFloat = 1.0
    public let KMABorderWidthBold: CGFloat = 2.0    
    public let KMATranslucentBg: CGFloat = 0.9
    
    public let performanceTitles = ["Community", "Service", "Security"]
    public let lotteryDetailsSegments = ["Parameters", "Sub Lands", "Result"]
    public let lotteryParametersSections = ["Land rules", "Sub land", "Citizens"]
    public let lotteryResultSection = ["Lottery parameters", "Lottery results"]
    public let chartsArray = ["age", "gender", "city", "property", "uploads"]
    public let nonLivingTypes = ["Services", "Parks", "Commercial"]
    public let acceptedStatuses = ["awaiting payment", "awaiting verification", "confirmed"]
    public let landCaseTitles = ["Court status", "Ministry decisions", "Municipality"]
    
    public let noNotesText = "Notes not included."
    
    // Variables for New Land Case Location
    public var KMANewLandCasePointCoordinate = CLLocationCoordinate2D()
    public var KMANewLandCasePointIndex = -1
    
    // Temp land case
    public var landCaseUpdated = KMAUILandCaseStruct()
    public var landCaseDetailsUpdated = KMAUILandCaseStruct()
    public var landCaseMasterAction = ""
    public let caseModes = ["All cases", "Regions"]
    public var newTrespassCaseId = ""
    
    // MARK: - Login variables
    public let usernameAllowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-@"
    
    // MARK: - AccuWeather
    public let accuweatherApiKey = "ieshnLrs4i3JbLXAuO97CGGS5L1on6Kz"
    // sircfc@me.com "ieshnLrs4i3JbLXAuO97CGGS5L1on6Kz"
    // sircfc+john@me.com "AXsdi3EjiJuq2eicR85FyRj9pZ4h0shH"
    // sircfc+lamps@me.com "fqCYgiPCaG5XxqPhTl3047ZCLztXY6Zk"
    
    // MARK: - Foursquare
    public let foursquareClientKey = "JWSG0SW0WKBJB0RXZXEH22YHULI1H0F1HHLBGXN21Z43GM0B"
    public let foursquareClientSecret = "W33Y0YKBGEWUTSZW3X0EIB2E5T3GMZWSJ03ODCUB2IZT0GMI"
    
    // sircfc@me.com
    // "VOXV1M5DGZ35F3UANNVUSA34EYK30EWJYGBSWQ0ZVD3GGC4K"
    // "YYRUX3MJYSNHGT54FR2PLLBQ3YUOOHK3BIS1A0VBBP2L3YRB"
    // sircfc+kma@me.com
    // JWSG0SW0WKBJB0RXZXEH22YHULI1H0F1HHLBGXN21Z43GM0B
    // W33Y0YKBGEWUTSZW3X0EIB2E5T3GMZWSJ03ODCUB2IZT0GMI
    
    // MARK: - Zoopla
    public let zooplaApiKey = "xrkapx8jfkzee5y5p8drapqy"
    // "77ercg9phrbdz8mp8mgfprdq"
    // "3kkfx7unbbewky5vx3qb7yjt"
    // "vb8sbaprpy7a85dygjdpjznf"
    //    "z2jerfddwxkye3w653muzfjy"
    
    // MARK: - Placeholder data
    public let placeholderFilesArray = [["fileURL" : "https://parsefiles.back4app.com/DX8cx1pmFMVaXRrAnO0jHq86wswN8q3oPN6yEr2W/c5cea4988678abce0b859252ca4f708d_file.jpeg",
    "fileExtension" : "JPEG",
    "createdAt" : "2020-05-28 12:28:27",
    "captureDate" : "2020-05-28 12:26:47",
    "objectId" : "XIDyL7JFS2",
    "previewURL" : "https://parsefiles.back4app.com/DX8cx1pmFMVaXRrAnO0jHq86wswN8q3oPN6yEr2W/68b719df0a2d386c5d5106cb14dcf9d9_previewImage.jpg",
    "type" : "Image",
    "fileDescription" : "The land rules for the Makkah region",
    "name" : "Land rules.jpeg",
    "updatedAt" : "2020-05-28 12:28:27"], ["name" : "Laws and regulations.jpeg",
                                           "fileExtension" : "JPEG",
                                           "updatedAt" : "2020-05-28 12:28:52",
                                           "captureDate" : "2020-05-28 12:26:19",
                                           "objectId" : "oOP68KOxw5",
                                           "previewURL" : "https://parsefiles.back4app.com/DX8cx1pmFMVaXRrAnO0jHq86wswN8q3oPN6yEr2W/759e094833d7a107241989b54b9ebefc_previewImage.jpg",
                                           "fileURL" : "https://parsefiles.back4app.com/DX8cx1pmFMVaXRrAnO0jHq86wswN8q3oPN6yEr2W/12325b7905dd4ef7597656287291c748_file.jpeg",
                                           "fileDescription" : "The additional information for the Makkah region",
                                           "type" : "Image",
                                           "createdAt" : "2020-05-28 12:28:52"], ["fileDescription" : "The Royal order by the King of Saudi Arabia",
                                                                                  "fileExtension" : "JPEG",
                                                                                  "createdAt" : "2020-05-28 12:29:21",
                                                                                  "captureDate" : "2020-05-28 12:27:04",
                                                                                  "objectId" : "zPnAzHzwPR",
                                                                                  "previewURL" : "https://parsefiles.back4app.com/DX8cx1pmFMVaXRrAnO0jHq86wswN8q3oPN6yEr2W/26565e4acca91b60f16b63864072378f_previewImage.jpg",
                                                                                  "updatedAt" : "2020-05-28 12:29:21",
                                                                                  "type" : "Image",
                                                                                  "name" : "Royal order.jpeg",
                                                                                  "fileURL" : "https://parsefiles.back4app.com/DX8cx1pmFMVaXRrAnO0jHq86wswN8q3oPN6yEr2W/96faaa689bd5568029c5b60f2678f131_file.jpeg"], ["captureDate" : "2020-05-28 12:26:37",
                                                                                                                                                                                                                       "previewURL" : "https://parsefiles.back4app.com/DX8cx1pmFMVaXRrAnO0jHq86wswN8q3oPN6yEr2W/1c4313dd90d82096e3d4831d250d44c0_previewImage.jpg",
                                                                                                                                                                                                                       "fileURL" : "https://parsefiles.back4app.com/DX8cx1pmFMVaXRrAnO0jHq86wswN8q3oPN6yEr2W/0da3cc2e9e55de536f2f510aa4e65f9d_file.jpeg",
                                                                                                                                                                                                                       "createdAt" : "2020-05-28 12:31:30",
                                                                                                                                                                                                                       "updatedAt" : "2020-05-28 12:31:30",
                                                                                                                                                                                                                       "type" : "Image",
                                                                                                                                                                                                                       "fileExtension" : "JPEG",
                                                                                                                                                                                                                       "fileDescription" : "The Land cases documents for the ownership appointment procedure",
                                                                                                                                                                                                                       "name" : "Land cases instructions.jpeg",
                                                                                                                                                                                                                       "objectId" : "4yXAqADyCf"]]
    let placeholderApprovedDecisions = ["This Land Case matches all the rules required by the *departmentName*. It's verified to be resolved as \"Approved\".", "The *departmentName* confirms the Land Case has no violations and sets the status to be \"Approved\".", "After checking all of the documents provided by the Land Case appointment the *departmentName* can guarantee it doesn't violate any rules and can be recommended for the successfull Department and Court decision."]
    let placeholderRejectedDecisions = ["The Land Case can not be approved as we see it violates several rules from the list used by the *departmentName*. We recommend the documents to be revised before proceeding with the repeated appointment.", "The *departmentName* has checked the documents provided with the Land Case appointment and cannot guarantee these are the authentic data.", "The Land Case details doesn't include the full list of documents required by the *departmentName*. Please revise the provided documentation."]
}
