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

var thingCache = {};
function getThing(id) {
  if (thingCache.hasOwnProperty(id)) {
    return thingCache[id]
  }
  thingCache[id] = fetch('https://www.boardgamegeek.com/xmlapi2/thing?id=' + id)
      .then( res => res.text() )
      .then( str => (new window.DOMParser()).parseFromString(str, "text/xml"));
  return thingCache[id]
}
