# Protect legacy apps that already define jquery downloading it again
if !!window.jQuery then define('jquery', [], -> jQuery )

require ['jquery', 'lib/core/base'], ($, Base) ->
  $ ->
    base = new Base()

