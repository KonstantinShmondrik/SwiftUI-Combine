//
//  APIClient.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import Foundation
import Combine

struct APIClient {
    
    enum Method {
        static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
        static let characterPath = "character/"
        
        case page(Int)
        case character(Int)
        case location
        case episode
        
        var url: URL {
            switch self {
            case .page(let num):
                let urlString = Method.baseURL.appendingPathComponent(Method.characterPath).absoluteString
                var urlComps = URLComponents(string: urlString)
                urlComps?.queryItems = [URLQueryItem(name: "page", value: "\(num)")]
                return urlComps?.url ?? Method.baseURL
            case .character(let id):
                return Method.baseURL.appendingPathComponent(Method.characterPath + String(id))
            default:
                fatalError("URL for this case is undefined.")
            }
        }
    }
    
    enum Error: LocalizedError {
        var id: String { localizedDescription }
        
        case unreachebleAdress(url: URL)
        case invalideResponse
        
        var errorDescription: String? {
            switch self {
            case .unreachebleAdress(let url):
                return "\(url.absoluteString) is urieachable"
            case .invalideResponse:
                return "response with mistake"
            }
        }
    }
    
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)
    
    func page(num: Int) -> AnyPublisher<Page, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.page(num).url)
            .handleEvents()
            .receive(on: queue)
            .map(\.data)
            .decode(type: Page.self, decoder: decoder)
            .mapError({error -> Error in
                switch error {
                case is URLError:
                        return Error.unreachebleAdress(url: Method.page(num).url)
                default:
                    return Error.invalideResponse
                }
            })
            .eraseToAnyPublisher()
    }
    
    func character(id: Int) -> AnyPublisher<Character, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.character(id).url)
            .handleEvents()
            .receive(on: queue)
            .map(\.data)
            .decode(type: Character.self, decoder: decoder)
            .mapError({error -> Error in
                switch error {
                case is URLError:
                    return Error.unreachebleAdress(url: Method.character(id).url)
                default:
                    return Error.invalideResponse
                }
            })
            .eraseToAnyPublisher()
    }
    
    func mergedCharacters(ids: [Int]) -> AnyPublisher<Character, Error> {
        precondition(!ids.isEmpty)
        
        let initialPublisher = character(id: ids[0])
        let remainder = Array(ids.dropFirst())
        
        return remainder.reduce(initialPublisher) { combined, id in
            return combined
                .merge(with: character(id: id))
                .eraseToAnyPublisher()
        }
    }
    
}
