require 'thor'
require './scr.rb'

class Scr < Thor

    desc "prettify FILE", "File that contains comments to process."
    method_option :style, :desc => "Name of the commenting style.", :default => :simple_wrapper, 
		  :enum => %w(simple_wrapper), :aliases => "s"

    method_option :literal, :aliases => "l", :desc => "The comment literal you want to use for detecting comments.",
		  :default => "#"  

    method_option :alt, :type => :boolean, :desc => "Adds alternate comment style patterns."
    method_option :semi, :type => :boolean, :desc => "Adds comment styles only to the bottom of the comment set."
    def prettify(file)
	StyleComment::Styler.new( file, options).style_it
    end

end

