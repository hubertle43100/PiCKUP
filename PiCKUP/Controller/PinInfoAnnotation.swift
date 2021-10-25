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
        annotation = PinAnnotation( coordinate: CLLocationCoordinate2DMake(37.4324188,-122.1860571), title: "Chicago Deep Dish", subtitle: "SATURDAY: 9am - 11am")
        annotation.pinPhoto = #imageLiteral(resourceName: "SandHill")
        annotation.historyText = "Light and dark shirts is recommended. "
        annotations.append(annotation)
        
        //Monte Vista HS
        annotation = PinAnnotation( coordinate: CLLocationCoordinate2DMake(37.31555,-122.0569311), title: "Hawaiian/Canandian Pizza", subtitle: "SUNDAY: 1:30pm - 4:30pm")
        annotation.pinPhoto = #imageLiteral(resourceName: "MonteVista")
        annotation.historyText = "The so-called Hawaiian pizza is not Hawaiian -- It's Canadian. Greek immigrant  to Canada Sam Panopoulos added canned pineapple and Canadian bacon to a pizza in his small restaurant in Chatham, Canada. This is the one of the earliest pizzas without traditional Italian ingredients. As late as 2017, a few months before Panopoulos' death this was controversial, with purists angry about pineapple on a pizza. The president of Iceland started a near diplomatic incident between Canada and Iceland with his statement he would make pineapple on Pizza illegal if he could, with Canadians up in arms about their treasure."
        annotations.append(annotation)
        
        //Lynbrook HS
        annotation = PinAnnotation( coordinate: CLLocationCoordinate2DMake(37.31555,-122.0569311), title: "Hawaiian/Canandian Pizza", subtitle: "SUNDAY: 1:30pm - 4:30pm")
        annotation.pinPhoto = #imageLiteral(resourceName: "MonteVista")
        annotation.historyText = "The so-called Hawaiian pizza is not Hawaiian -- It's Canadian. Greek immigrant  to Canada Sam Panopoulos added canned pineapple and Canadian bacon to a pizza in his small restaurant in Chatham, Canada. This is the one of the earliest pizzas without traditional Italian ingredients. As late as 2017, a few months before Panopoulos' death this was controversial, with purists angry about pineapple on a pizza. The president of Iceland started a near diplomatic incident between Canada and Iceland with his statement he would make pineapple on Pizza illegal if he could, with Canadians up in arms about their treasure."
        annotations.append(annotation)
        
    }
}
