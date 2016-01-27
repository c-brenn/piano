export function getKeyId(code) {
  var codes = {
    97: "C\\:4",
    119: "C\\#\\:4",
    115: "D\\:4",
    101: "D\\#\\:4",
    100: "E\\:4",
    102: "F\\:4",
    116: "F\\#\\:4",
    103: "G\\:4",
    121: "G\\#\\:4",
    104: "A\\:4",
    117: "A\\#\\:4",
    106: "B\\:4",
    107: "C\\:5",
    111: "C\\#\\:5",
    108: "D\\:5",
    112: "D\\#\\:5",
    59: "E\\:5",
    39: "F\\:5"
  }
  return "#" + codes[code]
}