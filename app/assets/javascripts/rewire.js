class Loader {
  constructor() {
    this.exports = [];
  }

  set exports(module) {
    this.exports.push(module);
  }

  init() {
    for (let module in this.exports) {
      module(..arguments, module);
    }
  }

  import(module) {
    return this.exports[module];
  }
}

window.module = new Loader();
window.exports = module.exports;

jQuery.fn.rewire = function() {
  let page = $(this);
  page.on('turbolinks:load', () -> module.init(page));
};
