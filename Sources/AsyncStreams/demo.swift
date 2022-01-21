import Foundation

class Demo {
    func run() async throws {
        let byteStream = AsyncStream(UInt8.self, bufferingPolicy: .unbounded) { continuation in
            var count = 1_000_000_000
            repeat {
                continuation.yield(.random(in: 0..<255))
                count -= 1
            } while count > 0
        }
        
        
        let stream = AsyncStream(String.self) { continuation in
            Task {
                var messages = ["Hello, ", "what", "is", "your", "name", "????"]
                while !messages.isEmpty {
                    let message = messages.removeFirst()
                    try? await Task.sleep(nanoseconds: NSEC_PER_SEC / 20)
                    continuation.yield(message)
                }
                try? await Task.sleep(nanoseconds: NSEC_PER_SEC / 20)
                continuation.finish()
            }
        }
        
        for await message in stream {
            print("MSG: \(message)")
        }
        
        let stocks = AsyncThrowingStream(unfolding: {
            try await self.getStockPrice(symbol: "AAPL")
        })
        
        var i = 0
        for try await stock in stocks {
            print("price: \(stock)")
            i += 1
            if i > 10 {
                break
            }
        }
    }
    
    func getStockPrice(symbol: String) async throws -> Float {
        let value = Float.random(in: 0.15...1.92)
        let delay = TimeInterval.random(in: 0.2...0.9)
        try await Task.sleep(nanoseconds: UInt64(TimeInterval(NSEC_PER_SEC) * delay))
        return value
    }
}





























@main
struct AsyncStreamsDemo {
    static func main () async throws {
        try await Demo().run()
    }
}
