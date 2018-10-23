import Foundation

class User {
    var fname: String
    var lname: String
    var baseCurr: String
    
    init (fname: String, lname: String, curr: String) {
        self.fname = fname
        self.lname = lname
        self.baseCurr = curr
    }
}

struct Transaction {
    var user: User
    var baseCurr: String
    var targetCurr: String
    var total: Float
    var split: Float
    var amtPaid: Double?
    
    init (user: User, targetCurr: String, total: Float, split: Float) {
        self.user = user
        self.baseCurr = user.baseCurr
        self.targetCurr = targetCurr
        self.total = total
        self.split = split
        self.amtPaid = convert()
    }
    
    func getRate() -> Float {
        let exchangeURL: NSURL = NSURL(string: "https://api.exchangeratesapi.io/latest?base=\(self.baseCurr)&symbols=\(self.targetCurr)")!
        let data = NSData(contentsOf: exchangeURL as URL)!
        let swiftyjson = try? JSON(data: data as Data)
        if let exchangeRate = swiftyjson!["rates"]["\(self.targetCurr)"].float {
            print("Conversion Amount is: \(exchangeRate)")
            return exchangeRate
        }
        return 0
    }
    
    func convert() -> Double? {
        let exchangeRate: Float = getRate()
        if (exchangeRate != 0) {
            let exchangeTotal = total * exchangeRate
            let amtPaid =  Double(exchangeTotal * split)
            return amtPaid
        }
        return nil
    }
}

let user = User(fname: "Bobby", lname: "Maes", curr: "USD")
let t1 = Transaction(user: user, targetCurr: "GBP", total: 50, split: 0.50)
print("You owe: \(String(format: "%.2f", t1.amtPaid!))")
