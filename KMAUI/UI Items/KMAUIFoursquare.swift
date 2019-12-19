//
//  KMAUIFoursquare.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 18.12.2019.
//  Copyright © 2019 Stanislav Rastvorov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// This class represents the method to communicate with the Foursquare Places API
public class KMAUIFoursquare {
    
    // Access variable
    public static let shared = KMAUIFoursquare()
    
    /**
     Get version value - this is a value required by Foursquare API to get the latest updated data, loading the current date
     */
    
    public func getVersion() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateValue = dateFormatter.string(from: Date())
        
        return dateValue
    }
    
    /**
     Get venues from places
     */
    
    public func getVenues(jsonString: String) -> [KMAFoursquareVenue] {
        var foursquareVenues = [KMAFoursquareVenue]()
                
        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false),
            let json = try? JSON(data: dataFromString).dictionary,
            let response = json["response"]?.dictionary,
            let group = response["group"]?.dictionary,
            let results = group["results"]?.array, !results.isEmpty {
            
            for venue in results {
                var venueObject = KMAFoursquareVenue()
                venueObject.fillFrom(venue: venue)
                foursquareVenues.append(venueObject)
                
                // Currently, let's limit the venues count to 5
                if foursquareVenues.count == 5 {
                    break
                }
            }
        }
        
        return foursquareVenues
    }
    
    /**
     Get the nearby venues by the location is 1 km radius
     */
    
    public func foursquareVenues(location: String, completion: @escaping (_ places: [KMAFoursquareVenue], _ jsonString: String, _ error: String)->()) {
        let requestString = "https://api.foursquare.com/v2/search/recommendations?ll=\(location)&radius=1000&categoryId=4d4b7105d754a06374d81259&limit=10&openNow=true&intent=food&client_id=\(KMAUIConstants.shared.foursquareClientKey)&client_secret=\(KMAUIConstants.shared.foursquareClientSecret)&v=\(KMAUIFoursquare.shared.getVersion())"

        AF.request(requestString).responseJSON { response in
            if let responseData = response.data {
                do {
                    let json = try JSON(data: responseData)
                    
                    if let jsonString = json.rawString() {
                        let venues = self.getVenues(jsonString: jsonString)
                        completion(venues, jsonString, "")
                    }
                } catch {
                    completion([KMAFoursquareVenue](), "", error.localizedDescription)
                }
            }
        }
    }
    
    /**
     Get the venues in the bounds provided
     */
    
    public func foursquareVenues(bounds: String, completion: @escaping (_ venues: [JSON], _ error: String)->()) {
        let requestString = "https://api.foursquare.com/v2/venues/search?\(bounds)&categoryId=4d4b7105d754a06374d81259&intent=browse&client_id=\(KMAUIConstants.shared.foursquareClientKey)&client_secret=\(KMAUIConstants.shared.foursquareClientSecret)&v=\(KMAUIFoursquare.shared.getVersion())"
        AF.request(requestString).responseJSON { response in
            if let responseData = response.data {
                do {
                    let json = try JSON(data: responseData)
                    
                    if let repsonseValue = json["response"].dictionary, let venues = repsonseValue["venues"]?.array, !venues.isEmpty {
                        completion(venues, "")
                    }
                } catch {
                    print([JSON](), error.localizedDescription)
                }
            }
        }
    }
    
    /**
     Loading the Foursquare venue details
     */
    
    public func foursquareVenueDetails(foursquareId: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyymmdd"
        let dateValue = dateFormatter.string(from: Date())
        print(dateValue)
        // Preparing the request screen
        let requestString = "https://api.foursquare.com/v2/venues/\(foursquareId)?client_id=\(KMAUIConstants.shared.foursquareClientKey)&client_secret=\(KMAUIConstants.shared.foursquareClientSecret)&v=\(KMAUIFoursquare.shared.getVersion())"
        // The venues request
        AF.request(requestString).responseJSON { response in
            if let responseData = response.data {
                do {
                    let json = try JSON(data: responseData)
                    print("Foursquare venue \(foursquareId).")
                    print(json)
                    /**
                     What data do we need?
                     Name
                     Best Photo
                     Rating
                     Price level
                     Likes count
                     Formatted address
                     Here now
                     Accept credit cards
                     Menu types
                     Photos
                     Categories
                     */
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - Foursquare venue struct

public struct KMAFoursquareVenue {
    public var name = ""
    public var category = ""
    public var categoryPrefix = ""
    public var categorySuffix = ""
    public var latitude: Double = 0.0
    public var longitude: Double = 0.0
    public var distance: Int = 0
    public var address = ""
    public var prefix = ""
    public var suffix = ""
    public var venueId = ""
    
    public init() {
    }
    
    public init(name: String, category: String, categoryPrefix: String, categorySuffix: String, latitude: Double, longitude: Double, address: String, prefix: String, suffix: String, venueId: String) {
        self.name = name
        self.category = category
        self.categoryPrefix = categoryPrefix
        self.categorySuffix = categorySuffix
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.prefix = prefix
        self.suffix = suffix
        self.venueId = venueId
    }
    
    public mutating func fillFrom(venue: JSON) {
        if let venue = venue.dictionary {
            print(venue)
            
            if let id = venue["id"]?.string {
                self.venueId = id
            }
            
            if let venueData = venue["venue"]?.dictionary {
                // name
                if let name = venueData["name"]?.string {
                    self.name = name
                }
                // category
                if let categories = venueData["categories"]?.array {
                    for category in categories {
                        if let category = category.dictionary, let primary = category["primary"]?.bool, primary, let categoryName = category["name"]?.string {
                            self.category = categoryName
                            
                            if let icon = category["icon"]?.dictionary {
                                if let prefix = icon["prefix"]?.string {
                                    self.categoryPrefix = prefix
                                }
                                
                                if let suffix = icon["suffix"]?.string {
                                    self.categorySuffix = suffix
                                }
                            }
                        }
                    }
                }
                // address
                if let location = venueData["location"]?.dictionary {
                    // latitude
                    if let lat = location["lat"]?.double {
                        self.latitude = lat
                    }
                    // longitude
                    if let lng = location["lng"]?.double {
                        self.longitude = lng
                    }
                    // formatted address
                    if let formattedAddress = location["formattedAddress"]?.array {
                        var address = ""
                        
                        for addressLine in formattedAddress {
                            if let addressLine = addressLine.string, !addressLine.isEmpty {
                                if address.isEmpty {
                                    address = addressLine
                                } else {
                                    address += ", " + addressLine
                                }
                            }
                        }
                        
                        self.address = address
                    }
                    // distance
                    if let distance = location["distance"]?.int {
                        self.distance = distance
                    }
                }
                
            }
            
            // photo
            if let photoDict = venue["photo"]?.dictionary {
                // prefix
                if let prefix = photoDict["prefix"]?.string {
                    self.prefix = prefix
                }
                // suffix
                if let suffix = photoDict["suffix"]?.string {
                    self.suffix = suffix
                }
            }
        }
    }
}
