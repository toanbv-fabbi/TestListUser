//
//  DetailUserViewController.swift
//  Test
//
//  Created by cmc on 14/12/2022.
//

import UIKit
import MapKit
import SafariServices
import MessageUI

class DetailUserViewController: UIViewController {
    
    @IBAction func emailClick(_ sender: Any) {
        guard let email = infoUserDetail.email else { return }
        if MFMailComposeViewController.canSendMail() { // only work on real device
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("<p>Hello</p>", isHTML: true)
            present(mail, animated: true)
        }
    }
    @IBOutlet weak var emailButton: UIButton!
    @IBAction func websiteClick(_ sender: Any) {
        guard var website = infoUserDetail.website else { return }
        if !website.lowercased().hasPrefix("https://") {
            website = "https://".appending(website)
        }
        guard let url = URL(string: website) else { return }
        let webVC = SFSafariViewController(url: url)
        webVC.modalPresentationStyle = .pageSheet
        present(webVC, animated: true)
    }
    @IBOutlet weak var websiteButton: UIButton!
    @IBAction func phoneClick(_ sender: Any) {
        guard let phone = infoUserDetail.phone else { return }
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var locationView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    var infoUserDetail: InfoUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        commonSetup()
    }
    
    private func commonSetup() {
        locationView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let name = infoUserDetail.name {
            nameLabel.text = name
        }
        if let email = infoUserDetail.email {
            emailButton.setTitle(email, for: .normal)
        }
        if let website = infoUserDetail.website {
            websiteButton.setTitle(website, for: .normal)
        }
        if let phone = infoUserDetail.phone {
            phoneButton.setTitle(phone, for: .normal)
        }
        if let lat = Double(infoUserDetail.address?.geo?.lat ?? "0"),
           let lng = Double(infoUserDetail.address?.geo?.lng ?? "0") {
            let initialLocation = CLLocation(latitude: lat, longitude: lng)
            locationView.centerToLocation(initialLocation)
            let london = MKPointAnnotation()
            london.title = "VN"
            london.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            locationView.addAnnotation(london)
        }
        
    }
    
}
extension DetailUserViewController: MKMapViewDelegate, MFMailComposeViewControllerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
