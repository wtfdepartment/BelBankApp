//
//  MapController.swift
//  BelBankApp
//
//  Created by Александра on 30.01.23.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapController: UIViewController {
    
    typealias FilterTypes = String
    
    private var cities: [String] = []
    private var filter: [FilterTypes] = ["ATM", "Fillials", "All"]
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var citiesCollectionView: UICollectionView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    
    var markers = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllBanks()
        mapView.delegate = self
        setUpCollectionViews()
    }
    
    private func getAllCities(banks: [BankModel]) {
        for bank in banks {
            guard let city = bank.city else { return }
            if !cities.contains(city) {
                cities.append(city)
            }
        }
        citiesCollectionView.reloadData()
    }
    
    
    private func getAllBanks() {
        BelarusBankProvider().bankAdress { bank in
            self.getAllCities(banks: bank)
        }
        let locationManger = CLLocationManager()
        locationManger.requestAlwaysAuthorization()
    }
    
    private func drawMarkers(to location: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: location)
        marker.map = mapView
//        marker.map?.isMyLocationEnabled = (mapView != nil)
        markers.append(marker)
    }
    
    private func setUpCollectionViews() {
        citiesCollectionView.delegate = self
        citiesCollectionView.dataSource = self
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
        
        let nib = UINib(nibName: String(describing: MapCollectionViewCell.self), bundle:    nil)
        let id = String(describing: MapCollectionViewCell.self)
        citiesCollectionView.register(nib, forCellWithReuseIdentifier: id)
        filtersCollectionView.register(nib, forCellWithReuseIdentifier: id)
    }
    
    func calculateCollectionViewCellSize() -> CGSize {
        let height: CGFloat = 50
        let width: CGFloat = 2.5 * height
        return CGSize(width: width, height: height)
    }
    
    private func drawMarkersByCity(atms: [BankModel]) {
        mapView.clear()
        for atm in atms {
            guard let lat = atm.lat, let lon = atm.lon else { return }
            guard let doubleLat = Double(lat), let doubleLon = Double(lon) else { return }
            drawMarkers(to: CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLon))
                    
        }
    }
}

extension MapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return true
    }
}

extension MapController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        BelarusBankProvider().atmAdressByCity(city: cities[indexPath.row]) { atms in
            self.drawMarkersByCity(atms: atms)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateCollectionViewCellSize()
    }
}

extension MapController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case filtersCollectionView:
                return filter.count
            case citiesCollectionView:
                return cities.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MapCollectionViewCell.self), for: indexPath)
        guard let mapCell = cell as? MapCollectionViewCell else { return cell }
        
        //        if collectionView == citiesCollectionView {
        //            mapCell.setUpCell(title: cities[indexPath.row])
        let text: String = {
            switch collectionView {
                case self.filtersCollectionView:
                    return self.filter[indexPath.row]
                case self.citiesCollectionView:
                    return self.cities[indexPath.row]
                default:
                    return ""
            }
        }()
        mapCell.setUpCell(title: text)
        return mapCell
    }
}
