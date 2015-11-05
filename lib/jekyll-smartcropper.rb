require "jekyll-smartcropper/version"
require 'smartcropper'
require 'RMagick'

include Magick
include FileUtils

module Jekyll
  module SmartCropperGen
    # This part is copied from https://github.com/kinnetica/jekyll-plugins
    # Recover from strange exception when starting server without --auto
    class GeneratedImageFile < StaticFile
      def write(dest)
        begin
          super(dest)
        rescue
        end
        true
      end
    end

    class ImageGenerator < Generator
      def generate(site)
        return unless site.config['smartcropper']

        print "  Starting SmartCropper...\n"

        site.config['smartcropper'].each_pair do |name, preset|
          print "    Generating '" + name + "'\n"

          @dest_dir = preset['destination']
          @src_dir = preset['source']
          @process = preset['process']
          @width = preset['width']
          @height = preset['height']

          Dir.glob(File.join(site.source, @src_dir, "*.{png,jpg,jpeg,gif}")) do |file|
            dest_file = file.sub(@src_dir, @dest_dir)

            FileUtils.mkdir_p(File.dirname(dest_file))

            puts case @process
              when "crop_and_scale"
                SmartCropper.from_file(file).smart_crop_and_scale(@width, @height).write(dest_file)
              when "crop"
                SmartCropper.from_file(file).smart_crop(@width, @height).write(dest_file)
              when "square"
                SmartCropper.from_file(file).smart_square.write(dest_file)
              when "resize"
                img = Magick::Image.read(file).first
                new_img = img.resize(@width, @height)
                new_img.write dest_file
              when "resize_to_fill"
                img = Magick::Image.read(file).first
                new_img = img.resize_to_fill(@width, @height)
                new_img.write dest_file
              when "resize_to_fit"
                img = Magick::Image.read(file).first
                new_img = img.resize_to_fit(@width, @height)
                new_img.write dest_file
              else               
                img = Magick::Image.read(file).first
                new_img = img.resize(@width, @height)
                new_img.write dest_file
            end

            site.static_files << GeneratedImageFile.new(site, site.source, @dest_dir, File.basename(dest_file))
          end
        end
      end
    end
  end
end