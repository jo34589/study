//
//  EventAddDialogueView.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/19.
//

import SwiftUI

struct EventAddDialogueView: View {
    
    @EnvironmentObject var eventHandler: EventHandler
    @State private var eventStr = ""
    @State private var duration: Int = 0
    
    private enum Field: Int {
        case eventTextField
    }
    
    @FocusState private var focusField: Field?
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let startDate = eventHandler.tappedDate!
            ZStack {
                Color(white: 1, opacity: 1)
                Button() {
                    focusField = nil
                } label: {
                    Text("")
                        .frame(width: width, height: height)
                }
                VStack(alignment: .center, spacing: 20){
                    HStack {
                        Spacer()
                            .frame(width: 50)
                        //Text Frame 최적화 필요
                        Text(getTitle(from: eventHandler.tappedDate))
                            .font(.system(size: 40))
                            .frame(width: 180, alignment: .center)
                        Spacer()
                            .frame(width: 10)
                        Button() {
                            focusField = nil
                            eventStr = ""
                            eventHandler.isAdding = false
                        } label: {
                            Image(systemName: "x.circle")
                                .frame(width: 30, height: 30, alignment: .topTrailing)
                                .padding(5)
                        }
                        .frame(alignment: .topTrailing)
                    }
                    HStack {
                        Text("Duration")
                            .font(.system(size: 20))
                        Picker("Duration(day)", selection: $duration) {
                            ForEach(1 ..< 11) { i in
                                Text("\(i) Day")
                                    .font(.system(size: 20))
                            }
                        }
                        .frame(width: width/2, height: height/6)
                    }
                    TextField("Event Title", text: $eventStr)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                        .textContentType(.none)
                        .textInputAutocapitalization(.none)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        .frame(height: height/8)
                        .focused($focusField, equals: .eventTextField)
                    Button() {
                        //action
                        focusField = nil
                        eventHandler.addNewEvent(startDate: startDate, endDate: getEndDate(from: startDate, duration: duration), eventStr: eventStr)
                        eventStr = ""
                        eventHandler.isAdding = false
                        //print(eventHandler.events)
                        //events changes.
                    } label: {
                        Text("Confirm")
                            .font(.system(size: 30))
                            .frame(width: width*4/5, height: height/6)
                    }
                    .buttonStyle(.bordered)
                    .cornerRadius(10)
                    .frame(width: width*4/5, height: height/6)
                    
                }
            }
        }
    }
}

struct EventAddDialogueView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        EventAddDialogueView()
            .environmentObject(EventHandler(date: Date(), events: []))
            .frame(width: 300, height: 500)
    }
}
