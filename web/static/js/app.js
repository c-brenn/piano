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
    var timer = false;
    keys.on('click', '> *', function() {
      if(!timer) {
        timer = true;
        var id = $(this).attr('id');
        channel.push("key_press", {body: id})
        setTimeout(function(){ timer = false;}, 300);
      }
    })

    channel.on("key_press", payload => {
      var parts = payload.body.split(":")
      piano.play(parts[0], parts[1], 2);
    })

    channel.join()
  }
}
$( () => App.init() )

export default App
