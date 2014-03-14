module RailsZero
  class Error < StandardError
  end

  class MissingPackageError < Error
  end

  class GitError < Error

  end
end
