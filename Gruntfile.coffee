module.exports = (grunt)->
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-watch')

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

    concat:
      js: 
        src: ['site/javascripts/client-side-define.js','site/javascripts/*.js']
        dest: 'site/javascripts/all.js'

    watch:
      coffee:
        files: ['lib/**/*.coffee'] 
        tasks: ['build']

  grunt.registerTask('build', ['coffee','concat'])
      
