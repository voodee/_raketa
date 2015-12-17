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