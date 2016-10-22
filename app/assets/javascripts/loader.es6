class Loader {
  constructor() {
    this.modules = [];
  }

  set exports(mod) {
    this.modules.push(mod);
  }

  get exports() {
    return this.modules;
  }

  init(event) {
    let page = $(event.currentTarget);
    _.each(this.modules, function(mod) {
      mod(page);
    });
  }
}

window.module = new Loader();
window.exports = module.exports;
