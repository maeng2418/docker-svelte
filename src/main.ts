import "@babel/polyfill";
import App from "./App.svelte";

const app = new App({
  target: document.body,
  props: {
    name: "MAENG",
  },
});

export default app;
