var elmDiv = document.getElementById('elm-main')
  , initialState = {keyEvents: ""}
  , elmApp = Elm.embed(Elm.KeyBoard, elmDiv, initialState);

import {Socket, LongPoller} from "phoenix"

class App {

  static init(){
    let Synth = AudioSynth();
    var piano = Synth.createInstrument('piano');
    let socket = new Socket("/socket", {})
    let keys = $(".keys");

    socket.connect()
    let channel = socket.channel("keys:join", {})

    let getKey = code => {
      let codes = {
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
      return $("#" + codes[code])
    }
    $(document).keypress(e => {
      let key = getKey(e.which)
      key.click()
    })

    // throttle the numbe rof allowed key pressed to 3 a second
    var pressTimer = false;
    keys.on('click', '> *', function() {
      if(!pressTimer) {
        pressTimer = true;
        var id = $(this).attr('id');
        channel.push("key_press", {body: id})
        setTimeout(() => pressTimer = false, 200);
      }
    })

    channel.on("key_press", payload => {
      var parts = payload.body.split(":")
      piano.play(parts[0], parts[1], 2)
      elmApp.ports.keyEvents.send(payload.body);
    })

    channel.join()
  }
}
$( () => App.init() )

// release all keys every half a second (dirty hack)
setInterval( () => elmApp.ports.keyEvents.send(""), 500)

export default App
