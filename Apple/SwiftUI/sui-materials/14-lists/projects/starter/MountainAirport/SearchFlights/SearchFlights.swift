/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct SearchFlights: View {
  var flightData: [FlightInformation]
  @State private var date = Date()
  @State private var directionFilter: FlightDirection = .none
  @State private var city = ""

  var matchingFlights: [FlightInformation] {
    var matchingFlights = flightData

    if directionFilter != .none {
      matchingFlights = matchingFlights.filter {
        $0.direction == directionFilter
      }
    }
    
    if !city.isEmpty{
      matchingFlights = matchingFlights.filter{
        $0.otherAirport.lowercased().contains(city.lowercased())
      }
    }

    return matchingFlights
  }
  
  var flightDates: [Date] {
    // 현재 검색 매개변수와 일치하는 모든 항공편의 날짜로 배열을 만든다.
    let allDates = matchingFlights.map { $0.localTime.dateOnly }
    // 중복값 제거
    let uniqueDates = Array(Set(allDates))
    // 정렬된 결과 리턴
    return uniqueDates.sorted()
  }
  
  func flightsForDay(date: Date) -> [FlightInformation]{
    matchingFlights.filter{
      Calendar.current.isDate($0.localTime, inSameDayAs: date)
    }
  }

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack {
        Picker(
          selection: $directionFilter,
          label: Text("Flight Direction")) {
          Text("All").tag(FlightDirection.none)
          Text("Arrivals").tag(FlightDirection.arrival)
          Text("Departures").tag(FlightDirection.departure)
        }
        .background(Color.white)
        .pickerStyle(SegmentedPickerStyle())
        List{
          ForEach(flightDates, id: \.hashValue){ date in
            Section {
              ForEach(flightsForDay(date: date)){ flight in
                SearchResultRow(flight: flight)
              }
            } header: {
              Text(longDateFormatter.string(from: date))
            } footer: {
              HStack{
                Spacer()
                Text("Matching flights "+"\(flightsForDay(date: date).count)")
              }
            }
          }
        }
        Spacer()
      }
      .navigationBarTitle("Search Flights")
      .searchable(text: $city)
      .padding()
    }
  }
}

struct SearchFlights_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchFlights(flightData: FlightData.generateTestFlights(date: Date())
      )
    }
  }
}
