//= require_self
//= require_tree ./modules

class Loader {
  constructor() {
    this.modules = [];
  }

  get exports() {
    return this.modules;
  }

  set exports(module) {
    this.modules.push(module);
  }

  each(callback) {
    this.modules.forEach((module) => callback(module));
  }
}

window.exports = {};
window.module = new Loader();
