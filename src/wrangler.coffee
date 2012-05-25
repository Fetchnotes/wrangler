###

Wrangler
by Evan Hahn

Get your got'dang data into your got'dang webpage and stop worrying about it.

*******************************************************************************

Copyright (c) 2012, Fetchnotes LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

###

class window.Wrangler

	# Constructor.
	constructor: (@model, template, options) ->

		# Assigns the template and the DOM element and accepts jQuery/Zepto, a
		# string ID, or just a straight DOM element.
		if ($) and (template instanceof $)
			template = template[0]
		if (typeof template is 'string') or (template instanceof String)
			template = document.getElementById(template)
		@el = template
		@template = @el.innerHTML

		# By default, bind the change event to an update.
		Wrangler.addEvent(@el, 'change', @update)

		# Initial DOM update.
		@update()

	# Get a property.
	get: (property, escaped = true) ->

		# Who owns the property?
		if this[property]
			result = this[property]
			scope = this
		else
			result = @model[property]
			scope = @model

		# If it's a function, return its output
		if typeof result is 'function'
			result = result.call(scope)

		# Escape HTML if I should
		if escaped
			result = Wrangler.escape result

		# All done!
		result

	# Set a property of the model and then update.
	# Can batch set array elements.
	set: (property, value) ->
		if (property.valueOf() is 'number') and (@model instanceof Array)
			m[property] = value for m in @model
		@model[property] = value
		@update()

	# Destroy me.
	destroy: (alsoDestroyModel = false) ->
		@el.parentNode.removeChild(@el)
		delete @el
		delete @model if alsoDestroyModel

	# Update DOM.
	update: ->
		if @model instanceof Array
			output = ''
			for m in @model
				output += window.Milk.render(@template, m)
			@element.innerHTML = output
		else
			@element.innerHTML = window.Milk.render(@template, @model)

# Add an event to the DOM.
Wrangler.addEvent = (element, name, callback) ->
	if element.addEventListener
		element.addEventListener(name, callback, false)
	else if element.attachEvent
		element.attachEvent("on#{name}", callback)

# Escape some text to safe HTML.
Wrangler.escape = (html) ->
	html.replace(/&/g, '&amp;').replace(/</g, "&lt;").replace(/>/g, '&gt;').replace(/\ \ /g, '&nbsp;&nbsp;')
