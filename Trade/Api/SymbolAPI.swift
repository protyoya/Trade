import Foundation

//api endpoint documentation https://docs.poloniex.com/#public-endpoints-market-data-prices

//singleton API for Symbol
final class SymbolAPI: API {
    
    static let shared = SymbolAPI()
    
    private override init() {} //sigleton hasn't accessible constructor

    func fetchAllSymbols() async throws -> [Symbol] {
        return try await fetch(path: "/price") ?? []
    }
    
    func fetchSymbol(symbolId: String) async throws -> Symbol? {
        return try await fetch(path: "/\(symbolId)/price")
    }
}
