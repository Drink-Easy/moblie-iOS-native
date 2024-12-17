//
//  TastingNoteModel.swift
//  Drink-EG
//
//  Created by 이수현 on 11/15/24.
//

import Foundation
import UIKit

struct TastingNoteModel {
    let images: UIImage
    let label: String
}

extension TastingNoteModel {
    static func dummy() -> [TastingNoteModel] {
        return [
            TastingNoteModel(images: .samos, label: "사모스"),
            TastingNoteModel(images: .samos, label: "도스 코파스"),
            TastingNoteModel(images: .samos, label: "사모스"),
            TastingNoteModel(images: .samos, label: "도스 코파스"),
            TastingNoteModel(images: .samos, label: "사모스"),
            TastingNoteModel(images: .samos, label: "도스 코파스"),
            TastingNoteModel(images: .samos, label: "사모스"),
            TastingNoteModel(images: .samos, label: "도스 코파스")
        ]
    }
}
