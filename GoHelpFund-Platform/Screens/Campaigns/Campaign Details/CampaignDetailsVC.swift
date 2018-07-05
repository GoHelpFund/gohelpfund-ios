//
//  CampaignDetails.swift
//  GoHelpFund-Platform
//
//  Created by Vlad Batrinu on 6/29/18.
//  Copyright © 2018 cacheOverflow. All rights reserved.
//

import UIKit


class CampaignDetailsVC: UIViewController {
    
    enum Section: Int {
        case galery
        case campaignDetails
        case authorDetails
        
        var numberOfRows: Int {
            switch self {
            case .campaignDetails:
                return 2
            default:
                return 1
            }
        }
        
        static var count: Int {
            return (Section.authorDetails.rawValue + 1)
        }
    }

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 160
        GalleryCell.registerNibToTableView(tableView: tableView)
        CampaignDescriptionCell.registerNibToTableView(tableView: tableView)
        AuthorDetailsCell.registerNibToTableView(tableView: tableView)
        CampaignDetailedCell.registerNibToTableView(tableView: tableView)
    }
    
    @IBAction func tapDonate(_ sender: Any) {
        
    }
    
}

extension CampaignDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { fatalError("Unexpected Section") }
        return section.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Unexpected Section") }
        let cell: UITableViewCell
        
        switch section {
        case .galery:
            cell = tableView.dequeueReusableCell(withIdentifier: GalleryCell.cellReuseIdentifier(), for: indexPath) as! GalleryCell
        case .campaignDetails:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: CampaignDescriptionCell.cellReuseIdentifier(), for: indexPath) as! CampaignDescriptionCell
            default:
                cell = tableView.dequeueReusableCell(withIdentifier: CampaignDetailedCell.cellReuseIdentifier(), for: indexPath) as! CampaignDetailedCell
            }
        case .authorDetails:
            cell = tableView.dequeueReusableCell(withIdentifier: AuthorDetailsCell.cellReuseIdentifier(), for: indexPath) as! AuthorDetailsCell

        }
        return cell
    }
}
