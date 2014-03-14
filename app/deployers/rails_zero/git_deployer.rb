module RailsZero
  class GitDeployer
    def run
      extract_package
      push_package
    end

    def package_path
      PackagesClient.new.download_destination
    end

    def dir
      Rails.root.join('tmp', 'rails_zero', 'deploy').to_s
    end

    def extracted_package_path
      File.join(dir, File.basename(package_path, File.extname(package_path)))
    end

    def create_dir
      FileUtils.mkdir_p(dir)
    end

    def remove_dir
      FileUtils.rm_rf(dir)
    end

    def extract_package
      remove_dir
      create_dir
      command = "tar -xf #{package_path} -C #{dir}"
      stdout_str, stderr_str, status = Open3.capture3(command)
    end

    def push_package
      Dir.chdir(extracted_package_path) do
        commands = []
        commands << "#{git_binary} init"
        commands << "#{git_binary} remote add origin #{git_remote_url}"
        commands << "#{git_binary} add --all ."
        commands << "#{git_binary} commit -m \"Deploy.\""
        commands << "#{git_binary} push -u --force origin master"
        stdout_str, stderr_str, status = Open3.capture3(commands.join(" && "))
      end
    rescue Errno::ENOENT => e
      raise RailsZero::Error, e.message
    end

    def git_binary
      RailsZero.config.deployment.git_binary
    end

    def git_remote_url
      RailsZero.config.deployment.url
    end
  end
end
