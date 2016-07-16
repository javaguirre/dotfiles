module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 12,

    // font family with optional fallbacks
    fontFamily: 'Source Code Pro, Monaco, Mononoki, monospace',

    // terminal cursor background color (hex)
    cursorColor: '#1f9ee7',

    // color of the text
    foregroundColor: '#fff',

    // terminal background color
    backgroundColor: '#000',

    // border color (window, tabs)
    borderColor: '#21b089',

    // custom css to embed in the main window
    css: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    termCSS: '',

    // custom padding
    padding: '10px 12px',

    // some color overrides. see http://bit.ly/29k1iU2 for
    // the full list
    colors: [
	"#000000", //"#282a2e",
	"#f9555f",
	"#21b089",
	"#fef02a",
	"#589df6",
	"#944d95",
	"#1f9ee7",
	"#bbbbbb",
	/* 8 bright colors */
	"#555555",
	"#fa8c8f",
	"#35bb9a",
	"#ffff55",
	"#589df6",
	"#e75699",
	"#3979bc",
	"#ffffff",
    ]
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hypersolar`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [],

  // in development, you can create a directory under
  // `~/.hyperterm_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
