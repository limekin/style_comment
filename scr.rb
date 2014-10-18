module StyleComment

    module Styles
	    
	    #List of all the comment styles.
	    LIST = [:hyphen_block]

	    #Makes sure every comment line has a line ending.
	    def self.ensure_newlines(comment_lines)
		comment_lines.map do |line|
		    line << "\n" unless line[-1].eql? "\n"
		end
	    end

	    #hyphen_block commenting style.
	    #Example :
	    #	#-----------------------------
	    #	#  This is a sample comment
	    #	#-----------------------------
	    def self.hyphen_block(comment_lines)

		
		build = ->(n) { '-' * n }

		#Gets the minimum leading white space of the comment set. 
		#This space is then used to align all the subsequent comments.
		min_whitespace = comment_lines.reduce(" "*500) do |min_whitespace, line|
			whitespace = line[/^[\t\s]+/] || ""
			min_whitespace = whitespace if whitespace.length < min_whitespace.length
			min_whitespace
		end

		#Builds the opening of the comment section. Maintaining leading whitespace.
		opening = "#{min_whitespace}##{build[15]}\n" 

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
		    line = line.sub('#','').lstrip.chomp
		    line = "#{min_whitespace}# #{leading_whitespace.sub(min_whitespace,'')}#{line}"
		end

		#Builds closing section of the comments.
		closing = "#{min_whitespace}##{build[15]}\n"
		[opening, ensure_newlines(comment_lines), closing].join ''
	    end


    end

    class Styler

	    def initialize(file_path, options = {})
		@file = file_path
		@options = options
		@options[:style] ||= :hyphen_block
	    end

	    #Styles the comments in the file depending on options[:style]. 
	    #The default style is :hyphen_block.
	    def style_it
		File.open( @file, "r" ) do |input|
		    File.open( "#{File.dirname(@file)}/sc_#{File.basename(@file)}" , "w") do |output|
			comment_lines = []
			input.readlines.each do |line|
			    if line[/\S/] == "#"
				comment_lines << line
			    elsif not comment_lines.empty?
				modified_comments = Styles.send( @options[:style],comment_lines )
				comment_lines.clear
				output << modified_comments
				output << line
			    else
				output << line
			    end
			end
		    end
		end
	    end
    end
end
    
#Handles the shell invokes
file = ARGV.shift
options = {}
if ARGV
    ARGV.each do |arg|
       option, value = arg.split('=')
       option = option.gsub('-','').to_sym
       value = value.to_sym
       options[option] = value
    end
end

styler = StyleComment::Styler.new( file, options ) 
styler.style_it
