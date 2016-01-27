let playingSong = false;
let numSpinners = 10;

let startSpinners = (className) => {
  for(var i = 0; i < numSpinners; i++) {
    let position = getRandomPosition(),
        x = position[0],
        y = position[1];
    $('body').append(
      `<div id="spinner${i}" style="left:${x}px;top:${y}px;" class="spin-container"><div class="${className}"></div></div>`
    )
  }
  playingSong = true;
}

let getRandomPosition = () => {
  var x = window.innerWidth - 200;
  var y = window.innerHeight - 200;
  var randomX = Math.floor(Math.random()*x);
  var randomY = Math.floor(Math.random()*y);
  return [randomX,randomY];
}

export function start(song) {
  if(song == "titanic") {
    startSpinners("spintanic");
  } else if(song == "leekspin") {
    startSpinners("leekspin");
  }
  return null;
}

export function finish(song) {
  playingSong = false;
  for(var i = 0; i < numSpinners; i++){
    $(`#spinner${i}`).remove();
  }
}
