### Style Comment


#### Description

A simple ruby command line script to modify all the normal block comments in a (currently ruby) file to a particular style. Created it for fun :laughing:.


#### Usage

Without specifying the style (defaults to simple_wrapper).

    $ thor scr:prettify <targetfile>.rb

Or with a particular style.

    $ thor scr:prettify <targetfile>.rb --style=<style>

The modified file will be named `sc_<filename>.rb`. This is because I haven't made any test suites yet to verify the 
integrity if it were to replace the original file.

For help use `thor scr:help prettify`. And for a detailed list of styles and options see `styles.md`.


#### Examples

A block of comments like :

    #This is a comment line.
    #This is another comment line.


Becomes something like : 

    #-------------------------------------
    # This is a comment line.
    # This is another comment line.
    #-------------------------------------

#### Contribution

* If you want to add a style and do not want to implement it, then you can fork this repo and add the details of the
style in `styles.md` with the formats given in there. You should also include "(not implemented)" (or even something like that :laughing:) to the title of the style. So later someone can implement it for you.

* If you want to add a style and implement it, then first follow the previous step ( avoid appending 'not implemented' to titles ). And follow these :
    * Add a ruby file with name of your style to the styles folder.
    * In case there are more than one word in the name, use underscores to separate them. Example "two_words.rb".
    * In the file, create a subclass of `Style` inside the `Styles` module. The class name should be equal to that
    of the filename when constantized. Example : "two_words.rb" becomes "TwoWords".
    * Write a public method named `style_it` that takes a set of comments and returns the modified version of them.

* Request other contributions in the normal way.








