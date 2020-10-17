//
//  Prayer.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/9/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

struct Content: Codable {
    let content: [Prayer]

    enum CodingKeys: String, CodingKey {
        case content = "Content"
    }
}

// MARK: - ContentElement
struct PrayerItem: Codable, Identifiable {
    let id: Int
    let arabicText, languageArabicTranslatedText, translatedText: String?
    let contentREPEAT: Int
    let audio: String
    let text: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case arabicText = "ARABIC_TEXT"
        case languageArabicTranslatedText = "LANGUAGE_ARABIC_TRANSLATED_TEXT"
        case translatedText = "TRANSLATED_TEXT"
        case contentREPEAT = "REPEAT"
        case audio = "AUDIO"
        case text = "Text"
    }
}

extension PrayerItem: Hashable {
    static func == (lhs: PrayerItem, rhs: PrayerItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(id)
    }
}

typealias Prayer = [String: [PrayerItem]]


