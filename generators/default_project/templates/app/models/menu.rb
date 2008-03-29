class MenuItem < Struct.new('MenuItem', :key, :title, :url, :roles)
end

class Menu

	YML_DIR = "#{RAILS_ROOT}/db/yml/menu"

	attr_accessor :data

	def initialize(yml)
		@data = YAML.load(File.open("#{YML_DIR}/#{yml}.yml")).symbolize_keys
	end

	def show(parent_key = nil)
		str		= ''
		data	= parent_key.nil? ? @data : childs(parent_key)

		unless data.blank?
			data.sort { |a, b| a[1]['order'] <=> b[1]['order'] }.each do |item|
				str << yield(MenuItem.new(item[0], item[1]['title'], item[1]['url'], item[1]['roles'].to_s))
			end
		end

		str
	end

	private
		def childs(key)
			if	@data.include?(key) &&
				@data[key].include?('childs') &&
				!@data[key]['childs'].blank?

				@data[key]['childs'].symbolize_keys
			else
				[]
			end
		end
end
