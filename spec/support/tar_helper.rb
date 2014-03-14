require 'rubygems/package'

module TarHelper
  def self.read path
    paths = []
    Gem::Package::TarReader.new(File.new(path)) do |tar|
      tar.each do |tarfile|
        paths << tarfile.full_name
      end
    end
    paths
  end

  def self.create destination_path, source_path
    Dir.chdir(File.dirname(source_path)) do
      cmd = "tar -cf #{destination_path} #{File.basename(source_path)}"
      l, e, s = Open3.capture3(cmd)
      raise e unless e.empty?
    end
  end
end
