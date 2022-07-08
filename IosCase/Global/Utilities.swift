//
//  Utilities.swift
//  IosCase
//
//  Created by Ufuk Anıl Özlük on 8.07.2022.
//

import UIKit
import ImageSlideshow

enum DateConvertType: Int{
    case toStr
    case toDate
    case strToStr
}


func addPics(_ data: [String], on view: ImageSlideshow) {
    var alamofireSource: [AlamofireSource] = []
    for pic in data {
        alamofireSource.append(AlamofireSource(urlString: pic)!)
    }
    
    view.setImageInputs(alamofireSource)
    view.contentScaleMode = UIView.ContentMode.scaleToFill
}

func dateFormatter(to date: DateConvertType, value: Any, inputFormat: String = "yyyy-MM-dd", outputFormat: String = "dd.MM.yyyy HH:mm") throws -> Any {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en-US")
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = inputFormat
    let rv: Any

    switch date {
    case .toDate:
        rv = formatter.date(from: value as! String)!
        break
    case .toStr:
        formatter.dateFormat = outputFormat
        rv = formatter.string(from: value as! Date)
        break
    case .strToStr:
        let date = try dateFormatter(to: .toDate, value: value, inputFormat: inputFormat) as! Date
        formatter.dateFormat = outputFormat
        rv = formatter.string(from: date)

        break
    }

    return rv
}
