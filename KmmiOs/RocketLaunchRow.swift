//
//  RocketLaunchRow.swift
//  KmmiOs
//
//  Created by Akhil.b on 15/10/23.
//

import SwiftUI
import shared

/**
 * RocketLaunchRow view displays an item from the list of data from the api. It will be based on the HStack and VStack views.
 */
struct RocketLaunchRow: View {
    
    var rocketLaunch:RocketLaunch
    
    var body: some View {
        HStack(){
            VStack(alignment: .leading, spacing: 10.0) {
                Text("Launch name: \(rocketLaunch.missionName)")
                Text(launchText).foregroundColor(launchColor)
                Text("Launch year: \(String(rocketLaunch.launchYear))")
                Text("Launch details: \(rocketLaunch.details ?? "")")
            }
            Spacer()
        }
    }
}

/**
 * Extension of RocketLaunchRow structure with useful helpers for displaying data.
 */
extension RocketLaunchRow{
    private var launchText:String{
        if let isSuccess = rocketLaunch.launchSuccess{
            return isSuccess.boolValue ? "Successful":"Unsuccessful"
        }else{
            return "No data"
        }
    }
    
    private var launchColor:Color{
        if let isSuccess = rocketLaunch.launchSuccess{
            return isSuccess.boolValue ? Color.green : Color.red
        }else{
            return Color.gray
        }
    }
}
