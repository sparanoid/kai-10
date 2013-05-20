"use strict"

module.exports = (grunt) ->

  # Load all grunt tasks
  matchdep = require("matchdep")
  matchdep.filterDev("grunt-*").forEach grunt.loadNpmTasks

  # Configurable paths
  coreConfig =
    app: "."
    assets: "."
    dist: "."
    pkg: grunt.file.readJSON('package.json')
    banner: do ->
      banner = "/*\n"
      banner += " * (c) <%= core.pkg.author %>.\n *\n"
      banner += " * <%= core.pkg.name %> - v<%= core.pkg.version %> (<%= grunt.template.today('mm-dd-yyyy') %>)\n"
      banner += " * <%= core.pkg.homepage %>\n"
      banner += " * <%= core.pkg.license.type %> - <%= core.pkg.license.url %>\n"
      banner += " */"
      banner

  # Project configurations
  grunt.initConfig
    core: coreConfig

    watch:
      # gruntfile:
      #   files: "Gruntfile.coffee"
      #   tasks: ["jshint:gruntfile"]

      less:
        files: ["<%= core.app %>/{,*/}*.less"]
        tasks: ["less:server"]

    less:
      server:
        options:
          paths: ["<%= core.app %>"]
          dumpLineNumbers: "all"

        files:
          "<%= core.app %>/core.css": "<%= core.app %>/core.less"

      dist:
        options:
          paths: ["<%= core.app %>"]
          # yuicompress: true

        files:
          "<%= core.app %>/core.css": "<%= core.app %>/core.less"

    cssmin:
      dist:
        options:
          banner: "<%= core.banner %>"

        files:
          "<%= core.dist %>/core.css": [".tmp/{,*/}*.css", "<%= core.app %>/{,*/}*.css"]

    compress:
      dist:
        options:
          archive: "<%= core.app %>/.tmp/<%= core.pkg.name %>.zip"

        files: [
          expand: true
          cwd: "<%= core.app %>/"
          src: ["**", "!node_modules/**", "!notifier/**", "!*.coffee", "!*.json", "!*.less"]
          dest: "<%= core.pkg.name %>"
        ]

    copy:
      dist:
        files: [
          expand: true
          cwd: "<%= core.app %>/.tmp/"
          src: ["<%= core.pkg.name %>*.zip"]
          dest: "/Users/sparanoid/Dropbox/Sites/static.sparanoid.com/download/"
        ]

    # TODO: `cwd` doesn't work here.
    rename:
      dist:
        files: [
          src: ["<%= core.app %>/.tmp/<%= core.pkg.name %>.zip"]
          dest: "<%= core.app %>/.tmp/<%= core.pkg.name %>-<%= core.pkg.version %>.zip"
        ]

    replace:
      dist:
        options:
          variables:
            "version": "<%= core.pkg.version %>"
            "package": "<%= core.pkg.name %>"
          prefix: "@@"

        files: [
          expand: true
          flatten: true
          cwd: "<%= core.app %>/"
          src: ["notifier/<%= core.pkg.name %>.json"]
          dest: "/Users/sparanoid/Dropbox/Sites/sparanoid.com/lab/wordpress/"
        ]

    clean: ["<%= core.app %>/.tmp"]

  grunt.registerTask "server", ["watch"]

  grunt.registerTask "build", ["clean", "less:dist", "cssmin", "compress", "copy", "rename", "copy", "replace", "clean"]

  grunt.registerTask "default", ["build"]