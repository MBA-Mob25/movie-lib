//
//  Movie+Various.swift
//  MoviesLib
//
//  Created by Marcelo Mussi on 02/09/22.
//

import Foundation

extension Movie {
    var ratingFormatted: String {
        "⭐️ \(rating)/10"
    }
    var imageSmall: String {
        "\(image!)small"
    }
}
