### Styles

Please follow this template when describing a comment style.
And note that general options are applicable to all styles, so they are taken out of each 
styles option list. It's also possible to use multiple style types, for instance hyphen_block can take both semi and atl
types (this will be mentioned in each style by 'works with'). Btw, things in [] are optional.

List of styles.

* hyphen_block 

#### hyphen_block 

###### Comment Style :

    #-------------------------------------------
    # This is a sample hyphen_block comment.
    #-------------------------------------------

###### Specifying the style in shell :

    $ ruby scr.rb <file>.rb [-style=hyphen_block] [-<optionA> -<optionB> ... ]


###### Options : 

* `-alt`
  
  This adds space in between hyphens.
  Example :
      
      #- - - - - - - - - - - - - - - - - - - - - - - - - 
      # This is a sample alternate hyphen_block comment.
      #- - - - - - - - - - - - - - - - - - - - - - - - -
  Works with : `semi`

* `-semi`
  
  This adds hyphens only below the comment block.
  Example :

      #
      # This is a sample semi hyphen_block comment.
      #-------------------------------------------------
  Works with : `alt`




