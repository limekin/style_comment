require "./lib/style.rb"

module StyleComment

    module Errors
	    
	    class InvalidStyle < StandardError
		def message
		    "Invalid style name. For a list of valid style names run thor scr:help prettify"
		end
	    end
    end

    class Styler

	    def initialize(file, options = {})
		@file = file
		@options = options
	    end

	    #Styles the comments in the file depending on options[:style]. 
	    #The default style is simple_wrapper.
	    def style_it

		#Fetches the style class from the list of ./styles.
		style_instance = fetch_style_class

		File.open( @file, "r" ) do |input|
		    File.open( "#{File.dirname(@file)}/sc_#{File.basename(@file)}" , "w") do |output|

			comment_lines = []
			show_something?(lines = input.readlines)
			
			lines.each do |line|
			    if line[/\S/] == @options[:literal] 
				comment_lines << line
			    elsif not comment_lines.empty?
				modified_comments = style_instance.style_it comment_lines 
				comment_lines.clear
				output << modified_comments
				output << line
			    else
				output << line
			    end
			end

		    end
		end
		puts "Done !"
	    end

	    #Fetches the style class from ./styles, if it's valid.
	    def fetch_style_class
		styles = Dir.entries("./styles").select do |entry|
		    File.extname(entry).eql? ".rb"
		end

		style_def = styles.detect do |style|
		    File.basename(style, ".rb") == @options[:style].to_s
		end

		raise Errors::InvalidStyle unless style_def

		require "./styles/#{style_def}"

		style_class_name = classify File.basename(style_def, ".rb")
		style_class = Styles.const_get style_class_name
		style_class.new(@options)

	    end

	    #Just displays cool messages. lol.
	    def show_something?(comment_set)
		comment_count = comment_set.count do |line| 
		    Regexp.new("^[\s\t]*#{@options[:literal]}+.*$") =~ line
		end
		puts "#{comment_count} comment#{comment_count>1 ? 's' : ''} found."
		puts "#{comment_count.zero?? "Nothing to change." : "Processing ..."}"
	    end


	    #Similar to constantize.
	    def classify(string)
		    string  = string.to_s
		    string.split("_").map(&:capitalize).join
	    end

    end
end

