//
//  KMAUIPoliceMapTableViewCell.swift
//  KMAUI
//
//  Created by Stanislav Rastvorov on 30.12.2019.
//  Copyright © 2019 Stanislav Rastvorov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

public class KMAUIPoliceMapTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Variables
    public var neighbourhood = KMAPoliceNeighbourhood()
    
    // MARK: - Cell methods
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Rounded corners for mapView
        mapView.layer.cornerRadius = KMAUIConstants.shared.KMACornerRadius
        mapView.clipsToBounds = true
        mapView.delegate = self
        
        // No selection required
        selectionStyle = .none
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell() {
        print("Nearby crime: \(neighbourhood.crimeNearby.count), crime: \(neighbourhood.crimeArray.count)")

        /*let point1 = CLLocationCoordinate2D(latitude: neighbourhood.minLat, longitude: neighbourhood.minLong)
        let point2 = CLLocationCoordinate2D(latitude: neighbourhood.minLat, longitude: neighbourhood.maxLong)
        let point3 = CLLocationCoordinate2D(latitude: neighbourhood.maxLat, longitude: neighbourhood.maxLong)
        let point4 = CLLocationCoordinate2D(latitude: neighbourhood.maxLat, longitude: neighbourhood.minLong)
        let rectBounds = [point1, point2, point3, point4, point1]

        let rectPolygon = KMAUIUtilities.shared.getPolygon(bounds: rectBounds)
        mapView.addOverlay(rectPolygon)*/
        
        let polygon = KMAUIUtilities.shared.getPolygon(bounds: neighbourhood.bounds)
        mapView.addOverlay(polygon)
        
        for crimeObject in neighbourhood.crimeArray {
            let annotation = MKPointAnnotation()
            annotation.coordinate = crimeObject.location
            annotation.title = crimeObject.category.capitalized.replacingOccurrences(of: "-", with: " ")
            mapView.addAnnotation(annotation)
        }
        
        /*for crimeObject in neighbourhood.crimeNearby {
            let annotation = MKPointAnnotation()
            annotation.coordinate = crimeObject.location
            annotation.title = crimeObject.category.capitalized.replacingOccurrences(of: "-", with: " ")
            mapView.addAnnotation(annotation)
        }*/
        
        // Set the visible area
        /*if !neighbourhood.crimeArray.isEmpty || !neighbourhood.crimeNearby.isEmpty {
            mapView.showAnnotations(mapView.annotations, animated: true)
        } else {*/
            var region = MKCoordinateRegion()
            var span = MKCoordinateSpan()
            span.latitudeDelta = 1.05 * (neighbourhood.maxLat - neighbourhood.minLat)
            span.longitudeDelta = 1.05 * (neighbourhood.maxLong - neighbourhood.minLong)
            
            let location = CLLocationCoordinate2D(latitude: (neighbourhood.minLat + neighbourhood.maxLat) / 2, longitude: (neighbourhood.minLong + neighbourhood.maxLong) / 2)
            
            region.span = span
            region.center = location
            
            mapView.setRegion(region, animated: true)
            mapView.regionThatFits(region)
//        }
    }
}

// MARK: - MapView extension

extension KMAUIPoliceMapTableViewCell: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = KMAUIConstants.shared.KMABrightBlueColor
            polygonView.lineWidth = 3
            
            return polygonView
        }
        
        return MKOverlayRenderer()
    }
}
