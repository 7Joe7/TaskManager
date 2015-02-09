# encoding: UTF-8

module FilesHelper
  def make_dir(file_address)
    Dir.mkdir(file_address) unless Dir.exists?(file_address)
  end

  def modify_file_content(address)
    file_content = File.open(address, 'r') { |f| f.read }
    new_file_content = yield file_content
    File.open(address, 'w+') { |f| f.write(new_file_content) }
  end

  def create_file_by_template(template_path, path)
    text = load_file_text(template_path)
    yield text if block_given?
    create_file(path, text)
  end

  def load_file_text(path)
    if File.exists?(path)
      file_text = File.open(path, 'r') { |f| f.read }
      # puts "File #{path} loaded."
      file_text
    else
      puts "File #{path} doesn't exist."
      nil
    end
  end

  def create_file(path, text)
    File.open(path, 'w+') { |f| f.write(text) }
    # puts "File #{path} created."
  end

  # Replaces text in all files in the folder address
  # @param text [String] text to be replaced
  # @param folder_address [String] folder address to search in
  # @return nil
  def replace_in_all(text, folder_address)
    folder_address = get_folder_content_address(folder_address)
    Dir[folder_address].each do |address|
      content = File.open(address, 'r') { |f| f.read }
      if content.gsub!(text) { |match| yield match }
        File.open(address, 'w+') { |f| f.write(content)}
        puts "Replaced all in: #{address}."
      end
    end
  end

  # Puts all file addresses which contain the text
  # @param text [String] searched text
  # @param folder_address [String] folder address searched ended with /*
  # @return nil
  def find_in_all(text, folder_address)
    folder_address = get_folder_content_address(folder_address)
    Dir[folder_address].each do |address|
      content = File.open(address, 'r') { |f| f.read }
      puts "Found in file: #{address}" if content.match(%r{#{text}})
    end
  end

  def catch_errno_enoent
    yield
  rescue Errno::ENOENT => e
    # Nothing bad happened
  end

  private

  # @param folder_address [String] folder_address to convert
  # @return folder_address [String] folder_address ending '/*'
  def get_folder_content_address(folder_address)
    case folder_address[-1]
      when '*'
        return folder_address
      when '/'
        return folder_address + '*'
      else
        return folder_address + '/*'
    end
  end
end