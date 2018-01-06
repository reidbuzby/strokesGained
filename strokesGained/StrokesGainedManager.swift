//
//  StrokesGainedManager.swift
//  strokesGained
//
//  Created by Reid Buzby on 11/21/17.
//  Copyright © 2017 Reid Buzby. All rights reserved.
//

import Foundation

class StrokesGainedManager: NSObject {
    
    class func calculateRound(golf_round: [[Int]]) -> Double {
        
        var sgp = 0.0
        var proDB:[Int: Double] = [1:1.0, 2:1.01, 3:1.04, 4:1.13, 5:1.23, 6:1.34, 7:1.42, 8:1.50, 9:1.56, 10:1.61, 15:1.78, 20:1.87, 25:1.93, 30:1.98, 35:2.02, 36:2.028, 37:2.036, 38:2.044, 39:2.052, 40:2.06, 41:2.068, 42: 2.076, 43: 2.084, 44: 2.092, 45:2.10, 46:2.108, 47:2.116, 48:2.124, 49:2.132, 50:2.14, 51:2.148, 52:2.156, 53:2.164, 54:2.172, 55:2.18, 56: 2.186, 57:2.192, 58: 2.198, 59: 1.214, 60:2.21]
        
        var scratchDB:[Int:Double] = [1:1.0, 2:1.01, 3:1.07, 4:1.20, 5:1.34, 6:1.45, 7:1.54, 8:1.60, 9:1.65, 10:1.68, 15:1.81, 20:1.89, 25:1.95, 30:2.03, 35:2.08, 40:2.14, 45:2.18, 50:2.22, 55:2.26, 60:2.30]
        
        for hole in golf_round {
            var puttsLeft = hole.count
            for putt in hole {
                if putt > 60 {
                    let sgpPutt = 2.21
                }
                else {
                   let sgpPutt = proDB[putt]! - Double(puttsLeft)
                }
        
                sgp += sgpPutt
                puttsLeft -= 1
            }
        }
        
        return sgp
    }
}
