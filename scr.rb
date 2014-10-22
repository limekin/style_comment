module StyleComment

    module Styles
	    
	    #List of all the comment styles.
	    LIST = [:hyphen_block]

	    class Style

		    def initialize(options)
			    @options = options
		    end

		    def ensure_newlines(comment_lines)
			comment_lines.map do |line|
			    line << "\n" unless line[-1].eql? "\n"
			end
		    end

	    end

	    class HyphenBlock < Style


		    def initialize(options)
			    super
		    end

		    #Makes sure every comment line has a line ending.

		    #hyphen_block commenting style.
		    #Example :
		    #	#-----------------------------
		    #	#  This is a sample comment
		    #	#-----------------------------
		    def style_it(comment_lines)

			#Finds the longest line length.
			max_length = comment_lines.reduce(0) { |acc, line| acc < line.length ? line.length : acc }

			min_whitespace = get_min_whitespace comment_lines

			#Builds the opening of the comment section. Maintaining leading whitespace.
			opening = "#{min_whitespace}##{build(max_length + 5) unless @options[:semi]}\n" 

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
			closing = "#{min_whitespace}##{build(max_length + 5)}\n"
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

		    #Gets the minimum leading white space of the comment set. 
		    #This space is then used to align all the subsequent comments.
		    def get_min_whitespace(comment_lines)
			comment_lines.reduce(" "*500) do |min_whitespace, line|
			    whitespace = line[/^[\t\s]+/] || ""
			    whitespace.length < min_whitespace.length ? whitespace : min_whitespace

			end
		    end
		end


    end

    module Errors
	    
	    class InvalidStyle < StandardError
		def message
		    "Invalid style name. For a list of valid style names run -help=styles"
		end
	    end
    end

    class Styler

	    #Note that Style constructor should only handle general defaults.
	    #Style specific defaults should be handled in Styles.<style>.
	    def initialize(file_path, options = {})
		@file = file_path
		@options = set_defaults(options)


	    end

	    def set_defaults(options)
		    { :style => :hyphen_block }.merge(options) 
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
				modified_comments = apply( @options[:style],comment_lines, @options )
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

	    #Delegates the styling to the given style class if it's valid.
	    def apply( style_name, comment_lines, options)

		    style_class_name = classify(style_name).to_sym
		    begin
			style_class = Styles.const_get(style_class_name)
			style = style_class.new(options) 
			raise Errors::InvalidStyle unless style.is_a? Styles::Style
		    rescue NameError
			raise Errors::InvalidStyle
		    end
			
		    style.style_it(comment_lines)
 	
	    end

	    def classify(string)
		    string  = string.to_s
		    string.split("_").map(&:capitalize).join
	    end

		    

    end
end
    
#Handles the shell invokes
file = ARGV.shift
options = {}
if ARGV
    ARGV.each do |arg|
	if arg.include? '='
	    option, value = arg.split('=')
	elsif arg.include? '-'
	    value, option = arg.split('-')
	end
	option = option.gsub('-','').to_sym
	value = value.to_sym
	options[option] = value
    end
end

styler = StyleComment::Styler.new( file, options ) 
styler.style_it
