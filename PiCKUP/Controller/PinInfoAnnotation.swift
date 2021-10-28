//
//  PinInfoAnnotation.swift
//  PiCKUP
//
//  Created by Hubert Le on 10/19/21.
//

import UIKit
import CoreLocation

class PinInfoAnnotations{
    var annotations:[PinAnnotation] = []
    init(){
        //Creekside Park
        var annotation = PinAnnotation( coordinate: CLLocationCoordinate2DMake(37.3164, 122.0158), title: "Creekside Park", subtitle: "SUNDAY: 2pm - 5pm")
        annotation.pinPhoto = #imageLiteral(resourceName: "Creekside.jpeg")
        annotation.historyText = "When you enter the park, you can see us with the big orange goals. The condition of the field is quite bumpy so do not expect quality ball play. We bring good amount of donated water and sometimes gatorade but more donations is appreciated. We play from 2pm to 5pm and make sure to bring two shirts one white and black(light and dark)"
        self.annotations.append(annotation)
        
        //Lone Hill Park
        annotation = PinAnnotation( coordinate: CLLocationCoordinate2DMake(37.2455787,-121.9130532), title: "Lone Hill Park", subtitle: "SATURDAY: 9am - 11am")
        annotation.pinPhoto = #imageLiteral(resourceName: "lonehill")
        annotation.historyText = "This place is normally a bit muddy on wet days but other than that this place serves well for anyone trying to get back into soccer since we get about 10 players each week. We provide pinnies so feel free to bring just your soccer stuff."
        annotations.append(annotation)
        
        //Sand Hill Fields
        annotation = PinAnnotation( coordinate: CLLocationCoordinate2DMake(37.4324188,-122.1860571), title: "Sand Hill Fields", subtitle: "SATURDAY: 9am - 11am")
        annotation.pinPhoto = #imageLiteral(resourceName: "SandHill")
        annotation.historyText = "Bring two shirts light and dark please. If we get enough players to come then we would use full goals provided. Some players in the past have trouble finding the field so to clarify the location a bit, you can simply look for the Standford hospital in Menlo Park. The soccer field is directly behind it so you should not miss it. Looking forward to playing with you. "
        annotations.append(annotation)
        
        //Monte Vista HS
        annotation = PinAnnotation( coordinate: CLLocationCoordinate2DMake(37.31555,-122.0569311), title: "Monte Vista HS", subtitle: "SUNDAY: 1:30pm - 4:30pm")
        annotation.pinPhoto = #imageLiteral(resourceName: "MonteVista")
        annotation.historyText = "TURF! TURF! TURF! We tend to get some younger players here so expect the pace of the game to be a bit fast. REMINDER: bring light/dark shirts."
        annotations.append(annotation)
        
        //Lynbrook HS
        annotation = PinAnnotation( coordinate: CLLocationCoordinate2DMake(37.31555,-122.0569311), title: "Lynbrook HS", subtitle: "SUNDAY: 1:30pm - 4:30pm")
        annotation.pinPhoto = #imageLiteral(resourceName: "MonteVista")
        annotation.historyText = "Short field turf field games here. Get ready to get the exercise of your life because we play like it's indoor soccer. Have fun and bring balls if you can. Thanks!"
        annotations.append(annotation)
        
    }
}
