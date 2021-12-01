//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 엔나루 on 2021/11/30.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        
        NavigationView {
            //static
            /*
            List {
                LandmarkRow(landmark: landmarks[0])
                LandmarkRow(landmark: landmarks[1])
            }
            */
            List(landmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
                
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd Generation)", "iPhone XS Max"], id: \.self) { devicename in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: devicename))
                .previewDisplayName(devicename)
        }
    }
}
