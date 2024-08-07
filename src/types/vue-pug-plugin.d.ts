/// <reference types="vite/client" />
declare module 'vue-pug-plugin';
declare module "*.vue" {
  import type { DefineComponent } from "vue";
  const component: DefineComponent<{}, {}, any>;
  export default component;
}
