import { defineComponent as g, ref as v, watch as b, onMounted as w, onBeforeUnmount as P, openBlock as S, createBlock as _, resolveDynamicComponent as L, withCtx as E, renderSlot as k } from "vue";
import B from "perfect-scrollbar";
const C = /* @__PURE__ */ g({
  __name: "PerfectScrollbar",
  props: {
    tag: { default: "div" },
    options: { default: () => ({}) }
  },
  emits: ["scroll", "ps-scroll-y", "ps-scroll-x", "ps-scroll-up", "ps-scroll-down", "ps-scroll-left", "ps-scroll-right", "ps-y-reach-start", "ps-y-reach-end", "ps-x-reach-start", "ps-x-reach-end"],
  setup(o, { expose: n, emit: c }) {
    const a = o, y = c, l = v(null), s = v(null);
    b(
      () => a.options,
      () => {
        i(), p();
      },
      { deep: !0 }
    ), w(() => {
      l.value && p();
    }), P(() => {
      i();
    });
    function p() {
      l.value && (s.value = new B(l.value, a.options), u());
    }
    function i() {
      s.value && (u(!1), s.value.destroy(), s.value = null);
    }
    const x = {
      scroll: e("scroll"),
      "ps-scroll-y": e("ps-scroll-y"),
      "ps-scroll-x": e("ps-scroll-x"),
      "ps-scroll-up": e("ps-scroll-up"),
      "ps-scroll-down": e("ps-scroll-down"),
      "ps-scroll-left": e("ps-scroll-left"),
      "ps-scroll-right": e("ps-scroll-right"),
      "ps-y-reach-start": e("ps-y-reach-start"),
      "ps-y-reach-end": e("ps-y-reach-end"),
      "ps-x-reach-start": e("ps-x-reach-start"),
      "ps-x-reach-end": e("ps-x-reach-end")
    };
    function e(r) {
      return function(t) {
        y(r, t);
      };
    }
    function u(r = !0) {
      var t;
      (t = s.value) != null && t.element && Object.entries(x).forEach(([f, d]) => {
        var m, h;
        r ? (m = s.value) == null || m.element.addEventListener(f, d) : (h = s.value) == null || h.element.removeEventListener(f, d);
      });
    }
    return n({
      ps: s
    }), (r, t) => (S(), _(L(r.tag), {
      ref_key: "scrollbar",
      ref: l,
      class: "ps"
    }, {
      default: E(() => [
        k(r.$slots, "default")
      ]),
      _: 3
    }, 512));
  }
}), O = {
  componentName: "PerfectScrollbar"
}, D = {
  install(o, n) {
    const c = Object.assign(O, n);
    o.component(c.componentName, C);
  }
};
export {
  C as PerfectScrollbar,
  D as PerfectScrollbarPlugin
};
