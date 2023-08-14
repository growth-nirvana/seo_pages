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
        'secondary': '#3E0E8C',
      }
    }
  },
  plugins: [
    require('@tailwindcss/typography')
  ],
}
