module Styles
    class Style

	def initialize(options)
		@options = options
	end

	#Just makes sure that every comment line has is a LINE.
	def ensure_newlines(comment_lines)
	    comment_lines.map do |line|
		line << "\n" unless line[-1].eql? "\n"
	    end
	end
	
	#Finds the length of the longest comment.
	#Note this includes the leading whitespaces, if any.
	def max_line_length(comment_lines)
	    comment_lines.reduce(0) do
		|acc, line| acc < line.length ? line.length : acc
	    end
	end

	#Gets the minimum leading white space of the comment set. 
	#This space can be used to align other comment lines with different
	#leading whitespaces.
	def min_whitespace(comment_lines)
	    comment_lines.reduce(" "*500) do |min_whitespace, line|
		whitespace = line[/^[\t\s]+/] || ""
		whitespace.length < min_whitespace.length ? whitespace : min_whitespace

	    end
	end


    end
end
