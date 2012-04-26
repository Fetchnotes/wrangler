###

Wrangler

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

window.wrangle = (model, template, options) ->

	# Get the wrangler object we'll be returning
	wrangler = {}

	# Give this wrangler the model
	wrangler.model = model

	# Get template element
	if ($?) and (template instanceof $)
		template = template[0]
	if (typeof template is 'string') or (template instanceof String)
		template = document.getElementById(template)
	wrangler.element = template
	wrangler.template = template.innerHTML

	# Update the DOM
	wrangler.update = ->
		if @model instanceof Array
			output = ''
			for m in @model
				output += window.Milk.render(@template, m)
			@element.innerHTML = output
		else
			@element.innerHTML = window.Milk.render(@template, @model)

	# Set a property and then update
	wrangler.set = (index, property, value) ->
		if value?
			@model[index][property] = value
		else
			@model[index] = property
		@update()

	# Update the DOM
	wrangler.update()

	# We're done!
	return wrangler