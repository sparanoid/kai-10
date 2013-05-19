"use strict"
LIVERELOAD_PORT = 35729
path = require("path")
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder = (connect, dir) ->
  connect.static path.resolve(dir)

module.exports = (grunt) ->

  # Load all grunt tasks
  matchdep = require("matchdep")
  matchdep.filterDev("grunt-*").forEach grunt.loadNpmTasks

  # Configurable paths
  coreConfig =
    app: ""
    assets: ""
    dist: ""
    pkg: grunt.file.readJSON('package.json')
    meta:
      # Build the JS banner based on pkg file data
      banner: do ->
        banner = "/* <%= pkg.name %> - v<%= pkg.version %> - <%= pkg.homepage %>"
        banner += "\n"
        banner += "* Copyright (c) <%= grunt.template.today('yyyy') %> <%= pkg.author %>. All rights reserved."
        banner += "\n"
        banner += "* Licensed <%= _.pluck(pkg.licenses, 'type')[0] %> - <%= _.pluck(pkg.licenses, 'url')[0] %> */"
        banner += "\n"
        banner

  # Project configurations
  grunt.initConfig
    core: coreConfig

    watch:
      # gruntfile:
      #   files: "Gruntfile.js"
      #   tasks: ["jshint:gruntfile"]

      less:
        files: ["<%= core.assets %>/{,*/}*.less"]
        tasks: ["less:server"]

      livereload:
        options:
          livereload: LIVERELOAD_PORT

        files: [
          "<%= core.app %>/*.php",
          "{.tmp,<%= core.app %>}/{,*/}*.css"

          "<%%= core.app %>/*.php"
          "{.tmp,<%%= core.app %>}/styles/{,*/}*.css"
          "{.tmp,<%%= core.app %>}/scripts/{,*/}*.js"
          "<%%= core.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"
        ]

    connect:
      options:
        port: 9001
        # change this to '0.0.0.0' to access the server from outside
        hostname: "localhost"

      livereload:
        options:
          middleware: (connect) ->
            [mountFolder(connect, ".tmp"), mountFolder(connect, core.app), lrSnippet]

      dist:
        options:
          middleware: (connect) ->
            [mountFolder(connect, core.dist)]

    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    clean:
      dist:
        files: [
          dot: true
          src: [".tmp", "<%= core.dist %>/*", "!<%= core.dist %>/.git*"]
        ]

      server: ".tmp"

    less:
      dist:
        options:
          paths: ["<%= core.app %>/assets/less"]

        # yuicompress: true
        files:
          ".tmp/assets/css/main.css": "<%= core.app %>/assets/less/main.less"

      server:
        options:
          paths: ["<%= core.app %>/assets/less"]
          dumpLineNumbers: "all"

        files:
          ".tmp/assets/css/main.css": "<%= core.app %>/assets/less/main.less"

    cssmin:
      dist:
        files:
          "<%= core.dist %>/assets/css/main.css": [".tmp/assets/css/{,*/}*.css", "<%= core.app %>/assets/css/{,*/}*.css"]

    # Put files not handled in other tasks here
    copy:
      server:
        files: [
          expand: true
          dot: true
          flatten: true
          cwd: "<%= core.app %>"
          dest: ".tmp/assets/js/"
          src: ["components/jquery/jquery.min.js"]
        ]

      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= core.app %>"
          dest: "<%= core.dist %>"
          src: [
            "*.{ico,txt}"
            ".htaccess"
            "assets/img/{,*/}*.{webp,gif}"
            "assets/fonts/*"
          ]
        ,
          expand: true
          dot: true
          flatten: true
          cwd: "<%= core.app %>"
          dest: "<%= core.dist %>/assets/js/"
          src: ["components/jquery/jquery.min.js"]
        ]

      deploy:
        files: [
          expand: true
          cwd: "dist/"
          dest: "/Users/sparanoid/Dropbox/Sites/sparanoid.com/lab/lindsayisgod/"
          src: ["**"]
        ]

  grunt.renameTask "regarde", "watch"

  grunt.registerTask "server", (target) ->
    return grunt.task.run(["build", "open", "connect:dist:keepalive"])  if target is "dist"
    grunt.task.run ["clean:server", "concurrent:server", "livereload-start", "connect:livereload", "copy", "open", "watch"]

  grunt.registerTask "test", ["clean:server", "concurrent:test", "connect:test"]

  grunt.registerTask "build", ["clean:dist", "useminPrepare", "concurrent:dist", "cssmin", "uglify", "copy", "rev", "usemin"]

  grunt.registerTask "deploy", ["default", "copy:deploy"]

  grunt.registerTask "default", ["jshint", "test", "build"]
