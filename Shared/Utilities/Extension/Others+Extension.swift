//
//  Others+Extension.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import UIKit

extension String {
    
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }


}

extension Decodable {
    
    static func decode(data: Data?) -> Self? {
        guard let data = data else { return nil }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Self.self, from: data)
        } catch(let error) {
            print(error)
            return nil
        }
    }
}

extension Encodable {
    
    func encode() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do { return try encoder.encode(self) } catch let error {
            showToast(message: error.localizedDescription)
            return nil
        }
    }
    
    var postDictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
    var postArray: [[String: Any]] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [[String: Any]] ?? [[:]]
    }
    
    var paramString: String {
        let strFromDict = (postDictionary.compactMap ({ (key ,value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
        return "?" + strFromDict
    }
    
    
}



