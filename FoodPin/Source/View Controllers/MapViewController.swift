//
//  MapViewController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/31/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: StateController, MKMapViewDelegate {

    @IBOutlet weak var mapView : MKMapView!
    var restaurant : Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurant = modelController.selectedRestaurant
        
        // -- Configure mapView to show traffic, scale and compass
        mapView.showsTraffic = true
        mapView.showsScale = true
        mapView.showsCompass = true
        
        // -- Assign the MapViewController as the delegate object for the MapView
        // -- So that MapView looks for and uses the custom implementation of methods required to call and display the AnnotationView on itself
        mapView.delegate = self

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: {
            placemarks, error in
            if error != nil {
                print(error)
                return
            }
            
            if let returnedPlacemarks = placemarks {
                // -- Get the first placemark
                let placemark = returnedPlacemarks[0]
                
                // -- Create a new annotation object
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                annotation.coordinate = placemark.location!.coordinate
                
                // -- Display the annotation on the Map
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- This method is called by the MapView before PREPARING and DISPLAYING the AnnotationView on itself
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        /*  
            -- For performance reasons, it is preferred to reuse any existing annotation view instead of creating a new one.
            -- The map view is intelligent enough to cache unused annotation views that it isn't using.
        */
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        /*  
            -- If no unused annotation view is available, dequeueReusableAnnotationViewWithIdentifier() will return nil
            -- In that case create a new annotation view of type MKPinAnnotationView
            -- 'cuz we want to show the Pin view on the Map
        */
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        }
        
        let leftImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 55.0, 55.0))
        leftImageView.image = UIImage(data: restaurant.image!)
        annotationView!.leftCalloutAccessoryView = leftImageView
        annotationView!.pinTintColor = UIColor.purpleColor()
        
        return annotationView
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
