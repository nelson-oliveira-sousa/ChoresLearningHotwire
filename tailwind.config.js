module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      spacing: {
        '100': '25rem',
        '104': '26rem',
        '108': '27rem',
        '112': '28rem',
      }
    }
  }
}
