browserSync = require('browser-sync').create()
del = require 'del'
fs = require 'fs'
gulp = require 'gulp'
cache = require 'gulp-cache'
changed = require 'gulp-changed'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
data = require 'gulp-data'
filter = require 'gulp-filter'
gutil = require 'gulp-util'
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
include = require 'gulp-include'
jade = require 'gulp-jade'
marked = require 'marked'
minifyJS = require 'gulp-uglify'
notify = require 'gulp-notify'
neat = require('node-neat').includePaths
path = require 'path'
plumber = require 'gulp-plumber'
prefix = require 'gulp-autoprefixer'
runSequence = require 'run-sequence'
sass = require 'gulp-sass'
sourcemaps = require 'gulp-sourcemaps'

src =
  data: './src/data/'
  jade: 'src/templates/**/!(_)*.jade'
  sass: 'src/sass/**/*.sass'
  js: 'src/js/**/*.js'
  img: 'src/img/**/*.{png,jpg,jpeg,gif,svg}'
  fonts: 'src/fonts/*.{eot,svg,ttf,woff}'

dist =
  html: 'dist/'
  css: 'dist/css/'
  js: 'dist/js/'
  img: 'dist/img/'
  fonts: 'dist/fonts/'

gulp.task 'default', ['browser-sync', 'watch']

# Watch task
gulp.task 'watch', ->
  gulp.watch 'src/templates/**/*.jade', ['jade']
  gulp.watch src.img, ['images']
  gulp.watch src.fonts, ['fonts']
  gulp.watch src.sass, ['sass']
  gulp.watch src.js, ['js']

# Jade task
gulp.task 'jade', ->
  gulp.src src.jade
    .pipe plumber()
    .pipe changed('dist', extension: '.html')
    .pipe data((file) ->
      JSON.parse fs.readFileSync(src.data + path.basename(file.path) + '.json'))
    .pipe jade pretty:true
    .pipe gulp.dest dist.html
    .pipe browserSync.reload(stream:true)
    .pipe notify('Templates task complete!')

# Images task
gulp.task 'images', ->
  gulp.src src.img
    .pipe plumber()
    .pipe changed(dist.img)
    .pipe imagemin({
      progressive: true
      svgoPlugins: [{removeViewBox: false}]
      use: [pngquant()]
    })
    .pipe gulp.dest dist.img
    .pipe browserSync.reload(stream:true)
    .pipe notify('Images task complete')

# Fonts task
gulp.task 'fonts', ->
  gulp.src src.fonts
    .pipe plumber()
    .pipe changed(dist.fonts)
    .pipe gulp.dest dist.fonts
    .pipe browserSync.reload(stream:true)
    .pipe notify('Fonts task complete')

# Sass task
gulp.task 'sass', ->
  gulp.src src.sass
    .pipe sourcemaps.init()
    .pipe sass(
      includePaths: neat
    )
    .on('error', sass.logError)
    .pipe prefix(browsers: ['last 3 versions'])
    .pipe sourcemaps.write('../sourcemaps')
    .pipe gulp.dest dist.css
    .pipe browserSync.stream({match: '**/*.css'})
    .pipe notify('Styles task complete!')

# JavaScript task
gulp.task 'js', ->
  gulp.src 'src/js/*.js'
    .pipe plumber()
    .pipe include()
    .pipe minifyJS()
    .pipe gulp.dest dist.js
    .pipe browserSync.reload(stream:true)
    .pipe notify('Script task complete!')

# Browser-sync task
gulp.task 'browser-sync', [
  'jade',
  'images',
  'fonts',
  'sass',
  'js'
], ->
  browserSync.init({
    server: {
      baseDir: 'dist'
    }
    # proxy: 'mysite.dev'
  })
