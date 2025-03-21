
import SwiftUI
import Charts

struct AreaChartView: View {
    @StateObject var viewModel: TickerViewModel
    
    var body: some View {
        Chart(viewModel.candles) { candle in
            //line chart
            LineMark(
                x: .value("Date", candle.startTime),
                y: .value("Price", candle.animate ? candle.close : 0)
            )
            .lineStyle(.init(lineWidth: 3, lineCap: .round))
            .interpolationMethod(.cardinal)
            .foregroundStyle(viewModel.graphColor)
            
            //gradient area under the line chart
            AreaMark(
                x: .value("Date", candle.startTime),
                y: .value("Price", candle.animate ? candle.close : 0)
            )
            .lineStyle(.init(lineWidth: 4, lineCap: .round))
            .interpolationMethod(.cardinal)
            .foregroundStyle(Gradient(colors: [viewModel.graphColor.opacity(0.5), viewModel.graphColor.opacity(0)]))
        }
    }
}

struct AreaChart_Previews: PreviewProvider {
    static var previews: some View {
        AreaChartView(viewModel: .init(symbolId: "BTC_UDST"))
    }
}
