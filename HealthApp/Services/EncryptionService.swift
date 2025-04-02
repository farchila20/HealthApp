//
//  EncryptionService.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import Foundation
import CryptoKit

class EncryptionService {
    private let key: SymmetricKey
    
    init() {
        // Key should be stored in keychain
        self.key = SymmetricKey(size: .bits256)
    }
    
    func encryptFile(at url: URL) throws -> Data {
        let fileData = try Data(contentsOf: url)
        let sealedBox = try AES.GCM.seal(fileData, using: key)
        return sealedBox.combined!
    }
    
    func decryptFile(data: Data) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
}


