import Foundation

//api endpoint documentation https://docs.poloniex.com/#public-endpoints-market-data-candles

//singleton API for Candles
final class CandleAPI: API {
    
    static let shared = CandleAPI()
    
    private override init() {} //sigleton hasn't accessible constructor
    
    func fetchAllCandles(symbolId: String, interval: TickerViewModel.Interval) async throws -> [Candle] {
        let eitherArrays: [[Either<UInt64, String>]] = try await fetch(
            path: "/\(symbolId)/candles",
            parameters: createParameters(interval: interval)
        ) ?? []
        
        var candles: [Candle] = []
        
        do {
            for (idx, eitherArray) in eitherArrays.enumerated() {
                try candles.append(Candle.fromEitherArray(eitherArray, id: idx))
            }
            return candles
        } catch {
            print("[FETCH CANDLES ERROR]", error)
            return []
        }
    }
    
    private func createParameters(interval: TickerViewModel.Interval) -> [Parameter: String] {
        var parameters: [Parameter: String] = [:]
        
        parameters[Parameter.limit] = "500"
        
        switch interval {
        case .all:
            parameters[Parameter.interval] = AgreggateByInterval.MONTH_1.rawValue
        case .years10:
            parameters[Parameter.interval] = AgreggateByInterval.MONTH_1.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 10, unit: .year)
        case .years5:
            parameters[Parameter.interval] = AgreggateByInterval.MONTH_1.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 5, unit: .year)
        case .years2:
            parameters[Parameter.interval] = AgreggateByInterval.WEEK_1.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 2, unit: .year)
        case .year1:
            parameters[Parameter.interval] = AgreggateByInterval.WEEK_1.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 1, unit: .year)
        case .month6:
            parameters[Parameter.interval] = AgreggateByInterval.DAY_3.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 6, unit: .month)
        case .month3:
            parameters[Parameter.interval] = AgreggateByInterval.DAY_1.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 3, unit: .month)
        case .month1:
            parameters[Parameter.interval] = AgreggateByInterval.HOUR_12.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 1, unit: .month)
        case .week1:
            parameters[Parameter.interval] = AgreggateByInterval.HOUR_2.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 7, unit: .day)
        case .day1:
            parameters[Parameter.interval] = AgreggateByInterval.MINUTE_30.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 1, unit: .day)
        case .hour1:
            parameters[Parameter.interval] = AgreggateByInterval.MINUTE_1.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 1, unit: .hour)
        case .minut30:
            parameters[Parameter.interval] = AgreggateByInterval.MINUTE_1.rawValue
            parameters[Parameter.startTime] = beforeXUnitsToString(value: 30, unit: .minute)
        }
        
        return parameters
    }
    
    // return date before x units in unix format as a string
    private func beforeXUnitsToString(value: Int, unit: Calendar.Component) -> String {
        String(UInt64(Calendar.current.date(
                byAdding: unit,
                value: -value,
                to: Date()
            )!.timeIntervalSince1970 * 1000)
        )
    }
    
    //api parameter
    enum AgreggateByInterval: String {
        case MINUTE_1
        case MINUTE_5
        case MINUTE_10
        case MINUTE_15
        case MINUTE_30
        case HOUR_1
        case HOUR_2
        case HOUR_4
        case HOUR_6
        case HOUR_12
        case DAY_1
        case DAY_3
        case WEEK_1
        case MONTH_1
    }
}
