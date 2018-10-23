import Foundation

let exchangeURL: NSURL = NSURL(string: "https://api.exchangeratesapi.io/latest?base=USD&symbols=GBP")!
let data = NSData(contentsOf: exchangeURL as URL)!
let swiftyjson = try JSON(data: data as Data)
if let exchangeRate = swiftyjson["rates"]["GBP"].float {
    print("Conversion Amount is: \(exchangeRate)")
}
