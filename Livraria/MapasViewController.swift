//
//  MapasViewController.swift
//  Livraria
//
//  Created by IOS on 02/06/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapasViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapa: MKMapView!
    
    let locationManager : CLLocationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        searchBar.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 500.0
        
        // Heading - 11/12
        locationManager.headingFilter = 5.0
        
        locationManager.requestWhenInUseAuthorization()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    func searchBarSearchButtonClicked(searchBar : UISearchBar) {
 
        let locationRequest:MKLocalSearchRequest = MKLocalSearchRequest()
        
        locationRequest.naturalLanguageQuery = searchBar.text!
        
        if let ul = self.locationManager.location{
            locationRequest.region = MKCoordinateRegionMakeWithDistance(ul.coordinate, 3_000, 3_000)
        }
        
        let locationSearch:MKLocalSearch = MKLocalSearch(request: locationRequest)
        
        locationSearch.startWithCompletionHandler({
            response, error in
            
            if let res = response{
                var locais:[LivrariaAnnotation] = []
                
                for item in res.mapItems{
                    
                    let livraria = LivrariaAnnotation(coordinate: item.placemark.coordinate, title: item.placemark.title ?? "Vazio", subtitle: "B")
                    
                    locais.append(livraria)
                }
                
                self.mapa.removeAnnotations(self.mapa.annotations)
                self.mapa.showAnnotations(locais, animated: true)
                
                searchBar.resignFirstResponder()
            }
            else{
                let alerta:UIAlertController = UIAlertController(title: "Erro", message: "Não foi possível encontrar o endereço", preferredStyle: UIAlertControllerStyle.Alert)
                
                alerta.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { action in print("Cancelou") }))
                
                alerta.addAction(UIAlertAction(title: "Permitir", style: UIAlertActionStyle.Default, handler: { action in print("Permitiu") }))
                
                self.presentViewController(alerta, animated: true, completion: nil)
            }
        })
    }
    
    // gesto
    
    @IBAction func marcarPino(sender: AnyObject) {
        let gesto: UILongPressGestureRecognizer = sender as! UILongPressGestureRecognizer
        
        if (gesto.state == .Ended) {
            let tappedPoint: CGPoint = gesto.locationInView(self.mapa)
            let coordenada: CLLocationCoordinate2D = self.mapa.convertPoint(tappedPoint, toCoordinateFromView: self.mapa)
            let pin: LivrariaAnnotation = LivrariaAnnotation(coordinate: coordenada, title: "Pino", subtitle: "Meu pino")
            self.mapa.addAnnotation(pin)
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccessoryControlTapped")
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView: MKAnnotationView?
        
        if(!annotation.isKindOfClass(MKUserLocation.classForCoder())){
            let livrariaAnnotation: LivrariaAnnotation = annotation as! LivrariaAnnotation
            
            if let pin = mapa.dequeueReusableAnnotationViewWithIdentifier("pinLivraria"){
                
                pinView = pin
            }
            else{
                pinView = MKPinAnnotationView(annotation: livrariaAnnotation, reuseIdentifier: "pinLivraria")
                
                pinView!.canShowCallout = true
                
                //pinView!.image = UIImage(named: "newIcon_40.png")
                
                //pinView!.centerOffset = CGPointMake(0, (-1) * (pinView!.image!.size.height / 2))
                
                let btnPin: UIButton = UIButton(type: .DetailDisclosure)
                pinView!.rightCalloutAccessoryView = btnPin
                
            }
        }
        
        return pinView
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locationManager.location {
            self.mapa.setRegion(MKCoordinateRegionMakeWithDistance(loc.coordinate, 600, 800), animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
