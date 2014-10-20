### Style Comment


A simple ruby command line script to modify all the block comments in a file to a particular style. Created it for fun :laughing:.

For a list of styles and options see `styles.md`. Feel free to add more comment styles.

#### Usage

Without specifying the style (defaults to hyphen_block).

    $ ruby scr.rb <targetfile>.rb

Or with a particular style.

    $ ruby scr.rb <targetfile>.rb -style=<style>

The modified file will be named `sc_<filename>.rb`.

#### Examples

A block of comments like :

    #This is a comment line.
    #This is another comment line.


Becomes something like : 

    #-------------------------------------
    # This is a comment line.
    # This is another comment line.
    #-------------------------------------

And I'm working on more styles and options. :laughing:







