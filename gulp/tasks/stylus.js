// include the required packages.
var gulp         = require('gulp'),
    browserSync  = require('browser-sync'),
    stylus       = require('gulp-stylus'),
    sourcemaps   = require('gulp-sourcemaps'),
    handleErrors = require('../util/handleErrors'),
    config       = require('../config').stylus,
    myth         = require('gulp-myth'),
    nib          = require('nib'),
    bootstrap    = require('bootstrap-styl');



gulp.task('stylus', function () {
  return gulp.src(config.src)
    .pipe(sourcemaps.init())
    .pipe(stylus({
      use: [nib(), bootstrap()]
      //compress: true
    }))
    .on('error', handleErrors)
    .pipe(sourcemaps.write())
    //.pipe(myth())
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload({stream:true}));
});