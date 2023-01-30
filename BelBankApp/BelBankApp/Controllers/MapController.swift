//
//  MapController.swift
//  BelBankApp
//
//  Created by Александра on 30.01.23.
//

import UIKit
import GoogleMaps
import CoreLocation
import GoogleMapsUtils

class MapController: UIViewController {
    
    typealias FilterTypes = String
    
    private var cities: [String] = []
    private var filter: [FilterTypes] = ["ATM", "Fillials", "All"]
    private var atmsMarkers = [GMSMarker]()
    private var fillialsMarkers = [GMSMarker]()
    private let locationManager = CLLocationManager()
    private var clusterManager: GMUClusterManager!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var citiesCollectionView: UICollectionView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    
    var markers = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllBanks()
        mapView.delegate = self
        setUpCollectionViews()
        initGoogleMap()
        initLocationManager()
        initCluster()
    }
    
    private func initGoogleMap() {
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }
    
    private func initLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
        
//        BelarusBankProvider().getATMs(city: "") { bank in
//            self.setAtmMarkers(bank)
//        }
        
        BelarusBankProvider().getFillials(city: "") { bank in
            self.getAllCities(banks: bank)
        }

        let locationManger = CLLocationManager()
        locationManger.requestAlwaysAuthorization()
    }
    
    private func initCluster() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager.setMapDelegate(self)
    }
    
    private func setAtmMarkers(_ atms: [ATMModel]) {
        atms.forEach { atm in
            guard let latitude = Double(atm.latitude),
                  let longitude = Double(atm.longitude)
            else { return }
            
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            marker.title = "Банкомат: \(atm.id)"
            marker.snippet = "Адрес: \(atm.cityType) \(atm.city), \(atm.addressType) \(atm.address), \(atm.house)\nВремя работы: \(atm.workTime)"
            marker.icon = GMSMarker.markerImage(with: .green)
            atmsMarkers.append(marker)
        }
        
        clusterManager.add(atmsMarkers)
        if atmsMarkers.count > 0, fillialsMarkers.count > 0 {
            clusterManager.cluster()
        }
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
    
//    func calculateCollectionViewCellSize() -> CGSize {
//        let height: CGFloat = 30
//        let width: CGFloat = 2.5 * height
//        return CGSize(width: width, height: height)
//    }
    
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

extension MapController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == filtersCollectionView {
            switch filter[indexPath.row] {
                case "ATM":
                    atmsMarkers.forEach { marker in
                        self.clusterManager.add(marker)
                    }
                case "Fillials":
                    atmsMarkers.forEach { marker in
                        self.clusterManager.add(marker)
                    }
                case "All":
                    atmsMarkers.forEach { marker in
                        self.clusterManager.add(marker)
                    }
                    fillialsMarkers.forEach { marker in
                        self.clusterManager.add(marker)
                    }
                    
                default:
                    return
            }
            self.clusterManager.cluster()
            filtersCollectionView.reloadData()
        }
    }
}

extension MapController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        BelarusBankProvider().atmAdressByCity(city: cities[indexPath.row]) { atms in
            self.drawMarkersByCity(atms: atms)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = 60
        return CGSize(width: width, height: 30)
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

extension MapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locationManager.location?.coordinate
        cameraMoveToLocation(toLocation: location)
        locationManager.stopUpdatingLocation()
    }

    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        guard let toLocation else { return }

        mapView.camera = GMSCameraPosition.camera(withTarget: toLocation, zoom: 15)
    }
}
