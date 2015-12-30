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
}

window.exports = {};
window.module = new Loader();
