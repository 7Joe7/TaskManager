module DataHelper

  def load_data(address, klass)
    structure = []
    JSON.parse(load_file_text(address), {:symbolize_names => true}).each do |name, pars|
      structure << klass.new({name: name.to_s}.merge(pars))
    end
    structure
  end

  def save_data(data, address)
    hash = {}
    data.each { |entry| hash.merge!(entry.to_hash) }
    create_file(address, JSON.pretty_generate(hash))
  end
end