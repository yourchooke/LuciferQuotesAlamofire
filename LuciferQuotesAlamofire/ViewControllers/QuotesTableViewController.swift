//
//  QuotesTableViewController.swift
//  LuciferQuotesAlamofire
//
//  Created by Olga Yurchuk on 22.09.2022.
//

import UIKit
import Alamofire

class QuotesTableViewController: UITableViewController {
    
    
    let quotesLink = "https://lucifer-quotes.vercel.app/api/quotes/5"
    var quotes: [Quote] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 112
        NetworkManager.shared.fetchDataWithAlamofire(quotesLink) { result in
                switch result {
                case .success(let quotes):
                    self.quotes = quotes
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if quotes.isEmpty {
            return ""
        } else {
            return quotes[section].author
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quote", for: indexPath) as! QuoteTableViewCell

        if quotes.isEmpty {
            cell.configureCell()
        } else {
            let quote = quotes[indexPath.section]
            cell.configureCell(with: quote)
        }

        return cell
    }
    

}
