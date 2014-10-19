### Style Comment


A simple ruby command line script to modify all the comments in a file to a particular style. Created it for fun :laughing:.

For a list of styles and options see `styles.md`. Feel free to add more comment styles.

#### Usage

Without specifying the style (defaults to hyphen_block).

    ruby scr.rb <targetfile>.rb

Or with a particular style.

    ruby scr.rb <targetfile>.rb -style=<style>

The modified file will be named `sc_<filename>.rb`.








