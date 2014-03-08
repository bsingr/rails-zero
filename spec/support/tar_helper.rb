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
end
