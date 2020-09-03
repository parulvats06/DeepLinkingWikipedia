//
//  LocationsViewController.swift
//  WikipediaTest
//
//  Created by Parul Vats on 10/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {

 //MARK: - IBOutlets
    @IBOutlet weak var locationsTableView: UITableView! {
        didSet {
            locationsTableView.register(LocationTableViewCell.self)
            locationsTableView.separatorStyle = .singleLine
            locationsTableView.backgroundColor = .white
            locationsTableView.dataSource = dataSource
            locationsTableView.delegate = self
        }
    }
    //MARK: - Variables
    lazy var locationViewModel: LocationViewModel = {
        return LocationViewModel()
    }()
    
    private lazy var dataSource = makeDataSource()
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    //MARK: - Private Methods
    //Initial setup
    private func setup() {
        self.setSpecificNavigationProperties()
        self.bindViewModel()
    }
    
    fileprivate func setSpecificNavigationProperties() {
        self.navigationItem.title = "Locations"
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        self.navigationItem.rightBarButtonItem = addBarButton
    }

    
    //Bind view model
    private func bindViewModel() {
        locationViewModel.reloadTableClosure = { [weak self] in
            guard let sSelf = self else {
                return
            }
            DispatchQueue.main.async {
                sSelf.update(animate: true)
            }
        }
        
        locationViewModel.fetchStaticLocations()
    }
    
    //Show popup for user to enter custom location
    private func showCustomLocationPopup() {
        guard let customLocationPopup = CustomLocationPopupView.instancefromNib() else { return }
        customLocationPopup.initializeViewWith() { [weak self] (latitude, longitude) in
            guard let sSelf = self else { return }
            let location = Location(title: "Custom location", latitude: latitude, longitude: longitude)
            sSelf.openWikiAppWithLocation(location: location)
        }
        
        customLocationPopup.showWithAnimated(animated: true)
    }
    
    //MARK: - Public Methods
    //RedirectToWikipediaWithTheSelectedLocation
    func openWikiAppWithLocation(location: Location) {
        guard let latitude = location.latitude, let longitude = location.longitude, let title = location.title else {
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "wikipedia"
        urlComponents.host = "places"
        urlComponents.queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "title", value: title)
        ]
     
        if let url = urlComponents.url {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc fileprivate func addButtonClicked() {
        showCustomLocationPopup()
    }
    
    private func update(animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Location>()
        snapshot.appendSections([.main])
        snapshot.appendItems(locationViewModel.locations)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
    
    //MARK: - IBActions
    @IBAction func tapAddLocation(_ sender: UIBarButtonItem) {
        self.showCustomLocationPopup()
    }
}

//MARK: - UITableViewDelegate
extension LocationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = dataSource.itemIdentifier(for: indexPath)
        guard let unwrappedLocation = location else {
            return
        }
        openWikiAppWithLocation(location: unwrappedLocation)
    }
}

//MARK: - Extension for datasource
private extension LocationsViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<Section, Location> {

        return UITableViewDiffableDataSource(
            tableView: locationsTableView,
            cellProvider: {  tableView, indexPath, location in
                let cell: LocationTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.selectionStyle = .none
                cell.location = location
                return cell
            }
        )
    }
}

extension LocationsViewController {
    fileprivate enum Section {
        case main
    }
}

