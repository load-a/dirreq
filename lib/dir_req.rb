# frozen_string_literal: true

require_relative "dirreq/version"

# A module adapted from the DragonRuby Tomes library.
# Facilitates requiring Ruby files and directories.
module DirReq
  class Error < StandardError; end
  module_function

  # Requires all `.rb` files in a given directory, optionally filtering or prioritizing specific files.
  # @param directory [String] Directory containing files to require.
  # @param ignore [Array<String>] Files to ignore (relative paths).
  # @param load_first [String] A file to require first (relative path).
  # @return [void]
  def require_directory(directory = '.', ignore: %w[main.rb librarian.rb], load_first: nil)
    require load_first if load_first

    files = collect_file_paths(directory)

    files.reject! { |file| ignore.include?(file) }

    files.each { |file| require file }
  rescue LoadError => e
    handle_load_error(directory, e)
  end

  # Recursively collects paths for all `.rb` files in a directory.
  # @param directory [String] Root directory to search.
  # @return [Array<String>]
  def collect_file_paths(directory = '.')
    Dir.glob("#{directory}/**/*.rb").sort
  end

  # Outputs error details for load failures.
  # @param directory [String] Directory being loaded.
  # @param error [LoadError] The encountered error.
  # @return [void]
  def handle_load_error(directory, error)
    puts "Failed to load files in: #{directory}", "Current Working Directory: #{Dir.pwd}"
    puts "Error: #{error.message}"
    raise error
  end
end
