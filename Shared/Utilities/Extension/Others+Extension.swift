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
    func empty() -> Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    func isValidNumber() -> Bool {
        let RegEx   = "^((\\+)|(00))[0-9]{10,13}$"
        let eTest   = NSPredicate(format:"SELF MATCHES %@", RegEx)
        let result  = eTest.evaluate(with: self)
        return result;
    }
    
    
    func withBoldText(boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
    static var quotes: (String, String) {
        guard
            let bQuote = Locale.current.quotationBeginDelimiter,
            let eQuote = Locale.current.quotationEndDelimiter
        else { return ("\"", "\"") }
        
        return (bQuote, eQuote)
    }
    
    var quoted: String {
        let (bQuote, eQuote) = String.quotes
        return bQuote + self + eQuote
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func chunkFormatted(withChunkSize chunkSize: Int = 4,
                        withSeparator separator: Character = "-") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
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


extension Date {
    func dayOfWeek() -> String? {
        let dayNumberOfWeek = Calendar.current.dateComponents([.weekday], from: self).weekday
        
        switch dayNumberOfWeek {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return ""
        }
    }
}

extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
