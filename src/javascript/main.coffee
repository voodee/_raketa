window.jQuery     = window.$ = require 'jquery'
plugin            = require 'plugin'


window.classie = require './lib/classie.js'
require './lib/animationGreed.js'



jQuery(document).ready ($) ->
  #open navigation clicking the menu icon

  toggleNav = (bool) ->
    $('.cd-nav-container, .cd-overlay').toggleClass 'is-visible', bool
    $('main').toggleClass 'scale-down', bool
    

  loadNewContent = (newSection) ->
    #create a new section element and insert it into the DOM
    section = $('<section class="cd-section ' + newSection + '"></section>').appendTo($('main'))
    #load the new content from the proper html file
    section.load newSection + '.html .cd-section > *', (event) ->
      #add the .cd-selected to the new section element -> it will cover the old one
      section.addClass('cd-selected').on 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
        #close navigation
        toggleNav false

      section.prev('.cd-selected').removeClass 'cd-selected'

    $('main').on 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
      #once the navigation is closed, remove the old section from the DOM
      section.prev('.cd-section').remove()

    if $('.no-csstransitions').length > 0
      #if browser doesn't support transitions - don't wait but close navigation and remove old item
      toggleNav false
      section.prev('.cd-section').remove()


  $('.cd-nav-trigger').on 'click', (event) ->
    event.preventDefault()
    toggleNav true

  #close the navigation
  $('.cd-close-nav, .cd-overlay').on 'click', (event) ->
    event.preventDefault()
    toggleNav false

  #select a new section
  $('.cd-nav li').on 'click', (event) ->
    event.preventDefault()
    target = $(this)
    sectionTarget = target.data('menu')
    if !target.hasClass('cd-selected')
      #if user has selected a section different from the one alredy visible
      #update the navigation -> assign the .cd-selected class to the selected item
      target.addClass('cd-selected').siblings('.cd-selected').removeClass 'cd-selected'
      #load the new section
      loadNewContent sectionTarget
    else
      # otherwise close navigation
      toggleNav false



$(document).ready ->

  # $.mousewheel = require './lib/jquery.mousewheel.js'
  require('./lib/jquery.mousewheel.js')($);
  require './lib/jquery.simplr.smoothscroll.js'
  $.srSmoothscroll()


  skrollr = require './lib/skrollr.js'
  item_count_on_line = Math.floor( $('.item-container').width() / $('.item').width() )
  item_array = []
  $('.item').each (index, val) ->
    item_array.push val

    if index + 1 == item_count_on_line || index + 1 == $('.item').length
      item_max_height = $(item_array[0]).height()
      jQuery.each item_array, ->
        item_max_height = Math.max item_max_height, $(@).height()
      

      jQuery.each item_array, ->
        # $(@).data 'top', 'transform: translate3d(0px, ' + ( $(@).height() / 2 * -1 ) + 'px, 0px)'  
        # $(@).data 'bottom', 'transform: translate3d(0px, ' + ( item_max_height * 1 - $(@).height() / 2 ) + 'px, 0px)'

        item_height_margin = item_max_height - $(@).height()
        $(@).attr
          'data-top': 'transform: translate3d(0px, ' + ( item_height_margin / 100 * -1 ) + 'px, 0px)'  
          'data-bottom': 'transform: translate3d(0px, ' + ( item_height_margin + item_height_margin / 100 ) + 'px, 0px)'

      # Clear
      item_array = []
      

  s = skrollr.init()


  console.log 'test'

















































