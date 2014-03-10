module AssetsHelper
  def self.path *args
    File.expand_path(File.join('..', '..', 'assets', *args), __FILE__)
  end
end
