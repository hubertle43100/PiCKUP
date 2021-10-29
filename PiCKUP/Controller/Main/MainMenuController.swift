//
//  MainMenuController.swift
//  PiCKUP
//
//  Created by Hubert Le on 6/11/21.
//

import UIKit
import MapKit
import CoreLocation

class MainMenuController: UIViewController {
    
    var coordinate2D = CLLocationCoordinate2DMake(37.2970523,-121.9574964) //San Jose
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeter: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorization()
        mapView.delegate = self
        mapView.addAnnotations(PinInfoAnnotations().annotations)
        //updateMapRegion(rangeSpan: 20000) //Center camera in SJ
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension MainMenuController: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
            mapView.setRegion(region, animated: true)
        }
    }
    func updateMapRegion(rangeSpan:CLLocationDistance){
        let region = MKCoordinateRegion(center: coordinate2D, latitudinalMeters: rangeSpan, longitudinalMeters: rangeSpan)
        mapView.region = region
    }
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        //case - decision user chose when presented with (allow)location?
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            centerViewOnUserLocation()}
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        _ = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
extension MainMenuController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is PinAnnotation else { return nil }
        
        let identifier = "PinAnnotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc = AnnotationDetailViewController(nibName: "AnnotationDetailViewController", bundle: nil)
                    vc.annotation = (view.annotation as! PinAnnotation)
                    present(vc, animated: true, completion: nil)
    }
    
    
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        var annotationView = MKAnnotationView()
    //        guard let annotation = annotation as? PinAnnotation
    //        else{
    //                return nil
    //        }
    //        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) {
    //            annotationView = dequedView
    //        } else {
    //            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
    //        }
    //        annotationView.canShowCallout = true
    //        let paragraph = UILabel()
    //        paragraph.numberOfLines = 0
    //        paragraph.font = UIFont.preferredFont(forTextStyle: .caption1)
    //        paragraph.text = annotation.subtitle
    //        paragraph.numberOfLines = 1
    //        paragraph.adjustsFontSizeToFitWidth = true
    //        annotationView.detailCalloutAccessoryView = paragraph
    //        annotationView.leftCalloutAccessoryView = UIImageView(image: annotation.pinPhoto)
    //        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)
    //        return annotationView
    //    }
}

