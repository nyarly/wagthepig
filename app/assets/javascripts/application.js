// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//
function xpathResultIterator(r) {
  this.result = r
}

xpathResultIterator.prototype[Symbol.iterator] = function () {
  return this;
}

xpathResultIterator.prototype.next = function () {
  let v = this.result.iterateNext();
  if (v == null) {
    return {
      done: true
    }
  } else {
    return { done: false, value: v }
  }
}

function snapshotResultIterator(r) {
  this.n = 0
  this.result = r
}

snapshotResultIterator.prototype[Symbol.iterator] = function () {
  return this;
}

snapshotResultIterator.prototype.next = function () {
  if (this.n < this.result.snapshotLength) {
    return { done: false, value: this.result.snapshotItem(this.n++) };
  } else {
    return {
      done: true
    }
  }
}
function firstMatch(node, xpath) {
  let r = document.evaluate(xpath, node, null, XPathResult.FIRST_ORDERED_NODE_TYPE);
  if (r != null) {
    return r.singleNodeValue;
  } else {
    return null;
  }
}

function match(node, xpath) {
  let r = document.evaluate(xpath, node);
  if (r != null) {
    return new xpathResultIterator(r);
  } else {
    return [];
  }
}

function matchSnapshot(node, xpath) {
  let r = document.evaluate(xpath, node, null, XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE);
  if (r != null) {
    return new snapshotResultIterator(r);
  } else {
    return [];
  }
}

function classXpath(className) {
  return "contains(concat(' ', normalize-space(@class), ' '), '" + className + "')"
}

var thingCache = {};

function parsingXML(txtP) {
  return txtP.then( str => (new window.DOMParser()).parseFromString(str, "text/xml"));
}

function getThing(id) {
  if (thingCache.hasOwnProperty(id)) {
    return thingCache[id]
  }
  stored = window.localStorage.getItem(id);
  if (stored != null) {
    thingCache[id] = parsingXML(Promise.resolve(stored))
  } else {
    thingCache[id] = parsingXML(fetch('https://www.boardgamegeek.com/xmlapi2/thing?id=' + id)
      .then( res => res.text())
      .then( txt => {
          window.localStorage.setItem(id, txt);
          return txt
        })
    )
  }
  return thingCache[id]
}


function centerFragmentId() {
  if (window.location.hash != null && window.location.hash != "") {
    let id = window.location.hash.replace(new RegExp('^#'),'')
    let elem = document.getElementById(id);
    elem.scrollIntoView({block: "center"});
  }
}


function makeSortableTablesSortable() {
  let tables = matchSnapshot(document, '//table[' + classXpath('sortable') + ']')
  for (let table of tables) {
    sorttable.makeSortable(table);
  }
  centerFragmentId();
}

function bggThumbnails() {
  for (let img of matchSnapshot(document, "//img[@data-bggid!='']")) {
    let id = firstMatch(img, './@data-bggid')
    getThing(id.value)
      .then( xml => document.evaluate('//thumbnail/text()', xml).iterateNext())
      .then((src) => {
          if (src == null) {
            console.log("no thumbnail found", id);
            return
          }
          img.setAttribute('src', src.data)
          centerFragmentId();
      })
  }
}

window.addEventListener("turbolinks:load", makeSortableTablesSortable);
window.addEventListener("turbolinks:load", bggThumbnails);
