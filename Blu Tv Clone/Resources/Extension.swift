//
//  Extension.swift
//  Blu Tv Clone
//
//  Created by Berna Şener on 19.08.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
