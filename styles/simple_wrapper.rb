module Styles
    class SimpleWrapper < Style

	def initialize(options)
		super
	end

	#Simple Wrapper commenting style.
	#Example :
	#	#-----------------------------
	#	#  This is a sample comment
	#	#-----------------------------
	def style_it(comment_lines)

	    max_length = max_line_length comment_lines
	    min_whitespace = min_whitespace comment_lines

	    #Builds the opening of the comment section. Maintaining leading whitespace.
	    opening = "#{min_whitespace}#{@options[:literal]}#{build(max_length + 5) unless @options[:semi]}\n" 

	    #Adds special styles to the comment lines.
	    #Lines with different # indentations are aligned together. 
	    #However, the actual indentation is retained.
	    #For example :
	    #	# Main comment
	    #		# Sub comment
	    #Changes to  :
	    #	# Main comment
	    #	# 	Sub comment
	    comment_lines.map! do |line|
		leading_whitespace = line[/^[\t\s]+/] || ""
		line = line.sub(@options[:literal],'').lstrip.chomp
		line = "#{min_whitespace}#{@options[:literal]} #{leading_whitespace.sub(min_whitespace,'')}#{line}"
	    end

	    #Builds closing section of the comments.
	    closing = "#{min_whitespace}#{@options[:literal]}#{build(max_length + 5)}\n"
	    [opening, ensure_newlines(comment_lines), closing].join
	end

	def build(n)
		ret = '-'*n
		if @options[:alt]
		    1.step(ret.length-1, 2) do |i|
			ret[i] = ' '
		    end
		end
		ret
	end

    end
end

