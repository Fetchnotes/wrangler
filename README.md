Wrangler
========

The goal of Wrangler: get your got'dang data into your got'dang webpage and stop worrying about it.

To use it with an object (or an array of objects):

    var w = new Wrangler(myObject, 'object-template')

This creates a two-way binding between the data in `myObject` and the `object-template` div.

API reference
=============

Wrangler object
---------------

All of these are methods of a `Wrangler` instance.

* **constructor**: `new Wrangler(model, template, options)`

  Wrangles the `model` to a `template`.

* `get(property, escaped)`

  Gets a property. It first checks the Wrangler to see if it has this property; if not, it finds the property in the model. If the property happens to be a function, it executes the function and returns the result. Otherwise, it just returns the property.

  `escaped` defaults to `true`; set it to `false` and it won't escape your HTML.

* `set(property, value)`

  Sets a property of the model (NOT of the Wrangler) and updates. Has some special stuff if your model is an array:

        // ... some logic for defining tasks ...
        tasksWrangler.set(0, { name: "Say hello to the world", done: false });
        tasksWrangler.set("done", true);

* `destroy(alsoDestroyModel)`

  Removes my element. Calling `myWrangler.destroy(true)` also destroys the model.

* `update()`

  Manually updates the DOM from the model (you could call it after the model changes without using `set()`).

Misc. utilities
---------------

* `Wrangler.addEvent(element, name, callback)`

  Binds the browser event `name` to the `element` you choose, and executes the `callback` when it happens.

* `Wrangler.escape(html)`

  Escapes tags, ampersands, and breaking spaces.
