//
//  Utils.swift
//  Halio
//
//  Created by Кирилл on 01.10.2022.
//

import Foundation

class Utils {
    static func timeStringFor(seconds : Int) -> String {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.second, .minute, .hour]
      formatter.zeroFormattingBehavior = .pad
      let output = formatter.string(from: TimeInterval(seconds))!
      return seconds < 3600 ? output.substring(from: output.range(of: ":")!.upperBound) : output
    }
}
