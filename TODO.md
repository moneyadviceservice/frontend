# TODO on Content Hub Design page

- sort out routing so it doesn't take over the contact us page
	- maybe it doesn't really want to be a static page

- sort out setting styles on #main conditionally on this page being viewed.
	- do via the unconstrained layout

- how are the background images going to be implemented via CMS?
	- I guess like the home page is: adds it inline to the containing div
	- this means some restraints apply to the use of images:
		- must be sized precisely (or at least using common aspect ratio) since the CSS will not be edited, must be generic enough.
		- the hero image may be set within the CSS perhaps - provided it is sized and uses a consistent naming convention.
		- can't switch images responsively (except hero if it uses the convention above)
		- and images should be cropped (no extraneous white space).
		- or can we use <img> instead of background-image?
