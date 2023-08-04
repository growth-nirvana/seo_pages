module.exports = {
  content: [
    "_site/**/*.html",
    "_site/*.html"
  ],
  theme: {
    fontFamily: {
      'sans': ['Rubik', 'sans-serif', 'system-ui']
    }
  },
  plugins: [
    require('@tailwindcss/typography')
  ],
}
