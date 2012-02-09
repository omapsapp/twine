module Twine
  module Formatters
    class Abstract
      def self.can_handle_directory?(path)
        return false
      end

      def default_file_name
        raise NotImplementedError.new("You must implement default_file_name in your formatter class.")
      end

      def determine_language_given_path(path)
        raise NotImplementedError.new("You must implement determine_language_given_path in your formatter class.")
      end

      def read_file(path, lang, strings)
        raise NotImplementedError.new("You must implement read_file in your formatter class.")
      end

      def write_file(path, lang, tags, strings)
        raise NotImplementedError.new("You must implement write_file in your formatter class.")
      end

      def write_all_files(path, tags, strings)
        if !File.directory?(path)
          raise Twine::Error.new("Directory does not exist: #{path}")
        end

        Dir.foreach(path) do |item|
          lang = determine_language_given_path(item)
          if lang
            write_file(File.join(path, item, default_file_name), lang, tags, strings)
          end
        end
      end
    end
  end
end
