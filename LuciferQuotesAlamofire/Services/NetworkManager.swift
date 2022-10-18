//
//  NetworkManager.swift
//  LuciferQuotesAlamofire
//
//  Created by Olga Yurchuk on 22.09.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let quotesLink = "https://lucifer-quotes.vercel.app/api/quotes/5"
    
    init() {}
    
    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<[Quote], NetworkError>) -> Void) {
        AF.request(quotesLink).validate().responseJSON { dataResponse in
            switch dataResponse.result {
            case .success(let value):
                let quotes = Quote.getQuotes(from: value)
                DispatchQueue.main.async {
                    completion(.success(quotes))
                }
            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }

    
// В прошлой домашке было замечание по поводу сопоставления строк в свитч, имелось в виду вот так делать?
    func fetchImageAdress(quote: Quote) -> String {
        switch quote.author {
        case Author.lucifer.rawValue: return AuthorPicLinks.lucifer.rawValue
        case Author.chloe.rawValue: return AuthorPicLinks.chloe.rawValue
        case Author.amenadiel.rawValue: return AuthorPicLinks.amenadiel.rawValue
        case Author.mazikeen.rawValue: return AuthorPicLinks.mazikeen.rawValue
        case Author.dan.rawValue: return AuthorPicLinks.dan.rawValue
        case Author.linda.rawValue: return AuthorPicLinks.linda.rawValue
        case Author.trixie.rawValue: return AuthorPicLinks.trixie.rawValue
        default: return AuthorPicLinks.unknown.rawValue
        }
    }
    
    func fetchImage(from quote: Quote, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        let imgLink = fetchImageAdress(quote: quote)
        guard let url = URL(string: imgLink) else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

enum AuthorPicLinks: String, CaseIterable {
    case lucifer = "https://images.immediate.co.uk/production/volatile/sites/3/2021/05/LUCIFER_6_TOM_ELLIS-0364e96.jpg"
    case chloe = "https://images.immediate.co.uk/production/volatile/sites/3/2021/05/LUCIFER_SEASON_6_CHLOE_LAUREN_GERMAN-c667bea.jpg"
    case amenadiel =  "https://images.immediate.co.uk/production/volatile/sites/3/2021/05/LUCIFER_6_DB_WOODSIDE_AMENADIEL-2-f000546.jpg"
    case mazikeen = "https://images.immediate.co.uk/production/volatile/sites/3/2021/05/LUCIFER_SEASON_6_MAZE-262e1bc.jpg"
    case dan = "https://images.immediate.co.uk/production/volatile/sites/3/2020/08/LUCIFER_kevin_alejandro_dan_espinoza-85e619d.jpg"
    case linda = "https://images.immediate.co.uk/production/volatile/sites/3/2021/05/LUCIFER_SEASON_6_LINDA-05bf493.jpg"
    case trixie = "https://images.immediate.co.uk/production/volatile/sites/3/2020/09/trixie_lucifer_netflix-15675ae.jpg"
    case unknown = "https://images.immediate.co.uk/production/volatile/sites/3/2021/08/Lucifer_season_6_cast-8338d9f.jpg"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
