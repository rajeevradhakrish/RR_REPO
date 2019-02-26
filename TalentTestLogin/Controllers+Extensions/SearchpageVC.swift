//
//  SearchpageVC.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 25/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import UIKit

class SearchpageVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {
    
    
    var countryDetArray = [CountryModel]()
    var searchListArray = [CountryModel]()
    let searchController = UISearchController(searchResultsController: nil)
    private let cellId = "cellId"
    lazy var searchTable: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountryDetails()
        title = "Country/Region"
        view.backgroundColor = .white
        view.addSubview(searchTable)
        setupAutoLayout()
        //setUPBarButton()
        addSearchUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:- Private functions
    
    private func addSearchUI()
    {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.barTintColor = UIColor.white
        searchTable.tableHeaderView = searchController.searchBar
    }
    
    private func setUPBarButton()
    {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "close"),
                            style: .plain,
                            target: self,
                            action: #selector(closeUI))
        ]
    }
    
    @objc func closeUI()
    {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func setupAutoLayout() {
        
        searchTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func loadCountryDetails()
    {
        ActivityIndicator.shared.showLoader(onView: self.view)
        AlamofireHelper.fetchRequest(urlString: Configuration.countryAPI, parameters: nil, completion: {
            [weak self] array in
            guard let sSelf = self else {return}
            ActivityIndicator.shared.removeLoader()
            if let countryArr = array
            {
                for country in countryArr
                {
                    sSelf.countryDetArray.append(CountryModel(with: country))
                }
                sSelf.searchListArray = sSelf.countryDetArray
                sSelf.searchTable.reloadData()
            }
        })
    }
    
    private func filterSearchResult(with key:String)
    {
        if key=="" && key.count == 0
        {
            searchListArray = countryDetArray
        }
        else
        {
            searchListArray=countryDetArray.filter({$0.name.contains(key)})
        }
        searchTable.reloadData()
    }
    
    //MARK:- Update search result Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterSearchResult(with: searchController.searchBar.text ?? "")
    }
    
    // MARK :- Tableview Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let country = searchListArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.themeColor
        cell.textLabel?.text =  " +(\(country.code)) " + country.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let country = searchListArray[indexPath.row]
        if let home = navigationController?.viewControllers[0] as? LoginPageVC
        {
            home.selectedCountry = country
        }
        searchController.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
