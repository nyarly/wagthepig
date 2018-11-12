// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


function searchQuery() {
  let r = firstMatch(document, '//input[@name="game[name]"]')
  if (r != null) {
    return r.value;
  }
}

function searchResults(q) {
  q = q.replace(/\s+/, "+");
  if (q.length < 4) {
    q = q+"&exact=1";
  }
  let rz = fetch("https://www.boardgamegeek.com/xmlapi2/search?type=boardgame,boardgameexpansion&query=" + q)
      .then( res => res.text() )
      .then( str => (new window.DOMParser()).parseFromString(str, "text/xml"));

      rz.then( xml => {
          nodes = match(xml, '//item');
          games = [];
          for (let node of nodes) {
            var name = firstMatch(node, './/name[@type="primary"]')
            if (node == null || name == null) {
              continue;
            }
            games.push({
                id: node.getAttribute("id"),
                name: name.getAttribute("value")
              });
          }
          return games;
        } )
      .then( games => {
          clearSearchResults();
          for (let game of games) {
            injectSearchResult(game)
          }
        });
}

function clearSearchResults() {
  let rows = matchSnapshot(document, '//div[@class="search-results"]//tr[@style=""]')
  for (let row of rows) {
    row.parentNode.removeChild(row);
  }
}

function injectSearchResult(game) {
  firstMatch(document, '//div[@class="search-results"]').style = "";
  let resultTable = firstMatch(document, '//div[@class="search-results"]//table');
  let resultRow = firstMatch(document, '//div[@class="search-results"]//tr[@class="result"]').cloneNode(true);
  let name = firstMatch(resultRow, './/td[@class="name"]')
  name.innerText = game.name;
  resultRow.setAttribute("style", "");
  resultTable.appendChild(resultRow);
  let pickBtn = firstMatch(resultRow, './/button[@name="pick"]');
  pickBtn.addEventListener('click', () => doPick(game.id));
  getThing(game.id)
    .then( xml => {
        let thumb = firstMatch(xml, '//thumbnail/text()');
        let img = firstMatch(resultRow, './/td[@class="thumbnail"]//img');
        if (thumb && img) {
          img.setAttribute("src", thumb.data);
        }

        let desc = firstMatch(xml, '//description/text()');
        let td = firstMatch(resultRow, './/td[@class="description"]');
        if (td && desc) {
          td.innerText = desc.data.slice(0, 150);
        }
      })
}

function doPick(id) {
  getThing(id)
  .then(xml => {
      clearSearchResults();
      setFrom(xml, '//name[@type="primary"]/@value', '//input[@name="game[name]"]')
      setFrom(xml, '//minplayers/@value', '//input[@name="game[min_players]"]');
      setFrom(xml, '//maxplayers/@value', '//input[@name="game[max_players]"]');
      setFrom(xml, '//maxplaytime/@value', '//input[@name="game[duration_minutes]"]');
      setFrom(xml, '//item[@type="boardgame" or @type="boardgameexpansion"]/@id', '//input[@name="game[bgg_id]"]');
    })
}


function setFrom(xml, srcXpath, dstXpath) {
  let src = firstMatch(xml, srcXpath);
  let dst = firstMatch(document, dstXpath);
  if (src && dst) {
    dst.value = src.value;
  }
}


function doSearch() {
  searchResults(searchQuery());
}

function wireUpSearchButton() {
  let button = firstMatch(document, '//button[@name="search"]');
  if (button != null) {
    button.addEventListener('click', doSearch);
  }
}

window.addEventListener("DOMContentLoaded", wireUpSearchButton);
window.addEventListener("turbolinks:load", wireUpSearchButton);
