//
//  PinDetail.swift
//  PiCKUP
//
//  Created by Hubert Le on 10/19/21.
//

import UIKit
import MapKit

class PizzaAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var identifier = "Pin"
    var historyText = ""
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
