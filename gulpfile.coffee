browserSync = require 'browser-sync'
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
sass = require 'gulp-ruby-sass'
sourcemaps = require 'gulp-sourcemaps'

srcs =
  data: './src/data/'
  jade: 'src/templates/**/!(_)*.jade'
  scss: 'src/sass/**/*.sass'
  coffee: 'src/coffee/**/*.coffee'

dists =
  html: 'dist/'
  css: 'dist/css/'
  js: 'dist/js/'

gulp.task 'default', ['browser-sync', 'watch']

# Watch task
gulp.task 'watch', ->
  gulp.watch 'src/templates/**/*.jade', ['jade']
  gulp.watch srcs.scss, ['sass']
  gulp.watch srcs.coffee, ['coffee']

# Jade task
gulp.task 'jade', ->
  gulp.src srcs.jade
    .pipe plumber()
    .pipe changed('dist', extension: '.html')
    .pipe data((file) ->
      JSON.parse fs.readFileSync(srcs.data + path.basename(file.path) + '.json'))
    .pipe jade pretty:true
    .pipe gulp.dest dists.html
    .pipe browserSync.reload(stream:true)
    .pipe notify('Templates task complete!')

# Sass task
gulp.task 'sass', ->
  sass('src/sass/',
    sourcemap: true
    loadPath: [srcs.scss].concat(neat)
  )
  .on('error', (err) ->
    console.error 'Error', err.message
    return
  )
  .pipe prefix(browsers: ['last 15 versions', '> 1%', 'ie 8', 'ie 7'])
  .pipe sourcemaps.write('../sourcemaps')
  .pipe gulp.dest dists.css
  .pipe filter '**/*.css'
  .pipe browserSync.reload(stream:true)
  .pipe notify('Styles task complete!')

# CoffeeScript task
gulp.task 'coffee', ->
  gulp.src 'src/coffee/*.coffee'
    .pipe plumber()
    .pipe sourcemaps.init()
    .pipe include()
    .pipe coffee()
    .pipe minifyJS()
    .pipe sourcemaps.write('../sourcemaps')
    .pipe gulp.dest dists.js
    .pipe browserSync.reload(stream:true)
    .pipe notify('Script task complete!')

coffeeStream = coffee(bare: true)
coffeeStream.on 'error', (err) ->

# Browser-sync task
gulp.task 'browser-sync', ['jade', 'sass', 'coffee'], ->
  browserSync server: baseDir: 'dist'
  return
