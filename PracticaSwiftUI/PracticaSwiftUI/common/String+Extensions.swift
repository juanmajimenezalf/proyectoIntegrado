//
//  String.swift
//  ForgotPassword
//
//  Created by Juan Manuel Jimenez Alfaro on 8/11/22.
//

import Foundation

public extension String {
    enum TypeOfDocument {
        case dni(number: String)
        case nie(number: String)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    
    func validation(document: TypeOfDocument) -> Bool {
        switch document {
        case .dni:
            return self.validateDNI(candidateDNI: self)
        case .nie:
            return self.validateNIE(candidateNIE: self)
        }
    }
    
    func validateDNI(candidateDNI: String) -> Bool {
        guard candidateDNI.count > 7 else { return false }
        let buffer = NSMutableString(string: candidateDNI)
        let opts = NSString.CompareOptions()
        let rng = NSMakeRange(0, 1)
        buffer.replaceOccurrences(of: "X", with: "0", options: opts, range: rng)
        buffer.replaceOccurrences(of: "Y", with: "1", options: opts, range: rng)
        buffer.replaceOccurrences(of: "Z", with: "2", options: opts, range: rng)
        
        if let baseNumber = Int(buffer.substring(to: 8)) {
            let letterMap1 = "TRWAGMYFPDXBNJZSQVHLCKET"
            let letterMap2 = "TRWAGMYFPDXBNJZSQVHLCKET".lowercased()
            
            let letterIdx = baseNumber % 23
            
            //Find case sensitive letter
            var expectedLetter = letterMap1[letterMap1.index(letterMap1.startIndex, offsetBy: letterIdx)]
            var providedLetter = candidateDNI[candidateDNI.index(before: candidateDNI.endIndex)]
            
            if(expectedLetter == providedLetter){
                return true
            }else{
                expectedLetter = letterMap2[letterMap2.index(letterMap2.startIndex, offsetBy: letterIdx)]
                providedLetter = candidateDNI[candidateDNI.index(before: candidateDNI.endIndex)]
                
                return expectedLetter == providedLetter
            }
            
        } else {
            return false
        }
    }
    
    func validateNIE(candidateNIE: String) -> Bool {
        return self.validateDNI(candidateDNI: candidateNIE)
    }
}
