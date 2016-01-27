var elmDiv = document.getElementById('elm-main')
  , initialState = {keyPresses: "", keyReleases: ""}
  , elmApp = Elm.embed(Elm.KeyBoard, elmDiv, initialState);

import {Socket, LongPoller} from "phoenix"
import * as songs from "./songs"
import * as keyPresses from "./keys"

class App {

  static init(){
    let Synth = AudioSynth();
    var piano = Synth.createInstrument('piano');
    let socket = new Socket("/socket", {})
    let keys = $(".keys");
    let titanic = $("#titanic");
    let leekspin = $("#leekspin");

    socket.connect()
    let channel = socket.channel("keys:lobby", {})

    $(document).keypress(e => {
      let key = $(keyPresses.getKeyId(e.which))
      key.click()
    })

    titanic.on('click', () => {
      channel.push("titanic");
    })

    leekspin.on('click', () => {
      channel.push("leekspin");
    })

    // throttle the number of allowed key pressed to 5 a second
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
      elmApp.ports.keyPresses.send(payload.body);
      setTimeout(() => elmApp.ports.keyReleases.send(payload.body), 200);
    })

    channel.on("playing", body => {
      songs.start(body.song);
    })

    channel.on("finished", body => {
      songs.finish(body.song);
    })

    channel.join()
            .receive("ok", () => {
              channel.push("playing?")
            })
  }
}
$( () => App.init() )

export default App
