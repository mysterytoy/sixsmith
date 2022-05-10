
import Foundation

struct PartialHex {
  let q: Double
  let r: Double
  let s: Double
  
  var rounded: Hex {
    let qR = round(q)
    let rR = round(r)
    let sR = round(s)
    
    let qD = abs(qR - q)
    let rD = abs(rR - r)
    let sD = abs(sR - s)
    
    if (qD > rD && qD > sD) {
      return Hex(q: Int(-rR - sR),
                 r: Int(rR),
                 s: Int(sR))
    }
    
    if (rD > sD) {
      return Hex(q: Int(qR),
                 r: Int(-qR - sR),
                 s: Int(sR))
    }
    
    return Hex(q: Int(qR),
               r: Int(rR),
               s: Int(-qR - rR))
  }
  
  public init(q: Double, r: Double, s: Double) {
    self.q = q
    self.r = r
    self.s = s
  }
}
