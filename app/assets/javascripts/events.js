// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
/*
 fetch('https://www.boardgamegeek.com/xmlapi2/thing?id=237182')
 .then(res => res.text())
 .then(str => (new window.DOMParser())
 .parseFromString(str, "text/xml"))
 .then(x => { xml = x })

 images = document.evaluate('//image/text', xml)
 images.iterateNext()
 // => https://cf.geekdo-images.com/original/img/dKjbqIjkFvlDt8OH01LtFqk-A8Q=/0x0/pic4254509.jpg
 //
 images = document.evaluate('//thumbnail/text', xml)
 images.iterateNext()
 // => ...
 */

function bggIds() {
  let ids = [];
  let results = document.evaluate("//tr[@data-bggid!='']/@data-bggid", document);
  while (result = results.iterateNext()) {
    ids.push(result.value);
  }

  return ids
}

function enrichFromBGG() {
  for (let id of bggIds()) {
    getThing(id)
      .then( xml => document.evaluate('//thumbnail/text()', xml).iterateNext())
      .then((img) => {
          if (img == null) {
            console.log("no thumbnail found", id);
            return
          }
          let td = document.evaluate("//tr[@data-bggid='"+id+"']/td[@class='thumbnail']", document).iterateNext();
          if (td != null) {
            td.innerHTML = '<img src="' + img.nodeValue + '" />'
          }
          centerFragmentId();
      })
  }
}

window.addEventListener("DOMContentLoaded", enrichFromBGG);
window.addEventListener("turbolinks:load", enrichFromBGG);
