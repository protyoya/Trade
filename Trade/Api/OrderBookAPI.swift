
import Foundation

//api endpoint documentation https://docs.poloniex.com/#public-endpoints-market-data-order-book

//singleton API for Order book
final class OrderBookAPI: API {
    
    static let shared = OrderBookAPI()
    
    private override init() {} //sigleton hasn't accessible constructor

    func fetchOrderBook(symbolId: String) async throws -> OrderBook? {
        return try await fetch(path: "/\(symbolId)/orderBook", parameters: [Parameter.limit: "20"])
    }
}
