module.exports = (grunt)->
  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.initConfig
    coffee:
      compile:
        options:
          sourceMap: false
        expand: true
        cwd: 'lib/'
        src: ['**/*.coffee']
        dest: 'site/javascripts/'
        ext: '.js'
