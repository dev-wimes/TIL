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
  
  // 이것이 계층적 데이터 구조를 구축하는 방법
  var hierarchicalFlights: [HierarchicalFlightRow]{
    // 계층 구조의 최상위 수준에 있을 빈 배열을 만든다.
    var rows: [HierarchicalFlightRow] = []
    
    // 다음으로 flightDates를 반복
    for date in flightDates{
      // 날짜에 대한 새 HierarchicalFlightRow를 생성
      // 행의 label은 날짜의 longDateForammtter형식으로 설정
      let newRow = HierarchicalFlightRow(
        label: longDateFormatter.string(from: date),
        children: flightsForDay(date: date).map{hierarchicalFlightRowFromFlight($0)})
      rows.append(newRow)
    }
    
    return rows
  }
  
  struct HierarchicalFlightRow: Identifiable{
    var label: String
    var flight: FlightInformation?
    var children: [HierarchicalFlightRow]?
    
    // Identifiable 프로토콜의 요구사항에 만족하기 위한 id
    var id = UUID()
  }
  
  // FlightInformation정보를 이용해 HierarchicalFlightRow를 리턴
  // 비행 정보가 있는 계층 구조의 리프 노드를 생성한다.
  func hierarchicalFlightRowFromFlight(_ flight: FlightInformation) -> HierarchicalFlightRow{
    return HierarchicalFlightRow(
      label: longDateFormatter.string(from: flight.localTime),
      flight: flight,
      children: nil
    )
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
        // List는 계산된 hierarchicalFlight프로퍼티를 사용하여 계층 구조를 가져온다.
        List(hierarchicalFlights, children: \.children){ row in
          if let flight = row.flight{
            SearchResultRow(flight: flight)
          }else{
            Text(row.label)
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
