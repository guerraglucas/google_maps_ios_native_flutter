import Foundation

func valueForAPIKey(named keyname:String) -> String {
  // Credit to the original source for this technique at
  // http://blog.lazerwalker.com/blog/2014/05/14/handling-private-api-keys-in-open-source-ios-apps
  guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
      fatalError("Couldnt find the file 'Secrets.plist")
  }
  let plist = NSDictionary(contentsOfFile:filePath)
  guard let value = plist?.object(forKey: keyname) as? String else {
      fatalError("Couldnt find key '\(keyname)' in 'Secrets.plist'. ")
  }
  return value
}