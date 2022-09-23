//
//  QuoteTableViewCell.swift
//  LuciferQuotesAlamofire
//
//  Created by Olga Yurchuk on 23.09.2022.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    func configureCell() {
        quoteLabel.text = "wait!"
        authorImageView.image = UIImage.init(named: "mainPicLaunch")
    }
    
    func configureCell(with quote: Quote) {
        quoteLabel.text = quote.quote
        NetworkManager.shared.fetchImage(from: quote, completion: { result in
            switch result {
            case .success(let imageData):
                self.authorImageView.image = UIImage(data: imageData)
                print(self.authorImageView.image?.size ?? 0)
            case .failure(let error):
                print(error)
            }
        })
    }


}
