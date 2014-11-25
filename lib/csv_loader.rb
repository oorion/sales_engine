require 'csv'

module CSVLoader
  def get_file_path(file_name)
    expanded_path = File.expand_path('.', __dir__)
    File.join(expanded_path, file_name)
  end

  def load_file(file_name)
    file_path = get_file_path(file_name)
    CSV.open(file_path, headers: true, header_converters: :symbols)
  end
end
