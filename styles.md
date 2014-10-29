### Styles

Please follow this template when describing a comment style.
And note that general options are applicable to all styles, so they are taken out of each 
styles option list. It's also possible to use multiple style types, for instance hyphen_block can take both semi and atl
types (this will be mentioned in each style by 'works with'). Btw, things in [] are optional.

List of styles.

* simple_wrapper

#### Simple Wrapper 

###### Comment Style :

    #-------------------------------------------
    # This is a sample Simple Wrapper comment.
    #-------------------------------------------

###### Specifying the style in shell :

    $ thor scr:prettify <file>.rb [--style=simple_wrapper] [--<optionA> --<optionB> ... ]


###### Options : 

* `--alt`
  
  This adds space in between hyphens.
  Example :
      
      #- - - - - - - - - - - - - - - - - - - - - - - - - 
      # This is a sample alternate Simple Wrapper comment.
      #- - - - - - - - - - - - - - - - - - - - - - - - -
  Works with : `semi`

* `--semi`
  
  This adds hyphens only below the comment block.
  Example :

      #
      # This is a sample semi Simple Wrapper comment.
      #-------------------------------------------------
  Works with : `alt`




