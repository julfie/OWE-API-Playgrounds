import Foundation


struct Currency {
    var name: String
    var code: String
    var symbol: String
    var description: String { return "\t \(self.symbol) \t|\t \(self.code) \t|\t \(self.name) \n" }
    
    init (name: String, code: String, symbol: String) {
        self.name = name
        self.code = code
        self.symbol = symbol
    }
}

class Country {
    var name: String = ""
    var currencies = [Currency]()
    var description: String { return prepString() }
    
    func prepString() -> String {
        var string = "name: \(name) \n"
        string += "Currencies: \n"
        for curr in self.currencies {
            string += curr.description
        }
        return string
    }
}

func countryNames(swiftyjson: JSON) {
    var country_names = [String]()
    for i in 0..<250 {
        if let country_name = swiftyjson.array?[i]["name"].string {
            country_names.append(country_name)
        }
    }
    print(country_names)
    print("---------\n")
}

func countryCurrencues(swiftyjson: JSON) {
    let cntry = Country()
    
    if let count = swiftyjson.array?.count {
        for i in 0..<count {
            cntry.currencies = []
            if let CountryName = swiftyjson.array?[i]["name"].string {
                cntry.name = CountryName
            }
            for currency in (swiftyjson.array?[i]["currencies"])! {
                if let cname = currency.1["name"].string {
                    if let code = currency.1["code"].string {
                        if let symbol = currency.1["symbol"].string {
                            let curr = Currency(name: cname, code: code, symbol: symbol)
                            cntry.currencies.append(curr)
                        }
                    }
                }
            }
            print(cntry.description)
            print("---------\n")
        }
    }
}

let exchangeURL: NSURL = NSURL(string: "https://restcountries.eu/rest/v2/all")!
let data = NSData(contentsOf: exchangeURL as URL)!
let swiftyjson = try JSON(data: data as Data)
//countryNames(swiftyjson: swiftyjson)
countryCurrencues(swiftyjson: swiftyjson)
