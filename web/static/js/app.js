import {Socket, LongPoller} from "phoenix"

class App {

  static init(){
    let socket = new Socket("/socket", {})

    socket.connect()

    let channel = socket.channel("keys:join", {})
    let key = $("#key-a");
    let keys = $("#keys");
    let Synth = AudioSynth();
    var piano = Synth.createInstrument('piano');
    keys.on('click', '> *', function() {
      var id = $(this).attr('id');
      channel.push("key_press", {body: id})
    })

    channel.on("key_press", payload => {
      console.log("Payload: " + payload.body)
      var parts = payload.body.split(":")
      piano.play(parts[0], parts[1], 2);
    })

    channel.join()
  }
}
$( () => App.init() )

export default App
