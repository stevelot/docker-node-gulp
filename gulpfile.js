// <reference path="node_modules/@types/gulp/index.d.ts" />
// Gulp file voorbeeld: https://github.com/DanWahlin/AngularIn20TypeScript/blob/master/gulpfile.js

const { src, watch, parallel } = require('gulp');
const sftp = require('gulp-sftp');
const watchList = ['src/**/*.js', 'src/**/*.css', 'src/**/*.html'];
//import rename from 'gulp-rename';
//// var browserSync  = require('browser-sync').create();

//var gulp = require('gulp');
//gulp.task('test', (cb) => {
//  console.log('gulp task test');
//  cb();
//});

function devUpload() {
  console.log('Upload...');
  return src(watchList)
    .pipe(sftp({
      host: 'sftp.server.host.name',
      user: 'user',
      pass: process.env.FTP_PASS,
      remotePath: '/u02/apex_images/182/images'
    }) );
}

function devWatch(cb) {
  var watcher = watch(watchList, {events: 'all', usePolling: true});
  watcher.on('all', function(path, status) {
    console.log(`File "${path}" "${status}"! minify? (copy) + upload ...`);
    devUpload();
  });
  cb();
}

exports.default = parallel(devWatch, devUpload);




//exports.default = () => {
//  watch('src/test.txt', {events: 'all', ignoreInitial: false, usePolling: true}, (cb) => {
//    console.log('werkt dit nu (met polling)?...');
//    cb();
//  });
//};

//  
//  // Uploaden naar dev via sftp: 
//  gulp.task('dev-upload', ['minify'], function () {
//    return gulp.src(['dist/*'])
//      .pipe(sftp({
//        host: 'sftp.server.host.name',
//        user: 'user',
//        pass: process.env.FTP_PASS,
//        remotePath: '/u02/apex_images/51/images'
//      }));
//  });

//  // Aanpassingen in bestanden oppikken en minify + upload starten.
//  gulp.task("watch", function(){
//    var watcher = gulp.watch(['src/*.js'], ['dev-upload']);
//    watcher.on('change', function(event) {
//      console.log('File "' + event.path + '" ' + event.type + '! minify (copy) + upload ...');
//    });
//  });
//  
//  gulp.task('default', ["watch", "dev-upload"]);
//  







//Gulp3.x : 
// -----------------------------------------------------------
//  var gulp         = require("gulp");
//  // var browserSync  = require('browser-sync').create();
//  var rename       = require('gulp-rename');
//  var sftp         = require('gulp-sftp');
//  
//  
//  // // Static sync server
//  // gulp.task('browser-sync', function() {
//  //     browserSync.init([
//  //             '*.*',
//  //             'dist/*.*',
//  //             'dist/**/*.*'
//  //         ], {
//  //         server: {
//  //             baseDir: "./"
//  //         },
//  //         browser: ["chrome"]
//  //         //browser: ["iexplore", "firefox", "chrome"]
//  //     });
//  // });
//  // //      startPath: "/index.html",
//  
//  // Uploaden naar dev via sftp: 
//  gulp.task('dev-upload', ['minify'], function () {
//    return gulp.src(['dist/*'])
//      .pipe(sftp({
//        host: 'sftp.server.host.name',
//        user: 'user',
//        pass: process.env.FTP_PASS,
//        remotePath: '/u02/apex_images/51/images'
//      }));
//  });
//  
//  
//  //gulp.task('minify', function(){
//  //  return gulp.src(['src/*.js'])
//  //    .pipe(gulp.dest('dist'))
//  //    .pipe(rename(function(path){
//  //      path.basename += '.min'
//  //    }))
//  //    .pipe(gulp.dest('dist'));
//  //});
//  
//  // Aanpassingen in bestanden oppikken en minify + upload starten.
//  gulp.task("watch", function(){
//    var watcher = gulp.watch(['src/*.js'], ['dev-upload']);
//    watcher.on('change', function(event) {
//      console.log('File "' + event.path + '" ' + event.type + '! minify (copy) + upload ...');
//    });
//  });
//  
//  gulp.task('default', ["watch", "dev-upload"]);
//  