module.exports = {
  content: [
    "_site/**/*.html",
    "_site/*.html"
  ],
  theme: {
    fontFamily: {
      'sans': ['Rubik', 'sans-serif', 'system-ui']
    },
    extend: {
      colors: {
        'primary': '#ff008a',
      }
    }
  },
  plugins: [
    require('@tailwindcss/typography')
  ],
}
