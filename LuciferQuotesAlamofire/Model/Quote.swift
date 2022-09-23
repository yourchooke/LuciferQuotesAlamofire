//
//  Quotes.swift
//  LuciferQuotesAlamofire
//
//  Created by Olga Yurchuk on 22.09.2022.
//

import Foundation

struct Quote: Decodable {
    let quote: String?
    let author: String?
    
    init(quoteData: [String: Any]) {
        self.quote = quoteData["quote"] as? String
        self.author = quoteData["author"] as? String
    }
    
    static func getQuotes(from value: Any) -> [Quote] {
        guard let quotesData = value as? [[String: Any]] else { return [] }
        var quotes: [Quote] = []
        for quoteData in quotesData {
            let quote = Quote(quoteData: quoteData)
        quotes.append(quote)
        }
        return quotes
    }
}

enum Author: String {
    case lucifer = "Lucifer Morningstar"
    case chloe = "Chloe Decker"
    case amenadiel = "Amenadiel"
    case mazikeen = "Mazikeen Smith"
    case dan = "Dan Espinoza"
    case linda = "Linda Martin"
    case trixie = "Trixie"
}
